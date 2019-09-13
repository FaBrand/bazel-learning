load(":cc_config.bzl", "cc_toolchain_config")

filegroup(
    name = "toolchain",
    srcs = [
        ":all_files",
        ":cc-compiler-x86_64",
    ],
)

filegroup(
    name = "all_files",
    srcs = [
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "linker_files",
    srcs = [
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
    ],
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
    compiler_files = ":compiler_files",
    dwp_files = ":empty",
    linker_files = ":linker_files",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 1,
    toolchain_config = ":cc-toolchain-config",
    visibility = ["//visibility:public"],
)

# vim: set tabstop=4 softtabstop=4 shiftwidth=4 expandtab ft=bzl:
