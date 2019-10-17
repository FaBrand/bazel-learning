# Clang tidy with bazel

Inspired by (grailbio/bazel-compilation-database)[https://github.com/grailbio/bazel-compilation-database]

To run the analysis on selected targets build
```bash
bazel build //:clang_tidy_main
```

To run the analysis from the command line, use:
```bash
bazel build ... --aspects static_analysis/clang_tidy.bzl%clang_tidy_aspect
```
or
```bash
bazel build ... --config clang-tidy
```


### Configurability
To use a static `.clang-tidy` file the problem is that the aspect does not see the file in its sandboxed environment.
One approach could be to explicitely add it as an input to the aspect.
However this is not really configurable since it allows only for one global file and this is implicitely coupled to the aspect

