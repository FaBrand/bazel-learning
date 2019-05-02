# Find & run all dependend tests of a target

Assume you have a binary `b` which aggregates multible libraries `l1, l2`.
If you want to run all all tests that test depend on the libraries which were used when building `b`,

Of course you could run all tests using `bazel test ...` but this is not considered an option for this case.

You can use some bazel queries to achieve that.
This is the final call:
```bash
bazel test $(bazel query --noimplicit_deps 'tests(rdeps(set(//...), deps(//:b)))')
```

Let's disect it:
`$ assumes bazel query for simplicity`

1. We need to get the targets on which `b` depends using [deps](https://docs.bazel.build/versions/master/query.html#deps)

```bash
$ 'deps(//:b)'
```

Yields all dependencies including the toolchain dependencies, lets circumvent this:

```bash
$ --noimplicit_deps 'deps(//:b)'
```

2. Now we have all libraries of which we want to execute the tests.
We can find them using the simple case of [rdeps](https://docs.bazel.build/versions/master/query.html#rdeps)

For our universe set we use all targets `set(//...)`

```bash
$ --noimplicit_deps 'rdeps(set(//...), deps(//:b))'
```
This yields also our test targets.

3. In the last step, the targets are filtered for test labels. query has a function for that: [tests](https://docs.bazel.build/versions/master/query.html#tests)
```bash
$ --noimplicit_deps 'tests(rdeps(set(//...), deps(//:b)))'
```

4. Pipe the results to a `bazel test` call using a subshell
```bash
$ bazel test $(bazel query --noimplicit_deps 'tests(rdeps(set(//...), deps(//:b)))')
//l1:l1_test                                                             PASSED in 0.1s
//l2:l2_test                                                             PASSED in 0.1s
//l2/tests:l2_test                                                       PASSED in 0.1s
```

## Conclusion

As `bazel test ...` would execute all tests. More than required in this case.
```diff
# diff <(bazel test ... --nocache_test_results) <(bazel query --noimplicit_deps 'let target=//:b in let closure=//... in tests(rdeps(set($closure), deps($target)))') -y                                                                                                  2 ↵
//l1:l1_test                                                  | //l1:l1_test
//l2:l2_test                                                  | //l2:l2_test
//l2/tests:l2_test                                            | //l2/tests:l2_test
//l3:l3_test                                                  <
```

Using rdeps allows to run the tests that directly go into the selected closure.

You could even name the variables:
```
$ --noimplicit_deps 'let target=//:b in let closure=//... in tests(rdeps(set($closure), deps($target)))'
```

## References

1) [bazel query doc](https://docs.bazel.build/versions/master/query.html)
2) [bazel query how-to](https://docs.bazel.build/versions/master/query-how-to.html)
