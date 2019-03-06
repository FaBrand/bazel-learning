cc_library(
    name = "lib_private",
    srcs = glob(["src/**/*.h"]),
    hdrs = glob(["src/**/*.h"]),
    strip_include_prefix = "src",
    visibility = ["//visibility:__pkg__"],
)

cc_library(
    name = "lib",
    # The srcs that exclude the src/sub directory would not compile on its own because
    # src/sub/sub.h is included via #include <sub/sub.h>
    # This requires that a include path to src is set.
    # This can only be done via a seperate cc_library
    # --> Only one strip_include_prefix is possible
    # --> However this makes the supposedly private library public to all dependening on lib
    #
    # sub.cpp does not compile because of <sub/sub.h> not being found.
    # One solution would be to add a helper library (lib_private)
    # However this leaks the includes to other libraries depending on lib
    srcs = glob(["src/**/*", "include/**/*"]),
    # !!! Leaks private dependencies transitively !!!
    deps = [":lib_private"],

    # Uncomment this to ignore the sub module for compilation
    # srcs = glob(["src/**/*", "include/**/*"], exclude=["src/sub/*"]),

    hdrs = glob(["include/**/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
