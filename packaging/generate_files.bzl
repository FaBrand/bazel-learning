def _generate_files_impl(ctx):
    files = [
        "share/lib/foo",
        "share/bar",
        "lib/libfoo",
    ]

    out_files = [
        ctx.actions.declare_file("/".join([ctx.attr.prefix, f]))
        for f in files
    ]

    [
        ctx.actions.run_shell(
            inputs = [],
            outputs = [f],
            command = """
        out=$@;
        mkdir -p $(basename $out)
        touch $out
        """,
            arguments = [f.path],
        )
        for f in out_files
    ]

    return [DefaultInfo(files = depset(out_files))]

generate_files = rule(
    attrs = {
        "prefix": attr.string(),
    },
    implementation = _generate_files_impl,
)
