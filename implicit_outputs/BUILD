load(":implicit_outputs.bzl", "implicit_outputs")

implicit_outputs(
    name = "bar",
    out = "foobar.txt",
)

filegroup(
    name = "outs",
    srcs = [
        "foobar.txt",
    ],
)
