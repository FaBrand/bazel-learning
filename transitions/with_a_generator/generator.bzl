def _generator_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".cpp")

    ctx.actions.run(
        inputs = [],
        executable = ctx.executable._tool,
        arguments = [ctx.attr.content, out.path],
        outputs = [out],
        mnemonic = "RunTool",
        progress_message = "generating {}".format(out.basename),
    )

    return DefaultInfo(files = depset([out]))

generator = rule(
    implementation = _generator_impl,
    attrs = {
        "content": attr.string(),
        "_tool": attr.label(
            cfg = "host",
            executable = True,
            allow_single_file = True,
            default = "//with_a_generator:generator.sh",
        ),
    },
)
