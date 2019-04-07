load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load(":runfile.bzl", "data_runfile", "default_runfile", "runfile", "runfile_root_symlinks", "runfile_symlinks")

runfile(
    name = "runfile",
)

default_runfile(
    name = "default_runfile",
)

data_runfile(
    name = "data_runfile",
)

runfile_symlinks(
    name = "runfile_symlinks",
)

runfile_root_symlinks(
    name = "runfile_root_symlinks",
)

py_binary(
    name = "app",
    srcs = ["app.py"],
    data = [
        ":data_runfile",
        ":default_runfile",
        ":runfile",
        ":runfile_root_symlinks",
        ":runfile_symlinks",
    ],
)

py_binary(
    name = "dependent_app",
    srcs = ["app.py"],
    main = "app.py",
    deps = [":app"],
)

py_binary(
    name = "data_dependent_app",
    srcs = ["app.py"],
    data = [":app"],
    main = "app.py",
)

pkg_tar(
    name = "app_pkg",
    srcs = [":app"],
)

pkg_tar(
    name = "dependent_app_pkg",
    srcs = [":dependent_app"],
)

pkg_tar(
    name = "data_dependent_app_pkg",
    srcs = [":data_dependent_app"],
)
