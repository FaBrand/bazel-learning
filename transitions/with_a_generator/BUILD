load("//:cc_api_rules.bzl", "cc_bin")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_deb", "pkg_tar")
load("@bazel_skylib//rules:write_file.bzl", "write_file")
load(":generator.bzl", "generator")

generator(
    name = "generated_file",
    content = """
int main(int argc, char* argv[])
{
#ifdef VARIANTA
    return 0;
#else
    return 1;
#endif
}
""",
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

pkg_tar(
    name = "pkg",
    srcs = [
        "generated_file",
        "variant_a",
        "variant_b",
    ],
)
