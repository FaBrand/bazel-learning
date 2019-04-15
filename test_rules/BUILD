load(":test_rule.bzl", "basic_test", "with_context_test")

basic_test(
    name = "basic_test",
)

py_binary(
    name = "py_runner",
    srcs = [":py_runner.py"],
    deps = ["//some_important_py_lib"],
)

with_context_test(
    name = "with_context_and_py_runner",
    data = [
        ":py_runner",
    ],
    launch = ":launchfile",
    runner = ":py_runner",
)

filegroup(
    name = "launchfile",
    srcs = ["launchfile.test"],
)

filegroup(
    name = "schemas",
    srcs = [
        "schema_a.scm",
        "schema_b.scm",
    ],
)

sh_test(
    name = "sh_runner",
    srcs = ["sh_runner.sh"],
    args = [
        "$(location :py_runner)",
        "$(location :launchfile)",
        "$(locations :schemas)",
    ],
    data = [
        ":launchfile",
        ":py_runner",
        ":schemas",
    ],
)
