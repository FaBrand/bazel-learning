load("@bazel_skylib//lib:paths.bzl", "paths")

_CONTENT = """#ifndef HEADER_GUARD_H
#define HEADER_GUARD_H

extern int foo;

#endif
"""

def _generator_impl(ctx):
    out = ctx.actions.declare_file(paths.join(ctx.label.name, ctx.label.name + ".h"))
    ctx.actions.write(
        output = out,
        content = _CONTENT,
    )

    return [
        DefaultInfo(files = depset([out])),
        CcInfo(compilation_context = cc_common.create_compilation_context(
            headers = depset([out]),
            includes = depset([out.dirname]),
        )),
    ]

generator = rule(
    implementation = _generator_impl,
    attrs = {},
)
