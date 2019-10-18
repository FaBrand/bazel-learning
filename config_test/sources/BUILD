config_setting(
    name = "succeed",
    define_values = {
        "test_outcome": "succeed",
    },
)

config_setting(
    name = "fail",
    define_values = {
        "test_outcome": "fail",
    },
)

config_setting(
    name = "override",
    define_values = {
        "override": "",
    },
)

cc_library(
    name = "succeding_test",
    srcs = glob(["src/main_0.c", "include/*.h"]),
    hdrs = glob(["include/*.h"]),
    strip_include_prefix = "include",
)

cc_library(
    name = "failing_test",
    srcs = glob(["src/main_1.c", "include/*.h"]),
    hdrs = glob(["include/*.h"]),
    strip_include_prefix = "include",
)

cc_library(
    name = "other_failing_test",
    srcs = glob(["src/main_2.c", "include/*.h"]),
    hdrs = glob(["include/*.h"]),
    strip_include_prefix = "include",
)

cc_library(
    name = "default_proxy",
    deps = select({
        ":succeed": [":succeding_test"],
        ":fail": [":failing_test"],
    }),
)
cc_library(
    name = "override_proxy",
    deps = select({
        ":succeed": [":other_failing_test"],
        ":fail": [":other_failing_test"],
    }),
)

cc_test(
    name = "foo_test",
    srcs = glob(["test/*.cpp", "test/*.h"]),
    deps = [
        "@gtest//:gtest",
        "@gtest//:gtest_main",
    ] + select({
        ":override": [":override_proxy"],
        "//conditions:default": [":default_proxy"],
    }),
)
