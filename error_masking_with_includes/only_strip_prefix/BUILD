cc_library(
    name = "only_strip_prefix",
    srcs = glob(["src/*.cpp"]),
    hdrs = glob(["include/**/*.h"]),
    copts = [
        "-Wextra",
        "-Wall",
        "-Wpedantic",
        "-Werror",
    ],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
