load(":tool_rule.bzl", "tool_user")
load(":toolchain_config.bzl", "toolchain_config")

#######################################################################
#                         Platform definition                         #
#######################################################################

constraint_setting(name = "target_constraint")

constraint_value(
    name = "value_a",
    constraint_setting = ":target_constraint",
)

platform(
    name = "linux_platform",
    constraint_values = [
        # To be more specific about which toolchain to use with a custom constraint
        # Avoid generic constraint values that match too widely
        # Bazel acts greedy here and takes the first toolchain that matches on the minimum set of constraint values
        # e.g. here toolchain_linux is selected even though `--platforms=//:custom_platform` is set

        # The combination of constraint choices that this platform comprises.
        # In order for a platform to apply to a given environment, the environment must have at least the values in this list.
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

platform(
    name = "custom_platform",
    constraint_values = [
        # To be more specific about which toolchain to use with a custom constraint
        # Avoid generic constraint values that match too widely
        # Bazel acts greedy here and takes the first toolchain that matches on the minimum set of constraint values
        # e.g. here toolchain_linux is selected even though `--platforms=//:custom_platform` is set

        # The combination of constraint choices that this platform comprises.
        # In order for a platform to apply to a given environment, the environment must have at least the values in this list.
        # "@platforms//os:linux",
        # "@platforms//cpu:x86_64",
        ":value_a",
    ],
    parents = [":linux_platform"],
)

#######################################################################
#                        The toolchain itself                         #
#######################################################################

toolchain_config(
    name = "tool_linux",
    tool = "@tool_linux//:tool",
)

toolchain_config(
    name = "tool_linux_custom",
    tool = "@tool_linux_custom//:tool",
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

toolchain(
    name = "tool_toolchain_linux_custom",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "//:value_a",
    ],
    toolchain = ":tool_linux_custom",
    toolchain_type = ":tool_toolchain",
)

#######################################################################
#                    The rule using the toolchain                     #
#######################################################################

tool_user(
    name = "product",
    target_compatible_with = [
        ":value_a",
    ],
)
