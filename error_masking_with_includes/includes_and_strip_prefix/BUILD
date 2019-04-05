cc_library(
    name = "includes_and_strip_prefix",
    srcs = glob(["src/*.cpp"]),
    hdrs = glob(["include/**/*.h"]),
    copts = [
        "-Wextra",
        "-Wall",
        "-Wpedantic",
        "-Werror",
    ],
    includes = ["include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
