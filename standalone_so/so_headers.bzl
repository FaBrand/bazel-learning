def _so_headers_impl(ctx):
    headers = ctx.attr.so_file[CcInfo].compilation_context.headers
    return DefaultInfo(files = headers)

so_headers = rule(
    implementation = _so_headers_impl,
    attrs = {
        "so_file": attr.label(providers = [CcInfo]),
    },
)
