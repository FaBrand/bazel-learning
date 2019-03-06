def _impl(ctx):
  tree = ctx.actions.declare_directory(ctx.attr.name)
  ctx.actions.run(
    inputs = [],
    outputs = [ tree ],
    arguments = ['-o', tree.path, '-n', str(ctx.attr.n) ],
    progress_message = "Generating cc files into '%s'" % tree.path,
    executable = ctx.executable._tool,
  )

  return [ DefaultInfo(files = depset([ tree ])) ]

genccs = rule(
  implementation = _impl,
  attrs = {
    "n": attr.int(mandatory=True),
    "_tool": attr.label(
      executable = True,
      cfg = "host",
      allow_files = True,
      default = Label("//py_binary:py_gen"),
    )
  },
  output_to_genfiles = True,
)

def genlib(name, n, **kwargs):
    genccs(name='gen_'+name, n=n)
    native.cc_library(
            name = name,
            srcs = [":gen_{}".format(name)],
            **kwargs
    )
