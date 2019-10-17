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
