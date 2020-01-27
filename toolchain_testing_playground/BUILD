load(":gcc_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain_config(
    name = "cc-toolchain-config",
)

cc_toolchain(
    name = "cc-toolchain-x64_linux_gcc",
    all_files = "empty",
    ar_files = "@gcc//:ar_files",
    compiler_files = "@gcc//:compiler_files",
    dwp_files = ":empty",
    linker_files = "@gcc//:all_files",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 1,
    toolchain_config = ":cc-toolchain-config",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "cc-x64_linux_gcc",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc-toolchain-x64_linux_gcc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

# vim: set tabstop=4 softtabstop=4 shiftwidth=4 expandtab ft=bzl:
