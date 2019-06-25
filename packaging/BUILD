load("//:generate_files.bzl", "generate_files")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_deb", "pkg_tar")

pkg_tar(
    name = "lib",
    srcs = ["//my_library"],
    mode = "0755",
    package_dir = "/usr/lib",
)

pkg_deb(
    name = "my_library-dev",
    architecture = "amd64",
    built_using = "bazel (0.26.1)",
    data = ":lib",
    description_file = "README.md",
    homepage = "https://foo.bar.de",
    maintainer = "John Doe <john@doe.com>",
    package = "my_library-dev",
    version = "0.0.4",
)

prefix = "out_dir"

generate_files(
    name = "bar",
    prefix = prefix,
)

pkg_tar(
    name = "pkg_subdir",
    srcs = [":bar"],
    package_dir = "/usr",
    strip_prefix = prefix,
)

pkg_deb(
    name = "sub_packages-dev",
    architecture = "amd64",
    built_using = "bazel (0.26.1)",
    data = ":pkg_subdir",
    description_file = "README.md",
    homepage = "https://foo.bar.de",
    maintainer = "John Doe <john@doe.com>",
    package = "sub_packages-dev",
    version = "0.0.4",
)
