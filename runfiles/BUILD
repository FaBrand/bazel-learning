load(":runfile.bzl", "default_runfile", "runfile")

runfile(
    name = "runfile",
)

default_runfile(
    name = "default_runfile",
)

py_binary(
    name = "app",
    srcs = ["app.py"],
    data = [
        ":default_runfile",
        ":runfile",
    ],
)
