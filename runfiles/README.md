# Runfiles
### This is an learning by doing example on how runfiles can be used

Copy & paste execution of the different apps that have the different kinds of runfiles in direct or transitive dependency

### Structure of output directory with the basic application
```bash
bazel run -- //:app
```
```bash
app -> <execroot>/bazel-out/k8-fastbuild/bin/app
app.py -> <repo_path>/runfiles/app.py
data_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/data_runfile.json
default_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/default_runfile.json
runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile.json
runfile_root_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_root_symlinks.json
runfile_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_symlinks.json
runfile_symlinks_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_symlinks.json
```

### Structure of output directory with the dependent_app
```bash
bazel run -- //:dependent_app
```
```bash
app -> <execroot>/bazel-out/k8-fastbuild/bin/app
app.py -> <repo_path>/runfiles/app.py
data_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/data_runfile.json
default_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/default_runfile.json
dependent_app -> <execroot>/bazel-out/k8-fastbuild/bin/dependent_app
runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile.json
runfile_root_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_root_symlinks.json
runfile_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_symlinks.json
runfile_symlinks_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_symlinks.json
```

### Structure of output directory with the data_dependent_app
```bash
bazel run -- //:data_dependent_app
```
```bash
app -> <execroot>/bazel-out/k8-fastbuild/bin/app
app.py -> <repo_path>/runfiles/app.py
data_dependent_app -> <execroot>/bazel-out/k8-fastbuild/bin/data_dependent_app
data_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/data_runfile.json
default_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/default_runfile.json
runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile.json
runfile_root_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_root_symlinks.json
runfile_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_symlinks.json
runfile_symlinks_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_symlinks.json
```
