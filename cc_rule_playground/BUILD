load("//:cc_api_rules.bzl", "cc_bin", "cc_lib")

cc_lib(
    name = "lib",
    srcs = ["lib.cpp"],
    deps = [],
)

cc_bin(
    name = "main",
    srcs = ["main.cpp"],
    deps = [":lib"],
)
