load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "variable_with_value",
    "with_feature_set",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def declare_actions():
    cpp_link_nodeps_dynamic_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_nodeps_dynamic_library,
        implies = [
            # Not for gcc
            # "nologo",
            "shared_flag",
            # "linkstamps",
            "runtime_library_search_directories",
            "output_execpath_flags",
            "input_param_flags",
            "user_link_flags",
            "default_link_flags",
            # Not for gcc
            # "linker_subsystem_flag",
            "linker_param_file",
            "gcc_env",
            "no_stripping",
            # Not for gcc
            # "has_configured_linker_path",
            # Not for gcc
            # "def_file",
            "strip_debug_symbols",
        ],
        tools = [tool(path = "external/gcc/usr/bin/gcc")],
    )

    cpp_link_static_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_static_library,
        implies = [
            # Not for gcc
            # "nologo",
            "archiver_flags",
            "input_param_flags",
            "linker_param_file",
            "gcc_env",
        ],
        tools = [tool(path = "external/gcc/usr/bin/ar")],
    )

    # assemble_action = action_config(
    #     action_name = ACTION_NAMES.assemble,
    #     implies = [
    #         "compiler_input_flags",
    #         "compiler_output_flags",
    #         # Not for gcc
    #         # "nologo",
    #         "gcc_env",
    #         "sysroot",
    #     ],
    #     tools = [tool(path = "external/gcc/usr/bin/as")],
    # )

    # preprocess_assemble_action = action_config(
    #     action_name = ACTION_NAMES.preprocess_assemble,
    #     implies = [
    #         "compiler_input_flags",
    #         "compiler_output_flags",
    #         # Not for gcc
    #         # "nologo",
    #         "gcc_env",
    #         "sysroot",
    #     ],
    #     tools = [tool(path = "external/gcc/usr/bin/gcc")],
    # )

    c_compile_action = action_config(
        action_name = ACTION_NAMES.c_compile,
        implies = [
            "compiler_input_flags",
            "compiler_output_flags",
            "default_compile_flags",
            # Not for gcc
            # "nologo",
            "gcc_env",
            # Not for gcc
            # "parse_showincludes",
            "preprocessor_defines",
            "include_paths",
            "user_compile_flags",
            "sysroot",
            "unfiltered_compile_flags",
        ],
        tools = [tool(path = "external/gcc/usr/bin/gcc")],
    )

    cpp_compile_action = action_config(
        action_name = ACTION_NAMES.cpp_compile,
        implies = [
            "compiler_input_flags",
            "compiler_output_flags",
            "default_compile_flags",
            # Not for gcc
            # "nologo",
            "gcc_env",
            # Not for gcc
            # "parse_showincludes",
            "user_compile_flags",
            "sysroot",
            "unfiltered_compile_flags",
            "preprocessor_defines",
            "include_paths",
        ],
        tools = [tool(path = "external/gcc/usr/bin/g++")],
    )

    cpp_link_executable_action = action_config(
        action_name = ACTION_NAMES.cpp_link_executable,
        implies = [
            # Not for gcc
            # "nologo",
            # "linkstamps",
            "runtime_library_search_directories",
            "output_execpath_flags",
            "input_param_flags",
            "user_link_flags",
            "default_link_flags",
            "strip_debug_symbols",
            # Not for gcc
            # "linker_subsystem_flag",
            "linker_param_file",
            "gcc_env",
            "no_stripping",
        ],
        tools = [tool(path = "external/gcc/usr/bin/gcc")],
    )

    cpp_link_dynamic_library_action = action_config(
        action_name = ACTION_NAMES.cpp_link_dynamic_library,
        implies = [
            # Not for gcc
            # "nologo",
            "shared_flag",
            # "linkstamps",
            "output_execpath_flags",
            "input_param_flags",
            "user_link_flags",
            "default_link_flags",
            # Not for gcc
            # "linker_subsystem_flag",
            "linker_param_file",
            "gcc_env",
            "no_stripping",
            # Not for gcc
            # "has_configured_linker_path",
            # Not for gcc
            # "def_file",
        ],
        tools = [tool(path = "external/gcc/usr/bin/gcc")],
    )

    return [
        # assemble_action,
        # preprocess_assemble_action,
        c_compile_action,
        cpp_compile_action,
        cpp_link_executable_action,
        cpp_link_dynamic_library_action,
        cpp_link_nodeps_dynamic_library_action,
        cpp_link_static_library_action,
    ]
