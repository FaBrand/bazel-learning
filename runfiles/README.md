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

### Layout of the bazel-bin directory with packaged files
```bash
$ tree bazel-bin/
bazel-bin/
├── app
├── app_pkg.args
├── app_pkg.tar
├── app.runfiles
│   ├── __main__
│   │   ├── app -> <execroot>/bazel-out/k8-fastbuild/bin/app
│   │   ├── app.py -> <repo_path>/runfiles/app.py
│   │   ├── data_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/data_runfile.json
│   │   ├── default_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/default_runfile.json
│   │   ├── runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile.json
│   │   ├── runfile_root_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_root_symlinks.json
│   │   ├── runfile_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_symlinks.json
│   │   └── runfile_symlinks_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_symlinks.json
│   ├── MANIFEST
│   └── runfile_root_symlinks_root_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_root_symlinks.json
├── app.runfiles_manifest
├── data_dependent_app
├── data_dependent_app_pkg.args
├── data_dependent_app_pkg.tar
├── data_dependent_app.runfiles
│   ├── __main__
│   │   ├── app -> <execroot>/bazel-out/k8-fastbuild/bin/app
│   │   ├── app.py -> <repo_path>/runfiles/app.py
│   │   ├── data_dependent_app -> <execroot>/bazel-out/k8-fastbuild/bin/data_dependent_app
│   │   ├── data_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/data_runfile.json
│   │   ├── default_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/default_runfile.json
│   │   ├── runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile.json
│   │   ├── runfile_root_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_root_symlinks.json
│   │   ├── runfile_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_symlinks.json
│   │   └── runfile_symlinks_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_symlinks.json
│   ├── MANIFEST
│   └── runfile_root_symlinks_root_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_root_symlinks.json
├── data_dependent_app.runfiles_manifest
├── data_runfile.json
├── default_runfile.json
├── dependent_app
├── dependent_app_pkg.args
├── dependent_app_pkg.tar
├── dependent_app.runfiles
│   ├── __main__
│   │   ├── app -> <execroot>/bazel-out/k8-fastbuild/bin/app
│   │   ├── app.py -> <repo_path>/runfiles/app.py
│   │   ├── data_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/data_runfile.json
│   │   ├── default_runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/default_runfile.json
│   │   ├── dependent_app -> <execroot>/bazel-out/k8-fastbuild/bin/dependent_app
│   │   ├── runfile.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile.json
│   │   ├── runfile_root_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_root_symlinks.json
│   │   ├── runfile_symlinks.json -> <execroot>/bazel-out/k8-fastbuild/bin/runfile_symlinks.json
│   │   └── runfile_symlinks_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_symlinks.json
│   ├── MANIFEST
│   └── runfile_root_symlinks_root_link -> <execroot>/bazel-out/k8-fastbuild/bin/sub_folder/runfile_root_symlinks.json
├── dependent_app.runfiles_manifest
├── runfile.json
├── runfile_root_symlinks.json
├── runfile_symlinks.json
└── sub_folder
    ├── runfile_root_symlinks.json
    └── runfile_symlinks.json
```
