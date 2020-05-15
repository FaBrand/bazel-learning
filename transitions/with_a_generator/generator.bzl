def _cc_bin_transition_impl(settings, attr):
    return {}

_cc_bin_transition = transition(
    implementation = _cc_bin_transition_impl,
    inputs = ["//command_line_option:copt"],
    outputs = [],
)

def _generator_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".cpp")

    ctx.actions.run(
        inputs = [],
        executable = ctx.executable._tool,
        arguments = [ctx.attr.content, out.path],
        outputs = [out],
        mnemonic = "RunTool",
        progress_message = "generating {}".format(out.basename),
    )

    return DefaultInfo(files = depset([out]))

_generator = rule(
    implementation = _generator_impl,
    attrs = {
        "content": attr.string(),
        "_tool": attr.label(
            cfg = "host",
            executable = True,
            allow_single_file = True,
            default = "//with_a_generator:generator.sh",
        ),
        "_whitelist_function_transition": attr.label(default = Label("//tools/whitelists/function_transition_whitelist:function_transition_whitelist")),  #this path is hard coded by bazel
    },
    cfg = _cc_bin_transition,
)

def _as_host_impl(ctx):
    providers = [
        DefaultInfo,
        OutputGroupInfo,
    ]
    return [
        ctx.attr.src[prov]
        for prov in providers
        if prov in ctx.attr.src
    ]

as_host = rule(
    implementation = _as_host_impl,
    attrs = {
        "src": attr.label(
            allow_files = True,
            cfg = "host",
        ),
    },
)

def generator(name, **kwargs):
    _generator(
        name = name + "_gen",
        **kwargs
    )

    as_host(
        name = name,
        src = name + "_gen",
    )
