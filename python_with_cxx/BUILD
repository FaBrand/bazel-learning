cc_library(
    name = "a_shared_library",
    srcs = ["cpp_code.cpp"],
    hdrs = ["cpp_code.h"],
)

py_library(
    name = "a_python_library",
    srcs = ["a_python_library.py"],
    data = [":a_shared_library"],
)

py_binary(
    name = "a_python_main",
    srcs = ["a_python_main.py"],
    data = [":a_shared_library"],
    main = "a_python_main.py",
    deps = [":a_python_library"],
)
