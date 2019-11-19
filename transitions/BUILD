load(":cc_api_rules.bzl", "cc_bin")
load(":consumer.bzl", "consumer")

cc_library(
    name = "header",
    hdrs = ["include/header.h"],
)

cc_library(
    name = "library_a",
    srcs = ["code.c"],
    deps = [":header"],
)

cc_library(
    name = "library_b",
    srcs = ["code.c"],
)

cc_bin(
    name = "variant_a",
    srcs = ["main.c"],
    # Sets transition with copts
    copt = ["-DVARIANTA"],
    deps = [":library_a"],
)

cc_bin(
    name = "variant_b",
    srcs = ["main.c"],
    # Sets transition with copts
    copt = ["-DVARIANTB"],
    deps = [":library_b"],
)

consumer(
    name = "consumer",
    srcs = [
        ":variant_a",
        ":variant_b",
    ],
)
