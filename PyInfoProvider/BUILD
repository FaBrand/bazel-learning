load(":gen_py_lib.bzl", "gen_py_lib")
load(":inspect_native_pyinfo.bzl", "inspect_py_info")

gen_py_lib(
    name = "generated_lib",
    constant_value = 42,
    module = "MyLib",
)

py_library(
    name = "library_in_root_package",
    srcs = ["app.py"],
    deps = [
        ":generated_lib",
    ],
)

py_binary(
    name = "use_generated_py_lib",
    srcs = ["app.py"],
    main = "app.py",
    deps = [
        ":generated_lib",
    ],
)

py_test(
    name = "test_generated_py_lib",
    srcs = ["app_test.py"],
    main = "app_test.py",
    deps = [
        ":generated_lib",
        "//a/sub/package:generated_sub_lib",
        "//a/sub/package:py_library_with_imports_same_package",
    ],
)

inspect_py_info(
    name = "inspect_a_sub_package_module",
    inspect = "//a/sub/package:py_library_with_imports_same_package",
)

inspect_py_info(
    name = "inspect_library_in_root_package",
    inspect = "library_in_root_package",
)
