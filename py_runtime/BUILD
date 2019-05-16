load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")

py_runtime(
    name = "python-3.6.0",
    interpreter_path = "/usr/bin/python3.6",
    python_version = "PY3",
)

py_runtime(
    name = "python-2.7.0",
    interpreter_path = "/usr/bin/python2.7",
    python_version = "PY2",
)

py_runtime_pair(
    name = "py_runtime_pair",
    py2_runtime = ":python-2.7.0",
    py3_runtime = ":python-3.6.0",
)

toolchain(
    name = "python_toolchain",
    toolchain = ":py_runtime_pair",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)
######################################################################
#  A library that may be available as python2 or python3 compatible  #
######################################################################

py_library(
    name = "python2_dependency",
    srcs = ["a_dependency_library.py"],
    srcs_version = "PY2",
)

py_library(
    name = "python2only_dependency",
    srcs = ["a_dependency_library.py"],
    srcs_version = "PY2ONLY",
)

py_library(
    name = "python3_dependency",
    srcs = ["a_dependency_library.py"],
    srcs_version = "PY3",
)

py_library(
    name = "python3only_dependency",
    srcs = ["a_dependency_library.py"],
    srcs_version = "PY3ONLY",
)

py_library(
    name = "python2and3_dependency",
    srcs = ["a_dependency_library.py"],
    srcs_version = "PY2AND3",
)

###########################################################
#  Run these binaries to print the actual python version  #
###########################################################

py_binary(
    name = "default",
    srcs = ["show_python_version.py"],
    main = "show_python_version.py",
    deps = [
        ":python2and3_dependency",
        ":python3_dependency",
        ":python3only_dependency",
    ],
)

py_binary(
    name = "python2",
    srcs = ["show_python_version.py"],
    main = "show_python_version.py",
    python_version = "PY2",
    deps = [
        ":python2_dependency",
        ":python2and3_dependency",
        ":python2only_dependency",
        # Uncomment to show the hard dependency error
        # ":python3only_dependency",
        # Uncomment to show the hard dependency error
        # ":python3_dependency",
    ],
)

py_binary(
    name = "python3",
    srcs = ["show_python_version.py"],
    main = "show_python_version.py",
    python_version = "PY3",
    deps = [
        ":python2and3_dependency",
        ":python3_dependency",
        ":python3only_dependency",
        # Uncomment to show the hard dependency error
        # ":python2only_dependency",
        # Uncomment to show the 2to3 build error
        # ":python2_dependency",
    ],
)
