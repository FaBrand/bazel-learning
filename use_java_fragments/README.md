# Usage of the java runtimes

It can be necessary for tools to use the builtin java runtime.
This is one way of doing so.
Unfortunately i could not it to work using the `toolchains` argument of the `rule` constructor.
Apparently the default `java_toolchain` aka `@bazel_tools//tools/jdk:current_host_java_runtime` does not expose
the necessary providers.

Using it fails with:
```bash
ERROR: While resolving toolchains for target //:use_java: Target @bazel_tools//tools/jdk:current_host_java_runtime was referenced as a toolchain type, but does not provide ToolchainTypeInfo
```

Another approach with using the [JavaRuntimeInfo](https://docs.bazel.build/versions/0.27.0/skylark/lib/JavaRuntimeInfo.html) with its [java_home_runfiles_path](https://docs.bazel.build/versions/0.27.0/skylark/lib/JavaRuntimeInfo.html#java_executable_runfiles_path) argument did not work out
since the `PathFragment` Class apparently is not usable in Starlark.

I then used the solution applied [here](https://github.com/tensorflow/tensorflow/pull/27206/files)

#### References
[1] https://github.com/bazelbuild/bazel/issues/5594
[2] https://github.com/tensorflow/tensorflow/pull/27206/files
[3] https://docs.bazel.build/versions/master/skylark/lib/java_common.html#JavaRuntimeInfo
[4] https://docs.bazel.build/versions/0.27.0/skylark/lib/JavaRuntimeInfo.html
