# Possible cquery bug

### Abstract 
Bazel cquery seems to ignore changes in --build_tags_filter starting with bazel 2.1.0.

It can be reproduced on windows and linux (ubuntu window-subsystem-linux) using the provided scripts

`run_tests.bat` or `run_tests.bat`

#### Description

I'm using bazelisk for version handling.
Starting with a clean version of this workspace.

####### 1
The scripts run bazel cquery 3 times to show the deps of `//package_b/...`
Without any filters set this should resolve to `//package_a` and `//package_b`

####### 2
As a next step a `--build_tags_filter` is introduced which removes `//package_b:package_b` from
the wildcard selection.

Expected behaviour now is that no targets are found.

####### 3
In the third step this filter is removed again, and the same results from the first step should be found.


#### Error case
Starting from bazel 2.1.0, Step 2 still returns the same result as step 1 even tough it should not.
This is the case up to and including version 3.1.0


### Bisect result

I did a git bisect between the tags 2.1.0 and 2.0.0
This lead to this commit:
```
9f9b919ecc00cb36787ac0d0936394d983df51f9 is the first bad commit
commit 9f9b919ecc00cb36787ac0d0936394d983df51f9
Author: gregce <gregce@google.com>
Date:   Tue Jan 7 13:31:04 2020 -0800

    Make cquery 'somepath' more accurate.

    Specifically, make somepath(//foo, //bar) report results
    when //bar isn't built in the top-level configuration (because
    of a transition).

    To really work properly, this requires --universe_scope:

    $ blaze cquery 'somepath(//foo, //bar)' -- universe_scope=//foo

    Otherwise, //bar also gets built in the top-level configuration and
    somepath looks for *that* version, which is not the one in //foo's
    deps.

    RELNOTES: cquery 'somepath' returns more reliable results when the
    dep has a different configuration than the parent. To get a result for
    `somepath(//foo, //bar`) where //bar isn't in the top-level configuration,
    run your query with `--universe_scope=//foo`. See cquery docs for details.
    PiperOrigin-RevId: 288560710
```
