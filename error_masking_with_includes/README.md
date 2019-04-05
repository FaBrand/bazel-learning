# Possible error masking when only using includes

The code has a intentional warning.
```bash
[...]library_includes.h:10:13: error: unused variable 'a' [-Werror=unused-variable]
         int a{};
```

Compiled with `-Werror` the build should fail when building.
Since the warning is in the header, the build should fail.

```bash
bazel build //includes_and_strip_prefix
echo "Built with includes and strip prefix"
```
### Building only with strip prefix and `includes=` fails as expected

```bash
bazel build //only_includes
echo "Built only with includes"
```
### Building only with `includes=` does compile! which it shouldn't

```bash
bazel build //only_strip_prefix
echo "Built only with strip_prefix"
```
### Building only with strip prefix fails as expected
