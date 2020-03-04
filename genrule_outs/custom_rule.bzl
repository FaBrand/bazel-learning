def _custom_rule_impl(ctx):
    pass

custom_rule = rule(
    implementation = _custom_rule_impl,
    attrs = {
    },
)
