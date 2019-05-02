cc_library(
    name = "l2",
    srcs = ["library2.cpp"],
    hdrs = ["library2.h"],
    strip_include_prefix = ".",
    visibility = ["//visibility:public"],
)

cc_test(
    name = "l2_test",
    srcs = ["test.cpp"],
    deps = [
        "l2",
        "@googletest//:gtest_main",
    ],
)
