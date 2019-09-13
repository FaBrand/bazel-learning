load(":gcc_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all_files",
    srcs = [
        "gcc/binwrapper",
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain_config(
    name = "cc-toolchain-config",
)

cc_toolchain(
    name = "cc-gcc",
    all_files = ":all_files",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 1,
    toolchain_config = ":cc-toolchain-config",
    visibility = ["//visibility:public"],
)

cc_toolchain_suite(
    name = "cc-toolchain",
    toolchains = {
        "k8": ":cc-gcc",
    },
)

cc_binary(
    name = "main",
    srcs = ["main.cpp"],
)

# vim: set tabstop=4 softtabstop=4 shiftwidth=4 expandtab ft=bzl:
