load(":runfile.bzl", "data_runfile", "default_runfile", "runfile", "runfile_symlinks")

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

py_binary(
    name = "app",
    srcs = ["app.py"],
    data = [
        ":data_runfile",
        ":default_runfile",
        ":runfile",
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
