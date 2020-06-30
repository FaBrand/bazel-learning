FlavorProvider = provider(fields = ["type"])

def _impl(ctx):
    return FlavorProvider(type = ctx.build_setting_value)

flavor = rule(
    implementation = _impl,
    build_setting = config.string(flag = True),
)
