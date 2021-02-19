ToolchainInfo = provider()

def _toolchain_config_impl(ctx):
    return platform_common.ToolchainInfo(
        tool_info = ToolchainInfo(
            tool = ctx.executable.tool,
        ),
    )

toolchain_config = rule(
    implementation = _toolchain_config_impl,
    attrs = {
        "tool": attr.label(
            mandatory = True,
            cfg = "exec",
            executable = True,
        ),
    },
)
