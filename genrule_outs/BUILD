load("@bazel_skylib//rules:write_file.bzl", "write_file")

write_file(
    name = "generator",
    out = "gen.cpp",
    content = [],
)

write_file(
    name = "generator2",
    out = "gen.cpp",
    content = [],
)

genrule(
    name = "receiver_cpp",
    outs = ["generated_communication_mappingreceiver.cpp"],
    cmd = "echo '' > $@",
)

cc_library(
    name = "foo",
    srcs = ["gen.cpp"],
)

cc_library(
    name = "bar",
    srcs = ["generator"],
)
