load(":gen_py_lib.bzl", "gen_py_lib")

gen_py_lib(
    name = "generated_lib",
    constant_value = 42,
    module = "MyLib",
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
        "//a/sub/package:example_module",
        "//a/sub/package:generated_sub_lib",
    ],
)
