load("//:setting.bzl", "FlavorProvider")

def _ice_cream_machine_impl(ctx):
    flavor = ctx.attr.flavor[FlavorProvider].type

    out = ctx.actions.declare_file(flavor + ".icecream")

    ctx.actions.write(
        output = out,
        content = "\n".join(["I am a", flavor, "ice cream cone"]),
    )

    return DefaultInfo(files = depset(direct = [out]))

ice_cream_machine = rule(
    implementation = _ice_cream_machine_impl,
    attrs = {
        "flavor": attr.label(),
    },
)
