# Scenario
A test is linked against different libraries based on config settings.
The test asserts that the only function in those libraries `int Foo()` returns a 0.

By switching to the other libraries, the test fails, as the functions don't return 0.

# Learning:
This Config is not triggered by the --config=fail passed via the command line
it triggers once the defines match the values.


With this the test fails
```
bazel test //... --define test_outcome=fail
```

With this the test succeeds
```
e.g. bazel test //... --define test_outcome=succeed
```

With this the test fails again, but for a different reason.
```
bazel test //... --define test_outcome=succeed --define override=
```

The --config option only selects the appropriate calls which are stored in the .bazelrc

