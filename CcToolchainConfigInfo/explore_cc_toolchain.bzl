load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain")
load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "CPP_COMPILE_ACTION_NAME",
    "CPP_LINK_DYNAMIC_LIBRARY_ACTION_NAME",
    "C_COMPILE_ACTION_NAME",
)

def explore_object(obj):
    print("=" * 80)
    print(obj)
    print(dir(obj))
    for attr in dir(obj):
        print(attr, "-", getattr(obj, attr, None))
    print("=" * 80)

def _explore_impl(ctx):
    lib = ctx.attr.lib
    tc = find_cpp_toolchain(ctx)
    print("Toolchain:")
    explore_object(tc)

    feature_configuration = cc_common.configure_features(
        cc_toolchain = tc,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )
    print("Feature configuration:")
    explore_object(feature_configuration)

    compile_variables = cc_common.create_compile_variables(
        feature_configuration = feature_configuration,
        cc_toolchain = tc,
        user_compile_flags = ctx.fragments.cpp.copts,
    )
    print("Compile variables:")
    explore_object(compile_variables)

    compiler_options = cc_common.get_memory_inefficient_command_line(
        feature_configuration = feature_configuration,
        action_name = CPP_COMPILE_ACTION_NAME,
        variables = compile_variables,
    )
    print("Compiler options:")
    explore_object(compiler_options)

    compiler = str(
        cc_common.get_tool_for_action(
            feature_configuration = feature_configuration,
            action_name = CPP_COMPILE_ACTION_NAME,
        ),
    )
    print("Compiler:")
    explore_object(compiler)

explore = rule(
    attrs = {
        "lib": attr.label(),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
    },
    fragments = ["cpp"],
    implementation = _explore_impl,
)
