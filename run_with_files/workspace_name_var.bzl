def _workspace_name_var_impl(ctx):
    return [
        platform_common.TemplateVariableInfo({
            "WORKSPACE_NAME": ctx.workspace_name,
        }),
    ]

workspace_name_var = rule(
    implementation = _workspace_name_var_impl,
    attrs = {},
)
