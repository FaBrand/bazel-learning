load(":cc_api_rules.bzl", "cc_bin", "cc_lib")

cc_lib(
    name = "lib",
    srcs = ["code.c"],
)

cc_bin(
    name = "main",
    srcs = ["main.c"],
    deps = [":lib"],
)
