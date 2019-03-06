cc_library(
    name = "my_library",
    srcs = glob(["src/*.cpp", "src/*.h", "include/**/*.h"]),
    hdrs = glob(["include/**/*.h"]),
    strip_include_prefix = "include",
    linkstatic = True,
    visibility = ["//visibility:public"],
)
