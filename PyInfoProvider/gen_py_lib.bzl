module_template = """
CONSTANT_IN_LIB = {value}
"""

def _gen_py_lib_impl(ctx):
    generated_lib = ctx.actions.declare_file("/".join([ctx.attr.module, "__init__.py"]))
    content = module_template.format(value = ctx.attr.constant_value)
    ctx.actions.write(output = generated_lib, content = content)
    lib = ctx.runfiles(files = [generated_lib])
    return [
        DefaultInfo(runfiles = lib),
        PyInfo(
            imports = depset(direct = [ctx.attr.module]),
            transitive_sources = depset(),
        ),
    ]

gen_py_lib = rule(
    attrs = {
        "module": attr.string(
            doc = """The name of the module that shall be generated.""",
            mandatory = True,
        ),
        "constant_value": attr.int(
            doc = """A value that will be generated into the lib, and accessible by the inheriting rules""",
            mandatory = True,
        ),
    },
    implementation = _gen_py_lib_impl,
)
