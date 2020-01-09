load("//static_analysis:clang_tidy.bzl", "clang_tidy")
load("@bazel_compilation_database//:aspects.bzl", "compilation_database")

exports_files([".clang-tidy"])

clang_tidy(
    name = "clang_tidy_main",
    targets = ["//module_with_strip_includes:lib"],
    visibility = ["//visibility:public"],
)

compilation_database(
    name = "comp_db",
    targets = ["//module_with_strip_includes:lib"],
    visibility = ["//visibility:public"],
)
