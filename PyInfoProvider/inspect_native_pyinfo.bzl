def inspect(label, x):
    print("=" * 50)
    print(label)
    print(x)
    print(dir(x))
    for element in dir(x):
        if element not in ["union", "aspect_ids", "rule", "to_list", "to_json"]:
            val = getattr(x, element, None)
            if val != None:
                print(element, val)
            else:
                print("Not readable", element)
    print("=" * 50)

def _inspect_py_info_impl(ctx):
    inspectee = ctx.attr.inspect
    inspect("label", ctx.label)
    inspect("inspectee", inspectee)
    inspect("inspectee.label", inspectee.label)
    inspect("inspectee.files", inspectee.files)
    inspect("inspectee.data_runfiles", inspectee.data_runfiles)
    inspect("inspectee.default_runfiles", inspectee.default_runfiles)

    inspect("PyInfo", inspectee[PyInfo])

inspect_py_info = rule(
    attrs = {
        "inspect": attr.label(
            mandatory = True,
            providers = [PyInfo],
        ),
    },
    implementation = _inspect_py_info_impl,
)
