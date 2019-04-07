### Using PyInfo to generate python libs

Change the `constant_value` attribute to vary what should be used when running the py binary that
uses the generated rule to access the defined constant value.
```python
gen_py_lib(
    name = "generated_lib",
    constant_value = 42,
    module = "MyLib",
)
```

Use this to run the binary that use the generated python lib
```bash
bazel run //:use_generated_py_lib
```

##### Learnings
Using PyInfo itself is not sufficient.
The same files need to be provided through runfiles.
This enables the inheriting rules to actually be able to "see" the files.

e.g. Output structure when not providing runfiles:
```bash
.
├── k8-fastbuild
│   ├── bin
│   │   ├── use_generated_py_lib
│   │   ├── use_generated_py_lib.runfiles
│   │   │   ├── __main__
│   │   │   │   ├── app.py
│   │   │   │   └── use_generated_py_lib
│   │   │   └── MANIFEST
│   │   └── use_generated_py_lib.runfiles_manifest
│   ├── genfiles
│   └── testlogs
├── stable-status.txt
├── _tmp
│   └── action_outs
└── volatile-status.txt
```

And with runfiles being set:
```bash
.
├── k8-fastbuild
│   ├── bin
│   │   ├── MyLib
│   │   │   └── __init__.py
│   │   ├── use_generated_py_lib
│   │   ├── use_generated_py_lib.runfiles
│   │   │   ├── __main__
│   │   │   │   ├── app.py
│   │   │   │   ├── MyLib
│   │   │   │   │   └── __init__.py
│   │   │   │   └── use_generated_py_lib
│   │   │   └── MANIFEST
│   │   └── use_generated_py_lib.runfiles_manifest
│   ├── genfiles
│   └── testlogs
├── stable-status.txt
├── _tmp
│   └── action_outs
└── volatile-status.txt
```

Transitive Sources seem not to impact which files get linked to rules using the generated files.
