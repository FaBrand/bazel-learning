cc_library(
    name = "l3",
    srcs = ["library3.cpp"],
    hdrs = ["library3.h"],
    strip_include_prefix = ".",
    visibility = ["//visibility:public"],
)

cc_test(
    name = "l3_test",
    srcs = ["test.cpp"],
    deps = [
        "l3",
        "@googletest//:gtest_main",
    ],
)
