def _implicit_outputs_impl(ctx):
    ctx.actions.write(output = ctx.outputs.out, content = "foobar")

implicit_outputs = rule(
    implementation = _implicit_outputs_impl,
    attrs = {
        "out": attr.output(),
    },
)
