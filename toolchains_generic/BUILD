load(":tool_rule.bzl", "tool_user")
load(":toolchain_config.bzl", "toolchain_config")

toolchain_config(
    name = "tool_linux",
    tool = "@tool_linux//:tool",
)

toolchain_config(
    name = "tool_windows",
    tool = "@tool_windows//:tool",
)

toolchain_type(name = "tool_toolchain")

toolchain(
    name = "tool_toolchain_linux",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":tool_linux",
    toolchain_type = ":tool_toolchain",
)

toolchain(
    name = "tool_toolchain_windows",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":tool_windows",
    toolchain_type = ":tool_toolchain",
)

tool_user(
    name = "product",
)
