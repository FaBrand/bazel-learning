load("//:rule_with_java.bzl", "rule_with_java")

# Using a custom rule
rule_with_java(
    name = "show_java_version",
)

# Using a genrule
gen_cmds = [
    "$(JAVABASE)/bin/java --version",
    "touch $@",
    "exit 1",
]

genrule(
    name = "show_java_version_with_genrule",
    srcs = [],
    outs = ["foo"],
    cmd = " && ".join(gen_cmds),
    toolchains = ["@bazel_tools//tools/jdk:current_host_java_runtime"],
)
