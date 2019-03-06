
cc_library(
    name = "lib",
    srcs = glob(["src/*.cpp", "include/**/*.h"]),
    hdrs = glob(["include/**/*.h"]),
    strip_include_prefix = "include",
    deps = [
            "//private_headers:lib",
            "//strip_prefix_library:lib",
            "//using_includes:lib",
           ],
    visibility = ["//visibility:public"],
)
