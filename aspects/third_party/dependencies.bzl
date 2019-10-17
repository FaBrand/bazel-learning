load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def load_dependencies():
    if "clang" not in native.existing_rules():
        http_archive(
            name = "clang",
            build_file = "//third_party:BUILD.clang",
            sha256 = "a23b082b30c128c9831dbdd96edad26b43f56624d0ad0ea9edec506f5385038d",
            strip_prefix = "clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04/bin",
            url = "http://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
        )

    if "bazel_compilation_database" not in native.existing_rules():
        git_repository(
            name = "bazel_compilation_database",
            remote = "https://github.com/grailbio/bazel-compilation-database.git",
            tag = "0.4.1",
        )
