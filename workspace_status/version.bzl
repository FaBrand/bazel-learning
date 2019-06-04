def _gen_version_file_impl(ctx):
    out = ctx.actions.declare_file(ctx.attr.name)

    args = ctx.actions.args()

    args.add(ctx.info_file)
    args.add(ctx.version_file)
    args.add(out)

    ctx.actions.run_shell(
        outputs = [out],
        inputs = [ctx.info_file, ctx.version_file],
        arguments = [args],
        command = "cat $1 $2 > $3",
    )

    return [DefaultInfo(files = depset([out])), OutputGroupInfo(version = [out])]

gen_version_file = rule(
    attrs = {},
    implementation = _gen_version_file_impl,
)
