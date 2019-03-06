py_binary(
    name = "generator",
    srcs = ["generator.py"],
)

genrule(
    name = "foo",
    srcs = [],
    outs = ["hello_world.cpp"],
    cmd = "$(location :generator) \"$@\" foo",
    tools = [":generator"],
)

genrule(
    name = "concat_all_files",
    srcs = [
        ":foo",   # a genrule with a single output ==> $(location)
    ],
    outs = ["concatenated.txt"],
    cmd = "cat $(location :foo) > $@",
)

cc_binary(
    name = "generated",
    srcs = [
        ":foo",
        ]
)
