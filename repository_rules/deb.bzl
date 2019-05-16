_DEFAULT_BUILD_FILE_TEMPLATE = """
cc_library(
    name = "{name}",
    srcs = glob(["usr/lib/**/*.a", "usr/lib/**/*.so"]),
    hdrs = glob(["usr/include/**/*"]),
    includes = ["usr/include"],
    visibility = ["//visibility:public"],
    linkstatic = True,
)
"""

def _debian_archive_impl(ctx):
    loaded = ctx.download(
        url = ctx.attr.url,
        output = ctx.name,
        sha256 = ctx.attr.sha256,
    )

    if not loaded:
        fail("Download of {} failed".format(ctx.attr.url))

    # Extract debian
    tool = ctx.which("dpkg-deb")
    if not tool:
        fail("dpkg-deb not found")

    extraction_succeeded = ctx.execute([tool, "-X", ctx.name, "./"])
    if not extraction_succeeded:
        fail("Extraction failed")

    # Not yet in bazel 0.25.2
    # ctx.delete("extracted/usr/share/")
    cleanup = ctx.execute(["rm", "-rf", "usr/share"])
    cleanup = cleanup and ctx.execute(["rm", "-f", ctx.name])
    if not cleanup:
        fail("Cleanup failed")

    if ctx.attr.build_file:
        ctx.symlink(ctx.attr.build_file, "BUILD.bazel")
    else:
        build_file_content = _DEFAULT_BUILD_FILE_TEMPLATE.format(name = ctx.name)
        ctx.file("BUILD.bazel", build_file_content)

    if ctx.attr.workspace_file:
        ctx.symlink(ctx.path(ctx.attr.workspace_file), "WORKSPACE")
    else:
        ctx.file("WORKSPACE", "")

new_debian_archive = repository_rule(
    attrs = {
        "sha256": attr.string(default = ""),
        "url": attr.string(default = ""),
        "build_file": attr.label(allow_single_file = True),
        "workspace_file": attr.label(allow_single_file = True),
    },
    local = False,
    implementation = _debian_archive_impl,
)
