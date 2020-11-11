def _runfiles_mapper_impl(ctx):
    runfiles = ctx.runfiles(
        symlinks = {path: lbl.files.to_list()[0] for lbl, path in ctx.attr.files.items()},
        root_symlinks = {path: lbl.files.to_list()[0] for lbl, path in ctx.attr.root_files.items()},
    )
    return DefaultInfo(runfiles = runfiles)

runfiles_mapper = rule(
    implementation = _runfiles_mapper_impl,
    attrs = {
        "root_files": attr.label_keyed_string_dict(allow_files = True),
        "files": attr.label_keyed_string_dict(allow_files = True),
    },
)
