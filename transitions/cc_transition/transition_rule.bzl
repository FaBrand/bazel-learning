def _cc_transition_impl(settings, attr):
    return {"//command_line_option:copt": settings["//command_line_option:copt"] + attr.copt}

_cc_transition = transition(
    implementation = _cc_transition_impl,
    inputs = ["//command_line_option:copt"],
    outputs = ["//command_line_option:copt"],
)

def _cc_transition_rule_impl(ctx):
    return cc_common.merge_cc_infos(
        cc_infos = [dep[CcInfo] for dep in ctx.attr.deps],
    )

cc_transition = rule(
    implementation = _cc_transition_rule_impl,
    attrs = {
        "deps": attr.label_list(allow_empty = True, providers = [CcInfo]),
        "copt": attr.string_list(),
        "_whitelist_function_transition": attr.label(default = Label("//tools/whitelists/function_transition_whitelist:function_transition_whitelist")),  #this path is hard coded by bazel
    },
    cfg = _cc_transition,
)
