load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")
load(":transition_rule.bzl", "cc_transition")

cc_library(
    name = "foo",
    srcs = ["code.c"],
    hdrs = ["code.h"],
)

cc_transition(
    name = "baz",
    copt = ["-DOUTPUT=3"],
    deps = [":foo"],
)

# This test fails with a NullPointerException
cc_test(
    name = "bar",
    srcs = ["test.cpp"],
    defines = ["EXPECTED=3"],
    linkstatic = 1,
    deps = [
        ":baz",
        "@googletest//:gtest_main",
    ],
)

cc_test(
    name = "foobar",
    srcs = ["test.cpp"],
    defines = ["EXPECTED=0"],
    deps = [
        ":foo",
        "@googletest//:gtest_main",
    ],
)
