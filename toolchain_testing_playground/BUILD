load(":gcc_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all_files",
    srcs = glob(["gcc/*"]) + ["@gcc//:all_files"],
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
    name = "cc-toolchain-x64_linux_gcc",
    all_files = ":all_files",
    ar_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":empty",
    linker_files = ":all_files",
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

cc_library(
    name = "other",
    srcs = [],
)

cc_library(
    name = "lib",
    srcs = ["lib.cpp"],
)

cc_binary(
    name = "main",
    srcs = ["main.cpp"],
    deps = [
        ":lib",
        ":other",
    ],
)

# vim: set tabstop=4 softtabstop=4 shiftwidth=4 expandtab ft=bzl:
