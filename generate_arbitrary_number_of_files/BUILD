package(
    default_visibility = ['//visibility:public']
)

load(":genccs.bzl", "genccs", "genlib")


genccs(
    name = "foo_gen",
    n = 5,
)

genlib(
    name = "foo_lib",
    n = 5,
)

cc_binary(
    name = "bar",
    srcs = ["src/main.cc", "foo_gen"],
)

cc_binary(
    name = "bar2",
    srcs = ["src/main.cc"],
    deps = [":foo_lib"]
)
