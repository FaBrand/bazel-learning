def _basic_test_impl(ctx):
    ctx.actions.write(output = ctx.outputs.executable, content = "/bin/true", is_executable = True)

basic_test = rule(
    attrs = {},
    executable = True,
    test = True,
    implementation = _basic_test_impl,
)

_with_context_content_template = """
{runner} {launch}
"""

def _with_context_test_impl(ctx):
    with_context_content = _with_context_content_template.format(
        runner = ctx.executable.runner.short_path,
        launch = ctx.file.launch.path,
    )

    ctx.actions.write(output = ctx.outputs.executable, content = with_context_content, is_executable = True)

    runfiles = ctx.runfiles(
        collect_data = True,
        # This part is redundant if the files are provided via the data attribute
        # Even though it can be necessary to distinguish between the different files.
        # However, transitive runfiles seem to be collected only from data, etc
        files = [ctx.file.launch] + ctx.files.runner,
    )

    return DefaultInfo(runfiles = runfiles)

with_context_test = rule(
    attrs = {
        # This is the important bit.
        # It has to be a label_list and named one-of ['data', 'srcs', 'hdrs']
        # In combination with collect_data = True, bazel collects the transitive runfiles
        # and sets them up at runtime
        "data": attr.label_list(
            allow_files = True,
        ),
        "runner": attr.label(
            executable = True,
            allow_files = True,
            cfg = "host",
        ),
        "launch": attr.label(
            allow_single_file = True,
        ),
    },
    executable = True,
    test = True,
    implementation = _with_context_test_impl,
)

with_default_context_test = rule(
    attrs = {
        # This can be defaulted, but overridden from the callside. So not very safe
        "data": attr.label_list(
            allow_files = True,
            default = ["//:py_runner"],
        ),
        # This could be scoped to private, but since i reuse the impl, i didn't do it
        "runner": attr.label(
            default = "//:py_runner",
            executable = True,
            allow_files = True,
            cfg = "host",
        ),
        "launch": attr.label(
            allow_single_file = True,
        ),
    },
    executable = True,
    test = True,
    implementation = _with_context_test_impl,
)
