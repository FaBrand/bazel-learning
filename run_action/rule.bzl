_WINDOWS_RUNNER = """
echo "Hello Windows"
echo 1 > {output}
"""
_LINUX_RUNNER = """
echo "Hello Linux"
echo 1 > {output}
"""

def _runner_impl(ctx):
    is_windows = select({
        "@platforms//os:windows": True,
        "//conditions:default": False,
    })
    runner = ctx.actions.declare_file(ctx.label.name + (".bat" if is_windows else ".sh"))
    generated_file = ctx.actions.declare_file(ctx.label.name + ".output")

    runner_content = _WINDOWS_RUNNER if is_windows else _LINUX_RUNNER

    ctx.actions.write(
        output = runner,
        content = runner_content.format(output = generated_file.path),
    )

    ctx.actions.run(
        executable = runner,
        outputs = [generated_file],
    )

    return DefaultInfo(files = depset([generated_file]))

_runner = rule(
    implementation = _runner_impl,
    attrs = {
    },
)

def runner(name, **kwargs):
    _runner(
        name = name,
        **kwargs
    )
