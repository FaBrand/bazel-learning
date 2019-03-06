load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar", "pkg_deb")

pkg_tar(
    name = "lib",
    package_dir = "/usr/lib",
    srcs = ["//my_library:my_library"],
    mode = "0755",
)

pkg_deb(
    name = "my_library-dev",
    architecture = "amd64",
    built_using = "bazel (0.19.0)",
    data = ":lib",
    description_file = "README.md",
    homepage = "https://foo.bar.de",
    maintainer = "John Doe <john@doe.com>",
    package = "my_library-dev",
    version = "0.0.4",
)
