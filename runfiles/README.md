# Runfiles
### This is an learning by doing example on how runfiles can be used

Copy & paste execution of the different apps that have the different kinds of runfiles in direct or transitive dependency

```bash
bazel run -- //:app
```
```bash
bazel run -- //:dependent_app
```
```bash
bazel run -- //:data_dependent_app
```
