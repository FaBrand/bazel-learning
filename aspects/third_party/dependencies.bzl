load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def load_dependencies():
    if "clang" not in native.existing_rules():
        http_archive(
            name = "clang",
            build_file = "//third_party:BUILD.clang",
            sha256 = "e74ce06d99ed9ce42898e22d2a966f71ae785bdf4edbded93e628d696858921a",
            strip_prefix = "clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04/bin",
            url = "https://releases.llvm.org/7.0.1/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
        )
