module_template = """
CONSTANT_IN_LIB = {value}
"""

def _gen_py_lib_impl(ctx):
    packagefile_content = module_template.format(value = ctx.attr.constant_value)

    generated_package_file = ctx.actions.declare_file("/".join([ctx.attr.module, "__init__.py"]))
    ctx.actions.write(output = generated_package_file, content = packagefile_content)

    return [
        DefaultInfo(
            default_runfiles = ctx.runfiles(files = [generated_package_file]),
        ),
        PyInfo(
            imports = depset(direct = [ctx.attr.module]),
            transitive_sources = depset(direct = [generated_package_file]),
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
