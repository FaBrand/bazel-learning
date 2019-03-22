# What Test enviroments variable can be set by the user?

Bazel does set some environment variables according to [this article](https://docs.bazel.build/versions/master/test-encyclopedia.html#initial-conditions)

However some additional variables may need to be set.

I created this small helper to check which environment variables get passed to the test in which way and to  memorize it more easily.

# 'Test' setup

I defined 6 env-vars in the [.bazelrc](./.bazelrc) that should be passed to the test.
Use this small snippet to run the test binary.

```bash
export TEST_ENV_VARIABLE_FROM_ENV_WITH_VALUE=FIZZBUZZ
export TEST_ENV_VARIABLE_FROM_ENV_WITHOUT_VALUE=FIZZBUZZ
export TEST_ENV_VARIABLE_FROM_ENV_ONLY_DEFINED=FIZZBUZZ
export ACTION_ENV_VARIABLE_FROM_ENV_WITH_VALUE=FIZZBUZZ
export ACTION_ENV_VARIABLE_FROM_ENV_WITHOUT_VALUE=FIZZBUZZ
export ACTION_ENV_VARIABLE_FROM_ENV_ONLY_DEFINED=FIZZBUZZ

# This will show you which environment variables the test executable sees
bazel test ... 2>&1 | grep ENV_VARIABLE
```

# Output with bazel 0.23.2

With only `--test_env`'s being set. [ref](https://docs.bazel.build/versions/master/command-line-reference.html#flag--test_env)
```bash
$ bazel test ... 2>&1 | grep ENV_VARIABLE
TEST_ENV_VARIABLE_WITH_VALUE=FOOBAR
TEST_ENV_VARIABLE_FROM_ENV_WITHOUT_VALUE=
TEST_ENV_VARIABLE_FROM_ENV_WITH_VALUE=FOOBAR
TEST_ENV_VARIABLE_WITHOUT_VALUE=
TEST_ENV_VARIABLE_FROM_ENV_ONLY_DEFINED=FIZZBUZZ
```

With `--action_env`'s being set. [ref](https://docs.bazel.build/versions/master/command-line-reference.html#flag--action_env)
```bash
$ bazel test ... --config with_action 2>&1 | grep ENV_VARIABLE
TEST_ENV_VARIABLE_WITH_VALUE=FOOBAR
TEST_ENV_VARIABLE_FROM_ENV_WITHOUT_VALUE=
ACTION_ENV_VARIABLE_FROM_ENV_WITH_VALUE=FOOBAR
ACTION_ENV_VARIABLE_WITH_VALUE=FOOBAR
TEST_ENV_VARIABLE_FROM_ENV_WITH_VALUE=FOOBAR
ACTION_ENV_VARIABLE_FROM_ENV_WITHOUT_VALUE=
TEST_ENV_VARIABLE_WITHOUT_VALUE=
TEST_ENV_VARIABLE_FROM_ENV_ONLY_DEFINED=FIZZBUZZ
ACTION_ENV_VARIABLE_WITHOUT_VALUE=
ACTION_ENV_VARIABLE_FROM_ENV_ONLY_DEFINED=FIZZBUZZ
```
