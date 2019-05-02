cc_library(
    name = "lib",
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
