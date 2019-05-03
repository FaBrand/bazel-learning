def _rule_env_impl(ctx):
    exe = ctx.actions.declare_file(ctx.attr.name)
    args = ctx.actions.args()
    args.add(exe)
    ctx.actions.run_shell(
        inputs = [],
        outputs = [exe],
        command = """
        set -x
        printenv
        echo "single variables"
        printenv action_env_variable_with_value
        printenv action_env_variable_without_value
        printenv action_env_variable_only_defined
        echo "/bin/true" > $1
        """,
        env = {
            "ACTION_ENV_VARIABLE_WITH_VALUE": "",
            "ACTION_ENV_VARIABLE_WITHOUT_VALUE": "",
            "ACTION_ENV_VARIABLE_ONLY_DEFINED": "",
        },
        arguments = [args],
    )
    return DefaultInfo(executable = exe)

rule_env = rule(
    executable = True,
    implementation = _rule_env_impl,
)
