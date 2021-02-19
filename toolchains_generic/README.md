# Objective

To check if bazel actually fetches the tool dependent on the resolved toolchain

# Observation

Bazel does only fetch the toolchain that is resolved

# Learnings

Be as specific as possible with toolchain constraints. If atleast one constraint does match, that toolchain is selected.

This seems strange
From the [docs of constraint values](https://docs.bazel.build/versions/master/be/platform.html#platform.constraint_values):

 > In order for a platform to apply to a given environment, the environment must have at least the values in this list.

The toolchain resolution log shows that for `bazel build product --platforms //:custom_platform`
The less specific toolchain is selected:

```
INFO: ToolchainResolution:     Type //:tool_toolchain: target platform //:custom_platform: Rejected toolchain //:tool_windows; mismatching values: windows
INFO: ToolchainResolution:   Type //:tool_toolchain: target platform //:custom_platform: execution @local_config_platform//:host: Selected toolchain //:tool_linux
INFO: ToolchainResolution: Target platform //:custom_platform: Selected execution platform @local_config_platform//:host, type //:tool_toolchain -> toolchain //:tool_linux
```

Given this scenario:
```python
platform(
    name = "custom_platform",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        ":value_a",
    ],
)

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
    name = "tool_toolchain_linux_custom",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
        "//:value_a",
    ],
    toolchain = ":tool_linux_custom",
    toolchain_type = ":tool_toolchain",
)
```

If a build with `--platforms //:custom_platform` one would assume that the toolchain selected with the compatible target platform
does have atleast all constraint values defined in the platform.

The expectation is that bazel would select the toolchain `tool_linux_custom`

However bazel selects a toolchain that matches only a subset of the constraint_values

```
INFO: ToolchainResolution:     Type //:tool_toolchain: target platform //:custom_platform: Rejected toolchain //:tool_windows; mismatching values: windows
INFO: ToolchainResolution:   Type //:tool_toolchain: target platform //:custom_platform: execution @local_config_platform//:host: Selected toolchain //:tool_linux
INFO: ToolchainResolution: Target platform //:custom_platform: Selected execution platform @local_config_platform//:host, type //:tool_toolchain -> toolchain //:tool_linux
```


Only in this scenario the custom toolchain is selected. It is therefore not possible to combine the target platforms.
```python
platform(
    name = "custom_platform",
    constraint_values = [
        ":value_a",
    ],
)

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
```


Seperating the os:linux and cpu constraint into a parent platform does yield the same seemingly wrong behaviour (`tool_linux` is selected instead of `tool_linux_custom`)
```python
platform(
    name = "linux_platform",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

platform(
    name = "custom_platform",
    constraint_values = [
        ":value_a",
    ],
    parents = [":linux_platform"],
)
```
