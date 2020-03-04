VersionInfo = provider(fields = ["version"])

def _version_config_impl(ctx):
    return VersionInfo(version = ctx.build_setting_value)

version_config = rule(
    implementation = _version_config_impl,
    build_setting = config.string(flag = True),
)

def _custom_rule_impl(ctx):
    print(ctx.attr.version[VersionInfo].version)

custom_rule = rule(
    implementation = _custom_rule_impl,
    attrs = {
        "version": attr.label(
            providers = [VersionInfo],
            mandatory = True,
        ),
    },
)
