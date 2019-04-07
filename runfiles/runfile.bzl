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
