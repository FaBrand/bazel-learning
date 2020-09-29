load(":workspace_name_var.bzl", "workspace_name_var")

py_binary(
    name = "binary",
    srcs = ["binary.py"],
)

workspace_name_var(
    name = "workspace_name",
)

py_binary(
    name = "foo",
    srcs = ["//:binary"],
    args = [
        "$(WORKSPACE_NAME)",
        "$(location //input:file)",
        "$(location @ext//:file)",
        "$(location //generated)",
    ],
    data = [
        "//generated",
        "//input:file",
        "@ext//:file",
    ],
    main = "binary.py",
    toolchains = [":workspace_name"],
    deps = [
        "@rules_python//python/runfiles",
    ],
)
