cc_library(
    name = "other",
    srcs = ["other.cpp"],
)

cc_library(
    name = "lib",
    srcs = ["lib.cpp"],
)

cc_library(
    name = "lib_always",
    srcs = ["lib.cpp"],
    alwayslink = True,
)

cc_binary(
    name = "libmain.so",
    srcs = ["main.cpp"],
    deps = [
        ":lib",
        ":other",
    ],
)

cc_binary(
    name = "main",
    srcs = ["main.cpp"],
    deps = [
        ":lib",
        ":other",
    ],
)

cc_binary(
    name = "main_shared_always",
    srcs = ["main.cpp"],
    linkstatic = False,
    deps = [
        ":lib",
        ":other",
    ],
)

cc_binary(
    name = "main_always",
    srcs = ["main.cpp"],
    deps = [
        ":lib_always",
        ":other",
    ],
)

cc_binary(
    name = "main_shared",
    srcs = ["main.cpp"],
    linkstatic = False,
    deps = [
        ":lib_always",
        ":other",
    ],
)

cc_test(
    name = "test_target",
    srcs = ["main.cpp"],
    deps = [
        ":lib",
        ":other",
    ],
)

cc_test(
    name = "test_target_shared",
    srcs = ["main.cpp"],
    linkstatic = False,
    deps = [
        ":lib",
        ":other",
    ],
)

cc_test(
    name = "test_target_always",
    srcs = ["main.cpp"],
    deps = [
        ":lib_always",
        ":other",
    ],
)

cc_binary(
    name = "define_test",
    srcs = ["define_test.cpp"],
    defines = ["THIS_IS_A_DEFINE"],
)

cc_binary(
    name = "include_test",
    srcs = ["include_test.cpp"],
    deps = ["//cpp_tests/sub_package:header_library"],
)
