def _basic_test_impl(ctx):
    ctx.actions.write(output = ctx.outputs.executable, content = "/bin/true", is_executable = True)

basic_test = rule(
    attrs = {},
    executable = True,
    test = True,
    implementation = _basic_test_impl,
)

_with_context_content_template = """
{runner}
"""

def _with_context_test_impl(ctx):
    with_context_content = _with_context_content_template.format(runner = ctx.executable.runner.short_path)

    ctx.actions.write(output = ctx.outputs.executable, content = with_context_content, is_executable = True)

    runfiles = ctx.runfiles(collect_data = True, files = ctx.files.runner)

    return DefaultInfo(runfiles = runfiles)

with_context_test = rule(
    attrs = {
        "data": attr.label_list(
            allow_files = True,
        ),
        "runner": attr.label(
            executable = True,
            allow_files = True,
            cfg = "host",
        ),
    },
    executable = True,
    test = True,
    implementation = _with_context_test_impl,
)
