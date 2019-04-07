# Runfiles
### This is an learning by doing example on how runfiles can be used

To compare the output of two different apps with regards to their runfiles mirrored all files in a dir
to a new directory and ran bazel from there.
```bash
mkdir runfiles_mirror && cd $_
find ../runfiles -type f -exec ln -s {} \;
```
You could then just cd into the pwd that is printed in the output of the run command and `watch` the contents of the runfiles dir change.
If you go directly to the bin directory in the execroot `execroot/__main__/bazel-out/k8-fastbuild/bin` you can see whats happening with all runfiles.
```bash
watch -n5 -t -c -d 'tree -C | sed "s#->.*##"'
```

I like to use [entr](http://eradman.com/entrproject/) to get automatic updates on my builds.
In combination with the watch command above you can play around and have look at what has changed without having to deal with all the executing of tools.
```bash
ag . | entr -cd bazel run -- //:app
ag . | entr -cd bazel run -- //:data_dependent_app
```
### Digging for understanding
To get to know how things work with runfiles, especially what files are created where.
Comment out all data dependencies of the `app` `py_binary` in the `BUILD` file.
```python
py_binary(
    name = "app",
    srcs = ["app.py"],
    data = [
        # ":data_runfile",
        # ":default_runfile",
        # ":runfile",
        # ":runfile_root_symlinks",
        # ":runfile_symlinks",
    ],
)
```

I'm running `//:app` and `//:data_dependent_app` alongside to see how direct and indirect runfiles are created.
With now data defined as a dependecy the runfiles directory is quite empty.
```bash
.
├── app
├── app.runfiles
│   ├── __main__
│   │   ├── app
│   │   └── app.py
│   └── MANIFEST
└── app.runfiles_manifest
```
As expected the `data_dependent_app` has the `app` as data dependency and therefore already lists it as its runfiles.
```bash
.
├── app
├── app.runfiles
│   ├── __main__
│   │   ├── app
│   │   └── app.py
│   └── MANIFEST
├── app.runfiles_manifest
├── data_dependent_app
├── data_dependent_app.runfiles
│   ├── __main__
│   │   ├── app
│   │   ├── app.py
│   │   └── data_dependent_app
│   └── MANIFEST
└── data_dependent_app.runfiles_manifest
```

### Providing Data through different arguments of the DefaultInfoProvider

###### Providing data through runfile
```python
data = [
    # ":data_runfile",
    # ":default_runfile",
    ":runfile",
    # ":runfile_root_symlinks",
    # ":runfile_symlinks",
],
```

Both apps have runfile.json directly in their runfiles directory and can read is directly at runtime:
```bash
dir contents ['app', 'app.py', 'runfile.json']
python-version 3.6.7 (default, Oct 22 2018, 11:32:17)
[GCC 8.2.0]
Loaded json file: runfile.json
File could not be found: default_runfile.json
File could not be found: data_runfile.json
File could not be found: runfile_symlinks_link
File could not be found: runfile_root_symlinks_link
File could not be found: runfile_root_symlinks.json
```

###### Providing files through data_runfile
```python
data = [
    ":data_runfile",
    # ":default_runfile",
    # ":runfile",
    # ":runfile_root_symlinks",
    # ":runfile_symlinks",
],
```
Both targets can read data_runfile.json. It is located in the same place as the executable.

Since `runfiles` set's both default and data runfiles this is kind of expected.

```bash
dir contents ['data_runfile.json', 'app', 'app.py']
python-version 3.6.7 (default, Oct 22 2018, 11:32:17)
[GCC 8.2.0]
File could not be found: runfile.json
File could not be found: default_runfile.json
Loaded json file: data_runfile.json
File could not be found: runfile_symlinks_link
File could not be found: runfile_root_symlinks_link
File could not be found: runfile_root_symlinks.json
```

###### Providing files through default_runfile
```python
data = [
    # ":data_runfile",
    ":default_runfile",
    # ":runfile",
    # ":runfile_root_symlinks",
    # ":runfile_symlinks",
],
```
This is unexpected.
Neither the dependent app nor the base app can read the `default_runfile.json`.

It also doesn't show up in the bin directory:
```bash
.
├── app
├── app.runfiles
│   ├── __main__
│   │   ├── app
│   │   └── app.py
│   └── MANIFEST
├── app.runfiles_manifest
├── data_dependent_app
├── data_dependent_app.runfiles
│   ├── __main__
│   │   ├── app
│   │   ├── app.py
│   │   └── data_dependent_app
│   └── MANIFEST
└── data_dependent_app.runfiles_manifest
```

I tried providing the out file through the `transitive_files` attribute, and varying the `collect_*` values.
Nothing actually requested the runfiles.

###### Providing files through runfile_symlinks
```python
data = [
    # ":data_runfile",
    # ":default_runfile",
    # ":runfile",
    # ":runfile_root_symlinks",
    ":runfile_symlinks",
],
```
With this target a json file `runfile_symlinks.json` gets created in the `sub_folder` directory.
The applications can access it directly via the symlink that is set in the rule.
e.g. with linked_file being the generated json file.
```python
runfiles = ctx.runfiles(symlinks = {"{name}_link".format(name = ctx.attr.name): linked_file}, **common_runfiles_args)
```

In contrast to the `data_runfile` the symlink allows for "renaming" the file via the link it is accessed through.
There are probably more use cases to this that i didn't discover yet.

```bash
.
├── app
├── app.runfiles
│   ├── __main__
│   │   ├── app
│   │   ├── app.py
│   │   └── runfile_symlinks_link
│   └── MANIFEST
├── app.runfiles_manifest
└── sub_folder
    └── runfile_symlinks.json
```

It could also allow to define a different folder structure that is required by the program to run
```diff
diff --git a/runfiles/runfile.bzl b/runfiles/runfile.bzl
index 7e13c3e..a62e1be 100644
--- a/runfiles/runfile.bzl
+++ b/runfiles/runfile.bzl
@@ -84,7 +84,7 @@ def _runfile_symlinks_impl(ctx):
     content = runfile_template.format(name = ctx.attr.name)
     ctx.actions.write(output = linked_file, content = content)

-    runfiles = ctx.runfiles(symlinks = {"{name}_link".format(name = ctx.attr.name): linked_file}, **common_runfiles_args)
+    runfiles = ctx.runfiles(symlinks = {"some/sub/folder/{name}_link".format(name = ctx.attr.name): linked_file}, **common_runfiles_args)

     return DefaultInfo(runfiles = runfiles)
```
e.g. the above change yields (for the data_dependent_app)
```bash
.
├── app
├── app.runfiles
│   ├── __main__
│   │   ├── app
│   │   ├── app.py
│   │   └── some
│   │       └── sub
│   │           └── folder
│   │               └── runfile_symlinks_link
│   └── MANIFEST
├── app.runfiles_manifest
├── data_dependent_app
├── data_dependent_app.runfiles
│   ├── __main__
│   │   ├── app
│   │   ├── app.py
│   │   ├── data_dependent_app
│   │   └── some
│   │       └── sub
│   │           └── folder
│   │               └── runfile_symlinks_link
│   └── MANIFEST
├── data_dependent_app.runfiles_manifest
└── sub_folder
    └── runfile_symlinks.json
```


###### Providing files through root_symlink
```python
data = [
    # ":data_runfile",
    # ":default_runfile",
    # ":runfile",
    ":runfile_root_symlinks",
    # ":runfile_symlinks",
],
```
Providing data through the `root_symlink` puts it directly to the root of the runfiles directory.
It is then not directly accessible for the application but can be explicitely mapped to fit certain workspace requirements.
The same applies basically as for `symlink` runfiles, rather by default they are not seen by the application.

References
---------------
[1] https://docs.bazel.build/versions/master/skylark/lib/runfiles.html
[2] https://docs.bazel.build/versions/master/skylark/lib/DefaultInfo.html
[3] https://github.com/bazelbuild/bazel/blob/master/site/docs/skylark/rules.md#runfiles
[4] https://github.com/bazelbuild/examples/tree/master/rules/runfiles
