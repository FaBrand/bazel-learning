load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")
load("//output_dir_names:transition_rule.bzl", "cc_transition")
load("//output_dir_names:cc_api_rules.bzl", "cc_bin")

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

cc_transition(
    name = "foobaz",
    copt = ["-DOUTPUT=4"],
    deps = [":foo"],
)

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

cc_test(
    name = "foobaz_test",
    srcs = ["test.cpp"],
    defines = ["EXPECTED=4"],
    linkstatic = 1,
    deps = [
        ":foobaz",
        "@googletest//:gtest_main",
    ],
)

cc_bin(
    name = "main",
    srcs = ["main.c"],
)
