def _flavor_transition_impl(settings, attr):
    return {
        "//:flavor": attr.flavor,
    }

_flavor_transition = transition(
    implementation = _flavor_transition_impl,
    inputs = [
        "//:flavor",
    ],
    outputs = [
        "//:flavor",
    ],
)

def _select_flavor_impl(ctx):
    return DefaultInfo(files = depset(ctx.files.inputs))

select_flavor = rule(
    implementation = _select_flavor_impl,
    attrs = {
        "flavor": attr.string(),
        "_whitelist_function_transition": attr.label(default = Label("//tools/whitelists/function_transition_whitelist:function_transition_whitelist")),  #this path is hard coded by bazel
        "inputs": attr.label_list(
            cfg = _flavor_transition,
            allow_files = True,
        ),
    },
)
