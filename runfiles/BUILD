load(":custom_runfile.bzl", "custom_runfile")

custom_runfile(
    name = "example_json",
)

py_binary(
    name = "app",
    srcs = ["app.py"],
    data = [":example_json"],
)
