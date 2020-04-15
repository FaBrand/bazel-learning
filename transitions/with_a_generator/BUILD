load("//:cc_api_rules.bzl", "cc_bin")
load("@bazel_skylib//rules:write_file.bzl", "write_file")

write_file(
    name = "generated_file",
    out = "main.c",
    content = """
int main(int argc, char* argv[])
{
#ifdef VARIANTA
    return 0;
#else
    return 1;
#endif
}
""".split("\n"),
)

cc_bin(
    name = "variant_a",
    srcs = [":generated_file"],
    # Sets transition with copts
    copt = ["-DVARIANTA"],
)

cc_bin(
    name = "variant_b",
    srcs = [":generated_file"],
    # Sets transition with copts
    copt = ["-DVARIANTB"],
)
