# Python runtime toolchains

The best description i could find about how to use this:
[#7899](https://github.com/bazelbuild/bazel/issues/7899)

```
Flag: --incompatible_use_python_toolchains
Available since: 0.25
Will be flipped in: 0.27
Feature tracking issue: #7375
```

### Using python2 dependencies in python3 targets

As of [issues/1393#issuecomment-431110617](https://github.com/bazelbuild/bazel/issues/1393#issuecomment-431110617)
`2to3` is just stubbed for bazel. Therefore dependencies must be version consistent.

### Debugging python2/3 dependency errors

There is an aspect to show dependencies of python libraries in [bazel_tools](https://github.com/bazelbuild/bazel/blob/master/tools/python/srcs_version.bzl)
This is what the output would look like for the two defined python binaries
```bash
$ bazel build //:python3 \
    --aspects=@bazel_tools//tools/python:srcs_version.bzl%find_requirements \
    --output_groups=pyversioninfo

$ cat bazel-bin/python3-pyversioninfo.txt
Python 2-only deps:
<None>

Python 3-only deps:
//:python3_dependency
//:python3only_dependency

Paths to these deps:
//:python3 -> //:python3_dependency
//:python3 -> //:python3only_dependency
```

The python2 versions get put into their own bazel-bin directory
```bash
$ bazel build //:python2 \
    --aspects=@bazel_tools//tools/python:srcs_version.bzl%find_requirements \
    --output_groups=pyversioninfo

$ cat bazel-out/k8-py2-fastbuild/bin/python2-pyversioninfo.txt
Python 2-only deps:
//:python2only_dependency

Python 3-only deps:
<None>

Paths to these deps:
//:python2 -> //:python2only_dependency
```
