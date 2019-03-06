# Learning:
# this Config is not triggered by the --config=simple passed via the command line
# it triggers once the defines match the values
#
# e.g. bazel test //... --define main=0
#
# The --config option only selects the appropriate calls which are stored in the .bazelrc

config_setting(
    name = "simple",
    define_values = {
            "main": "0"
    },
)

config_setting(
    name = "simple1",
    define_values = {
            "main": "1"
    },
)


cc_library(
    name = "main_0",
    srcs = glob(["src/main_0.c", "include/*.h"]),
    hdrs = glob(["include/*.h"]),
    strip_include_prefix = "include",
)

cc_library(
    name = "main_1",
    srcs = glob(["src/main_1.c", "include/*.h"]),
    hdrs = glob(["include/*.h"]),
    strip_include_prefix = "include",
)


cc_test(
    name = "foo_test",
    srcs = glob(["test/*.cpp", "test/*.h"]),
    deps = [
            "@gtest//:gtest",
            "@gtest//:gtest_main",
            ] + select({
                    ":simple" : [":main_0"] ,
                    ":simple1" : [":main_1"] ,
                })
)
