load("//:gen_py_lib.bzl", "gen_py_lib")
load("//:inspect_native_pyinfo.bzl", "inspect_py_info")

gen_py_lib(
    name = "generated_sub_lib",
    constant_value = 43,
    module = "SubLib",
    visibility = ["//visibility:public"],
)

py_library(
    name = "py_library_with_imports_same_package",
    srcs = ["example_module/__init__.py"],
    imports = ["."],
    visibility = ["//visibility:public"],
)

py_library(
    name = "py_library_with_dependency_on_generated_lib",
    srcs = ["example_module/__init__.py"],
    imports = ["."],
    visibility = ["//visibility:public"],
    deps = [":generated_sub_lib"],
)

inspect_py_info(
    name = "inspect_generated_sub_lib",
    inspect = ":generated_sub_lib",
)

inspect_py_info(
    name = "inspect_py_library_with_imports_same_package",
    inspect = ":py_library_with_imports_same_package",
)

inspect_py_info(
    name = "inspect_py_library_with_dependency_on_generated_lib",
    inspect = ":py_library_with_dependency_on_generated_lib",
)
