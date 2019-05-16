load(":explore_cc_toolchain.bzl", "explore")

cc_library(
    name = "lib",
    srcs = [
        "library.cpp",
        "library.h",
    ],
)

cc_binary(
    name = "main",
    srcs = ["main.cpp"],
    deps = [":lib"],
)

explore(
    name = "explore_lib",
    lib = ":lib",
)

explore(
    name = "explore_main",
    lib = ":main",
)
