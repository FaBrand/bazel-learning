"""
gcc config
"""

load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "with_feature_set",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    toolchain_identifier = "gcc_8"
    host_system_name = "x86_64"
    target_system_name = "target"
    target_cpu = "x86_64"
    target_libc = "glibc_2.26"
    compiler = "gcc"
    abi_version = "gcc"
    abi_libc_version = "glibc_2.26"
    cc_target_os = None
    builtin_sysroot = None

    sysroot_feature = feature(
        name = "sysroot",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                    ACTION_NAMES.cpp_link_executable,
                    ACTION_NAMES.cpp_link_dynamic_library,
                    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                ],
                flag_groups = [
                    flag_group(
                        flags = ["--sysroot=%{sysroot}"],
                        expand_if_available = "sysroot",
                    ),
                ],
            ),
        ],
    )

    toolchain_include_directories_feature = feature(
        name = "toolchain_include_directories",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-isystem",
                            "%{sysroot}/usr/include/c++/8",
                            "-isystem",
                            "%{sysroot}/usr/include/c++/8/backward",
                            "-isystem",
                            "%{sysroot}/usr/include/x86_64-linux-gnu",
                            "-isystem",
                            "%{sysroot}/usr/include/x86_64-linux-gnu/c++/8",
                            "-isystem",
                            "%{sysroot}/usr/lib/gcc/x86_64-linux-gnu/8/include",
                            "-isystem",
                            "%{sysroot}/usr/include",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_link_executable,
                    ACTION_NAMES.cpp_link_dynamic_library,
                    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-lstdc++",
                        ],
                    ),
                ],
            ),
        ],
    )

    features = [
        default_link_flags_feature,
        sysroot_feature,
        toolchain_include_directories_feature,
    ]

    tool_paths = [
        tool_path(
            name = "ar",
            path = "gcc/ar",
        ),
        tool_path(
            name = "compat-ld",
            path = "/bin/false",
        ),
        tool_path(
            name = "cpp",
            path = "gcc/cpp",
        ),
        tool_path(
            name = "dwp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcc",
            path = "gcc/gcc-tool",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "ld",
            path = "gcc/ld",
        ),
        tool_path(
            name = "nm",
            path = "gcc/nm",
        ),
        tool_path(
            name = "objcopy",
            path = "gcc/objcopy",
        ),
        tool_path(
            name = "objdump",
            path = "gcc/objdump",
        ),
        tool_path(
            name = "addr2line",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/bin/false",
        ),
    ]

    cxx_builtin_include_directories = [
        "%sysroot%/usr/include/c++/8",
        "%sysroot%/usr/include/x86_64-linux-gnu",
        "%sysroot%/usr/include/c++/8/backward",
        "%sysroot%/usr/lib/gcc/x86_64-linux-gnu/8/include",
        "%sysroot%/usr/include/x86_64-linux-gnu/c++/8",
    ]

    return [
        cc_common.create_cc_toolchain_config_info(
            ctx = ctx,
            cxx_builtin_include_directories = cxx_builtin_include_directories,
            toolchain_identifier = toolchain_identifier,
            host_system_name = host_system_name,
            target_system_name = target_system_name,
            compiler = compiler,
            abi_version = abi_version,
            abi_libc_version = abi_libc_version,
            target_cpu = target_cpu,
            target_libc = target_libc,
            tool_paths = tool_paths,
            features = features,
            builtin_sysroot = "external/gcc",
        ),
    ]

cc_toolchain_config = rule(
    implementation = _impl,
    provides = [CcToolchainConfigInfo],
)
