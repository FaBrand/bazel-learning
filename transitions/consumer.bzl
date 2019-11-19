def _consumer_impl(ctx):
    content = "\n".join(["REM " + f.path for f in ctx.files.srcs])

    out = ctx.actions.declare_file(ctx.label.name + ".bat")
    ctx.actions.write(output = out, content = content)

    runfiles = ctx.runfiles(files = ctx.files.srcs)

    return DefaultInfo(
        executable = out,
        runfiles = runfiles,
        files = depset(direct = [out]),
    )

consumer = rule(
    implementation = _consumer_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
    },
    executable = True,
)
