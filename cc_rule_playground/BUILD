load("//:cc_api_rules.bzl", "cc_bin", "cc_lib")
load("//:generator_and_builder.bzl", "gen_code", "pipe")

gen_code(
    name = "gen",
    deps = [],
)

pipe(
    name = "pip",
    src = ":gen",
)

cc_lib(
    name = "lib",
    srcs = ["lib.cpp"],
    deps = [":pip"],
)

cc_bin(
    name = "main",
    srcs = ["main.cpp"],
    deps = [":lib", ":gen"],
)
