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

###########################################################
#  Run these binaries to print the actual python version  #
###########################################################

py_binary(
    name = "default",
    srcs = ["show_python_version.py"],
    main = "show_python_version.py",
)

py_binary(
    name = "python2",
    srcs = ["show_python_version.py"],
    main = "show_python_version.py",
    python_version = "PY2",
)

py_binary(
    name = "python3",
    srcs = ["show_python_version.py"],
    main = "show_python_version.py",
    python_version = "PY3",
)
