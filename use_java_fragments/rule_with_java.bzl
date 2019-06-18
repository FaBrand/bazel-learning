def inspect(f):
    print(f)
    print(dir(f))

def _rule_with_java_impl(ctx):
    out = ctx.actions.declare_file(ctx.attr.name)
    java_runtime = ctx.attr._jdk[java_common.JavaRuntimeInfo]
    jar_path = "%s/bin/java" % java_runtime.java_home

    args = ctx.actions.args()
    args.add(out)

    ctx.actions.run_shell(
        inputs = ctx.files._jdk,
        outputs = [out],
        command = "%s -version; touch $@; exit 1" % (jar_path),
        arguments = [args],
        progress_message = "Show current java version",
        mnemonic = "JavaVersion",
    )

    return [
        DefaultInfo(files = depset([out])),
        OutputGroupInfo(foo = [out]),
    ]

rule_with_java = rule(
    attrs = {
        "_jdk": attr.label(
            default = Label("@bazel_tools//tools/jdk:current_host_java_runtime"),
            providers = [java_common.JavaRuntimeInfo],
            doc = "Provide the current java runtime files to this rule",
        ),
    },
    toolchains = ["@bazel_tools//tools/jdk:current_host_java_runtime"],
    implementation = _rule_with_java_impl,
)
