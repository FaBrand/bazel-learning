def _tool_user_impl(ctx):
    toolchain = ctx.toolchains["//:tool_toolchain"]
    out = ctx.actions.declare_file(ctx.label.name)
    args = ctx.actions.args()
    args.add(out)
    ctx.actions.run(
        inputs = [],
        executable = toolchain.tool_info.tool,
        arguments = [args],
        outputs = [out],
        mnemonic = "Tool",
        progress_message = "Running tool for {}".format(out.basename),
    )
    return DefaultInfo(files = depset([out]))

tool_user = rule(
    implementation = _tool_user_impl,
    attrs = {},
    toolchains = ["//:tool_toolchain"],
)
