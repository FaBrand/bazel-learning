load(":custom_rule.bzl", "custom_rule", "version_config")

version_config(
    name = "version",
    build_setting_default = "123",
)

custom_rule(
    name = "foo",
    version = ":version",
)
