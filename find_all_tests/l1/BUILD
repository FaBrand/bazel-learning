cc_library(
    name = "l1",
    srcs = ["library1.cpp"],
    hdrs = ["library1.h"],
    strip_include_prefix = ".",
    visibility = ["//visibility:public"],
)

cc_test(
    name = "l1_test",
    srcs = ["test.cpp"],
    deps = [
        "l1",
        "@googletest//:gtest_main",
    ],
)
