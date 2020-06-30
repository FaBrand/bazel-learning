load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_deb", "pkg_tar")
load("//:setting.bzl", "flavor")
load("//:select_flavor.bzl", "select_flavor")
load("//:ice_cream_machine.bzl", "ice_cream_machine")

flavor(
    name = "flavor",
    build_setting_default = "Apple",
)

ice_cream_machine(
    name = "maker",
    flavor = "//:flavor",
)

select_flavor(
    name = "cranberry_ice_cream",
    flavor = "Cranberry",
    inputs = ["maker"],
)

select_flavor(
    name = "cherry_ice_cream",
    flavor = "Cherry",
    inputs = ["maker"],
)

pkg_tar(
    name = "cranberry_order",
    srcs = [
        "cranberry_ice_cream",
    ],
)

pkg_tar(
    name = "cherry_order",
    srcs = [
        "cherry_ice_cream",
        "cranberry_ice_cream",
        "maker",
    ],
)

pkg_tar(
    name = "apple_order",
    srcs = [
        "maker",
    ],
)

pkg_tar(
    name = "delivery",
    srcs = [
        ":apple_order",
        ":cherry_order",
        ":cranberry_order",
    ],
)
