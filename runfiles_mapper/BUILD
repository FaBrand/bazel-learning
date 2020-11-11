load("@bazel_skylib//rules:run_binary.bzl", "run_binary")
load(":runfiles_mapper.bzl", "runfiles_mapper")

runfiles_mapper(
    name = "mapped",
    files = {"runfile.txt": "etc/application/runfile.json"},
    root_files = {"runfile.txt": "etc/application/runfile.json"},
)

py_test(
    name = "foo",
    srcs = ["foo.py"],
    data = [":mapped"],  # a cc_binary which we invoke at run time
)

py_binary(
    name = "bar",
    srcs = ["foo.py"],
    data = [":mapped"],  # a cc_binary which we invoke at run time
    main = "foo.py",
)

run_binary(
    name = "gen",
    outs = ["foobar"],
    args = ["$(locations foobar)"],
    tool = ":foo",
)
