load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")

PipeInfo = provider(fields = ["cc_info"])

def _filter_none(input_list):
    filtered_list = []
    for element in input_list:
        if element != None:
            filtered_list.append(element)
    return filtered_list

def _gen_comp_unit(ctx):
    src = ctx.actions.declare_file(ctx.label.name + ".cpp")
    hdr = ctx.actions.declare_file(ctx.label.name + ".h")
    ctx.actions.write(output = src, content = '#include "{}"'.format(hdr.basename))
    ctx.actions.write(output = hdr, content = "")
    return src, hdr

def _gen_code_impl(ctx):
    src, hdr = _gen_comp_unit(ctx)

    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )
    compilation_contexts = []
    linking_contexts = []
    for dep in ctx.attr.deps:
        if CcInfo in dep:
            compilation_contexts.append(dep[CcInfo].compilation_context)
            linking_contexts.append(dep[CcInfo].linking_context)

    (compilation_context, compilation_outputs) = cc_common.compile(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        public_hdrs = ctx.files.public_hdrs + [hdr],
        private_hdrs = ctx.files.private_hdrs,
        srcs = ctx.files.srcs + [src],
        includes = ctx.attr.includes + [src.dirname],
        quote_includes = ctx.attr.quote_includes,
        system_includes = ctx.attr.system_includes,
        defines = ctx.attr.defines,
        user_compile_flags = ctx.attr.user_compile_flags,
        compilation_contexts = compilation_contexts,
    )
    (linking_context, linking_outputs) = cc_common.create_linking_context_from_compilation_outputs(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        language = "c++",
        compilation_outputs = compilation_outputs,
        linking_contexts = linking_contexts,
    )

    files = []
    files.extend(compilation_outputs.objects)
    files.extend(compilation_outputs.pic_objects)

    library = linking_outputs.library_to_link

    if library:
        files.append(library.pic_static_library)
        files.append(library.static_library)
        files.append(library.dynamic_library)

    cc_info = CcInfo(
        compilation_context = compilation_context,
        linking_context = linking_context,
    )
    return [
        DefaultInfo(
            files = depset(_filter_none(files)),
        ),
        cc_info,
        PipeInfo(cc_info = cc_info),
    ]

gen_code = rule(
    implementation = _gen_code_impl,
    attrs = {
        "public_hdrs": attr.label_list(allow_files = [".h"]),
        "private_hdrs": attr.label_list(allow_files = [".h"]),
        "srcs": attr.label_list(allow_files = [".cc", ".cpp"]),
        "deps": attr.label_list(
            allow_empty = True,
            providers = [[CcInfo]],
        ),
        "user_compile_flags": attr.string_list(),
        "user_link_flags": attr.string_list(),
        "includes": attr.string_list(),
        "quote_includes": attr.string_list(),
        "system_includes": attr.string_list(),
        "defines": attr.string_list(),
        "alwayslink": attr.bool(default = False),
        "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
    },
    fragments = ["cpp"],
)

def _pipe_impl(ctx):
    return ctx.attr.src[PipeInfo].cc_info

pipe = rule(
    implementation = _pipe_impl,
    attrs = {
        "src": attr.label(providers = [PipeInfo]),
    },
)
