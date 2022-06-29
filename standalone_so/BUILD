load("@rules_pkg//pkg:mappings.bzl", "pkg_files", "strip_prefix")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")
load("@rules_pkg//pkg:zip.bzl", "pkg_zip")
load("//:so_headers.bzl", "so_headers")

cc_binary(
    name = "libcontent.so",
    srcs = [
        "content.cpp",
        "content.h",
    ],
    linkshared = 1,
    linkstatic = True,
)

so_headers(
    name = "so_headers",
    so_file = ":libcontent.so",
)

pkg_files(
    name = "headers",
    srcs = [
        ":so_headers",
    ],
    prefix = "/usr/include",
)

pkg_files(
    name = "bin",
    srcs = [
        ":libcontent.so",
    ],
    prefix = "usr/bin",
    # Required, but why?: see #354
    strip_prefix = strip_prefix.from_pkg(),
)

pkg_tar(
    name = "foo_tar",
    srcs = [
        ":bin",
        ":headers",
    ],
)

pkg_zip(
    name = "foo_zip",
    srcs = [
        ":bin",
        ":headers",
    ],
)
