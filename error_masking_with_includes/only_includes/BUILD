cc_library(
    name = "only_includes",
    srcs = glob(["src/*.cpp"]),
    hdrs = glob(["include/**/*.h"]),
    copts = [
        "-Wextra",
        "-Wall",
        "-Wpedantic",
        "-Werror",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
)
