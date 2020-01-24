genrule(
    name = "generated_script",
    srcs = [],
    outs = ["generated.bash"],
    cmd_bash = "echo 'echo \"running generated\"' > $@",
)

sh_binary(
    name = "callable_shell",
    srcs = ["shell_binary.bash"],
    args = [
        "$(location other_script.bash)",
        "$(location generated_script)",
    ],
    data = [
        "other_script.bash",
        ":generated_script",
    ],
)
