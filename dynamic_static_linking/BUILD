load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_deb", "pkg_tar")

cc_library(
    name = "mylib",
    srcs = [
        "library.cpp",
        "library.h",
    ],
    hdrs = ["library.h"],
)

# This is runnable
cc_binary(
    name = "bin_with_shared_dependencies",
    srcs = ["main.cpp"],
    deps = [":mylib"],
)

# This fails to run
# ./bin_with_invalid_shared_dependencies: error while loading shared libraries: liblibmylib.so: cannot open shared object file: No such file or directory
cc_binary(
    name = "bin_with_invalid_shared_dependencies",
    srcs = ["main.cpp"],
    linkstatic = False,
    deps = [":mylib"],
)

# This links completely static
cc_binary(
    name = "bin_with_static_dependencies",
    srcs = ["main.cpp"],
    linkstatic = True,
    deps = [":mylib"],
)

# This is basically an alias for mylib
cc_binary(
    name = "libalias.so",
    linkshared = True,
    deps = [":mylib"],
)

# Put it in a zip
pkg_tar(
    name = "debian-data",
    srcs = [
        ":bin_with_invalid_shared_dependencies",
        ":bin_with_shared_dependencies",
        ":bin_with_static_dependencies",
        ":mylib",
    ],
    extension = "tar.gz",
)
