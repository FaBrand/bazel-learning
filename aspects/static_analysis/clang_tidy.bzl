"""
clang-tidy
"""

load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")
load("//:legacy_cc_provider.bzl", "get_compile_flags")
load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "CPP_COMPILE_ACTION_NAME",
    "C_COMPILE_ACTION_NAME",
)

ClangTidyInfo = provider()

_source_extensions = [
    "cc",
    "cpp",
    "cxx",
    "h",
    "hpp",
    "hh",
]

def _is_cpp_target(srcs):
    for src in srcs.to_list():
        for extension in _source_extensions:
            if src.extension == extension:
                return True
    return False

def _get_compile_flags(ctx, target, srcs):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
    )
    compile_variables = cc_common.create_compile_variables(
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        user_compile_flags = ctx.fragments.cpp.copts,
    )
    compiler_options = cc_common.get_memory_inefficient_command_line(
        feature_configuration = feature_configuration,
        action_name = C_COMPILE_ACTION_NAME,
        variables = compile_variables,
    )

    # This is useful for compiling .h headers as C++ code.
    force_cpp_mode_option = ""
    if _is_cpp_target(srcs):
        compile_variables = cc_common.create_compile_variables(
            feature_configuration = feature_configuration,
            cc_toolchain = cc_toolchain,
            user_compile_flags = ctx.fragments.cpp.cxxopts +
                                 ctx.fragments.cpp.copts,
            add_legacy_cxx_options = True,
        )
        compiler_options = cc_common.get_memory_inefficient_command_line(
            feature_configuration = feature_configuration,
            action_name = CPP_COMPILE_ACTION_NAME,
            variables = compile_variables,
        )
        force_cpp_mode_option = " -x c++"

    compile_flags = (compiler_options +
                     get_compile_flags(target) +
                     (ctx.rule.attr.copts if hasattr(ctx.rule.attr, "copts") else []))

    # Unknown compiler flags by clang - disable those.
    compile_flags.remove("-fno-canonical-system-headers")
    compile_flags.remove("-Wno-free-nonheap-object")
    compile_flags.remove("-Wunused-but-set-parameter")
    compile_flags.append(force_cpp_mode_option)

    return compile_flags

def _invoke_clang_tidy(target, ctx):
    srcs = depset(
        direct =
            getattr(ctx.rule.files, "srcs", []) +
            getattr(ctx.rule.files, "hdrs", []),
    )

    if not srcs:
        return []

    analysis_results = ctx.actions.declare_file(ctx.rule.attr.name + ".clang-tidy.out")

    args = ctx.actions.args()
    args.add(ctx.executable._clang_tidy)
    args.add(analysis_results)

    args.add("-header-filter=.*")

    # Deactivate header guard, since it will report false findings caused by the execution path of bazel.

    checks = "-checks=" + ctx.var.get("checks", "*,-llvm-header-guard")
    args.add(checks)

    args.add("-format-style=file")

    if (ctx.var.get("fix")):
        args.add("-fix")
        args.add("-fix-errors")

    args.add_all(srcs)

    args.add("--")
    args.add_all(_get_compile_flags(ctx, target, srcs))

    visible_headers = target[CcInfo].compilation_context.headers
    ctx.actions.run(
        inputs = depset(transitive = [srcs, visible_headers]),
        executable = ctx.executable._command_wrapper,
        tools = [ctx.executable._clang_tidy],
        outputs = [analysis_results],
        arguments = [args],
        progress_message = "Running clang-tidy on " + ", ".join([src.short_path for src in srcs.to_list()]),
        mnemonic = "ClangTidy",
    )
    return [analysis_results]

def _clang_tidy_aspect_impl(target, ctx):
    srcs_results = []
    if CcInfo in target:
        srcs_results = _invoke_clang_tidy(target, ctx)

    rule_results = depset(
        direct = srcs_results,
        transitive = [dep[ClangTidyInfo].results for dep in ctx.rule.attr.deps] if hasattr(ctx.rule.attr, "deps") else [],
    )
    return [
        ClangTidyInfo(results = rule_results),
        OutputGroupInfo(ctidy = rule_results),
    ]

clang_tidy_aspect = aspect(
    attr_aspects = ["deps"],
    attrs = {
        "_cc_toolchain": attr.label(
            default = Label("@bazel_tools//tools/cpp:current_cc_toolchain"),
        ),
        "_clang_tidy": attr.label(
            default = Label("@clang//:clang_tidy"),
            executable = True,
            cfg = "host",
        ),
        "_command_wrapper": attr.label(
            default = Label("//static_analysis:command_wrapper"),
            executable = True,
            cfg = "host",
        ),
    },
    fragments = ["cpp"],
    required_aspect_providers = [ClangTidyInfo],
    implementation = _clang_tidy_aspect_impl,
)

def _clang_tidy_impl(ctx):
    results = depset(transitive = [target[ClangTidyInfo].results for target in ctx.attr.targets])

    args = ctx.actions.args()
    args.add_all(results)

    out = ctx.actions.declare_file(ctx.attr.name)
    ctx.actions.run_shell(
        inputs = results.to_list(),
        command = "cat $@ > " + out.path,
        outputs = [out],
        arguments = [args],
        progress_message = "Concatenating ClangTidy results",
        mnemonic = "ClangTidyConcat",
    )
    return [DefaultInfo(files = depset([out]))]

clang_tidy = rule(
    attrs = {
        "targets": attr.label_list(
            aspects = [clang_tidy_aspect],
            doc = "List of all cc targets which should be included.",
        ),
    },
    implementation = _clang_tidy_impl,
)
