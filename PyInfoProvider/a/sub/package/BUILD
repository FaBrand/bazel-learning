load("//:gen_py_lib.bzl", "gen_py_lib")

gen_py_lib(
    name = "generated_sub_lib",
    constant_value = 43,
    module = "SubLib",
    visibility = ["//visibility:public"],
)

py_library(
    name = "example_module",
    srcs = ["example_module/__init__.py"],
    imports = ["."],
    visibility = ["//visibility:public"],
)
