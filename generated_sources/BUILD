load("//:rule.bzl", "generator")

generator(
    name = "gen",
)

cc_library(
    name = "lib",
    srcs = ["source.c"],
    deps = [
        ":gen",
        "//generated",
    ],
)
