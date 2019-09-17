Normal build
------------------------------------------------
```bash
bazel build //:main -s
```

With the feature being enabled
------------------------------------------------
```bash
bazel build :main --features=custom_include_paths -s 2>&1 | grep foobar
```

Here it can be see that the include path `-Ifoobar` is added to the command
