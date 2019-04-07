runfile_template = """{{
  "name": "{name}",
  "lastName": "Smith",
  "isAlive": true,
  "age": 27,
  "address": {{
    "streetAddress": "21 2nd Street",
    "city": "New York",
    "state": "NY",
    "postalCode": "10021-3100"
  }},
  "phoneNumbers": [
    {{
      "type": "home",
      "number": "212 555-1234"
    }},
    {{
      "type": "office",
      "number": "646 555-4567"
    }},
    {{
      "type": "mobile",
      "number": "123 456-7890"
    }}
  ],
  "children": [],
  "spouse": null
}}
"""

def _runfile_impl(ctx):
    out = ctx.actions.declare_file("{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = out, content = content)

    runfiles = ctx.runfiles(files = [out])

    return DefaultInfo(files = depset([out]), runfiles = runfiles)

runfile = rule(
    attrs = {},
    implementation = _runfile_impl,
)

def _default_runfile_impl(ctx):
    out = ctx.actions.declare_file("{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = out, content = content)

    runfiles = ctx.runfiles(files = [out])

    return DefaultInfo(files = depset([out]), runfiles = runfiles)

default_runfile = rule(
    attrs = {},
    implementation = _default_runfile_impl,
)

def _data_runfile_impl(ctx):
    out = ctx.actions.declare_file("{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = out, content = content)

    runfiles = ctx.runfiles(files = [out])

    return DefaultInfo(files = depset([out]), runfiles = runfiles)

data_runfile = rule(
    attrs = {},
    implementation = _data_runfile_impl,
)

def _runfile_symlinks_impl(ctx):
    out = ctx.actions.declare_file("{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = out, content = content)

    linked_file = ctx.actions.declare_file("sub_folder/{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = linked_file, content = content)

    runfiles = ctx.runfiles(files = [out], symlinks = {"{name}_link".format(name = ctx.attr.name): linked_file})

    return DefaultInfo(files = depset([out]), runfiles = runfiles)

runfile_symlinks = rule(
    attrs = {},
    implementation = _runfile_symlinks_impl,
)

def _runfile_root_symlinks_impl(ctx):
    out = ctx.actions.declare_file("{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = out, content = content)

    linked_file = ctx.actions.declare_file("sub_folder/{name}.json".format(name = ctx.attr.name))
    content = runfile_template.format(name = ctx.attr.name)
    ctx.actions.write(output = linked_file, content = content)

    runfiles = ctx.runfiles(files = [out], root_symlinks = {"{name}_root_link".format(name = ctx.attr.name): linked_file})

    return DefaultInfo(files = depset([out]), runfiles = runfiles)

runfile_root_symlinks = rule(
    attrs = {},
    implementation = _runfile_root_symlinks_impl,
)
