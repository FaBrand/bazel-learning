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

    tool_paths = [
        tool_path(
            name = "ar",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "compat-ld",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "cpp",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "dwp",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "gcc",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "gcov",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "ld",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "nm",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "objcopy",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "objdump",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "addr2line",
            path = "gcc/binwrapper",
        ),
        tool_path(
            name = "strip",
            path = "gcc/binwrapper",
        ),
    ]

    return [
        cc_common.create_cc_toolchain_config_info(
            ctx = ctx,
            toolchain_identifier = toolchain_identifier,
            host_system_name = host_system_name,
            target_system_name = target_system_name,
            compiler = compiler,
            abi_version = abi_version,
            abi_libc_version = abi_libc_version,
            target_cpu = target_cpu,
            target_libc = target_libc,
            tool_paths = tool_paths,
        ),
    ]

cc_toolchain_config = rule(
    implementation = _impl,
    provides = [CcToolchainConfigInfo],
)
