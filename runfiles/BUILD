load(":runfile.bzl", "runfile")

runfile(
    name = "runfile",
)

py_binary(
    name = "app",
    srcs = ["app.py"],
    data = [":runfile"],
)
