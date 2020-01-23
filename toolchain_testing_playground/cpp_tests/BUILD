cc_library(
    name = "other",
    srcs = ["other.cpp"],
)

cc_library(
    name = "lib",
    srcs = ["lib.cpp"],
    linkstatic = False,
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
    name = "main_shared",
    srcs = ["main.cpp"],
    linkstatic = False,
    deps = [
        ":lib",
        ":other",
    ],
)
