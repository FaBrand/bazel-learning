### protobuf

Works
```bash
env USE_BAZEL_VERSION=0.24.1 bazel build ...
env USE_BAZEL_VERSION=0.24.1 bazel aquery 'mnemonic("CppCompile", //a_library:lib)'

```

Fails
```bash
env USE_BAZEL_VERSION=0.25.0 bazel build ...
env USE_BAZEL_VERSION=0.25.0 bazel aquery 'mnemonic("CppCompile", //a_library:lib)'
```

With [bazelisk](https://github.com/philwo/bazelisk) installed we can run both versions of the tool:
```bash
env USE_BAZEL_VERSION=0.24.1 bazel aquery 'mnemonic("CppCompile", //a_library:lib)'
env USE_BAZEL_VERSION=0.25.0 bazel aquery 'mnemonic("CppCompile", //a_library:lib)'
```

| building with bazel 0.24.1                                                   | building with bazel 0.25.0                                                                   |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| action 'Compiling a_library/lib.cpp'                                         | action 'Compiling a_library/lib.cpp'                                                         |
| Mnemonic: CppCompile                                                         | Mnemonic: CppCompile                                                                         |
| Target: //a_library:lib                                                      | Target: //a_library:lib                                                                      |
| Configuration: k8-fastbuild                                                  | Configuration: k8-fastbuild                                                                  |
| Command Line: (exec /usr/bin/gcc \                                           | Command Line: (exec /usr/bin/gcc \                                                           |
| -U_FORTIFY_SOURCE \                                                          | -U_FORTIFY_SOURCE \                                                                          |
| -fstack-protector \                                                          | -fstack-protector \                                                                          |
| -Wall \                                                                      | -Wall \                                                                                      |
| -Wunused-but-set-parameter \                                                 | -Wunused-but-set-parameter \                                                                 |
| -Wno-free-nonheap-object \                                                   | -Wno-free-nonheap-object \                                                                   |
| -fno-omit-frame-pointer \                                                    | -fno-omit-frame-pointer \                                                                    |
| '-std=c++0x' \                                                               | '-std=c++-1x' \                                                                              |
| -MD \                                                                        | -MD \                                                                                        |
| -MF \                                                                        | -MF \                                                                                        |
| bazel-out/k8-fastbuild/bin/a_library/_objs/lib/lib.pic.d \                   | bazel-out/k8-fastbuild/bin/a_library/_objs/lib/lib.pic.d \                                   |
| '-frandom-seed=bazel-out/k8-fastbuild/bin/a_library/_objs/lib/lib.pic.o' \   | '-frandom-seed=bazel-out/k8-fastbuild/bin/a_library/_objs/lib/lib.pic.o' \                   |
| -fPIC \                                                                      | -fPIC \                                                                                      |
| -iquote \                                                                    | -iquote \                                                                                    |
| . \                                                                          | . \                                                                                          |
| -iquote \                                                                    | -iquote \                                                                                    |
| bazel-out/k8-fastbuild/genfiles \                                            |                                                                                              |
| -iquote \                                                                    |                                                                                              |
| bazel-out/k8-fastbuild/bin \                                                 | bazel-out/k8-fastbuild/bin \                                                                 |
| -iquote \                                                                    | -iquote \                                                                                    |
| external/com_google_protobuf \                                               | external/com_google_protobuf \                                                               |
| -iquote \                                                                    |                                                                                              |
| bazel-out/k8-fastbuild/genfiles/external/com_google_protobuf \               |                                                                                              |
| -iquote \                                                                    | -iquote \                                                                                    |
| bazel-out/k8-fastbuild/bin/external/com_google_protobuf \                    | bazel-out/k8-fastbuild/bin/external/com_google_protobuf \                                    |
| -Ibazel-out/k8-fastbuild/bin/a_library/_virtual_includes/lib \               | -Ibazel-out/k8-fastbuild/bin/a_library/_virtual_includes/lib \                               |
|                                                                              | -Ibazel-out/k8-fastbuild/bin/some/sub/package/path/proto_pkg/_virtual_includes/proto_pkg \   |
| -isystem \                                                                   | -isystem \                                                                                   |
| some/sub/package/path \                                                      | some/sub/package/path \                                                                      |
| -isystem \                                                                   |                                                                                              |
| bazel-out/k8-fastbuild/genfiles/some/sub/package/path \                      |                                                                                              |
| -isystem \                                                                   | -isystem \                                                                                   |
| bazel-out/k8-fastbuild/bin/some/sub/package/path \                           | bazel-out/k8-fastbuild/bin/some/sub/package/path \                                           |
| -isystem \                                                                   | -isystem \                                                                                   |
| external/com_google_protobuf/src \                                           | external/com_google_protobuf/src \                                                           |
| -isystem \                                                                   | -isystem \                                                                                   |
| bazel-out/k8-fastbuild/genfiles/external/com_google_protobuf/src \           |                                                                                              |
| -isystem \                                                                   |                                                                                              |
| bazel-out/k8-fastbuild/bin/external/com_google_protobuf/src \                | bazel-out/k8-fastbuild/bin/external/com_google_protobuf/src \                                |
| -fno-canonical-system-headers \                                              | -fno-canonical-system-headers \                                                              |
| -Wno-builtin-macro-redefined \                                               | -Wno-builtin-macro-redefined \                                                               |
| '-D__DATE__="redacted"' \                                                    | '-D__DATE__="redacted"' \                                                                    |
| '-D__TIMESTAMP__="redacted"' \                                               | '-D__TIMESTAMP__="redacted"' \                                                               |
| '-D__TIME__="redacted"' \                                                    | '-D__TIME__="redacted"' \                                                                    |
| -c \                                                                         | -c \                                                                                         |
| a_library/lib.cpp \                                                          | a_library/lib.cpp \                                                                          |
| -o \                                                                         | -o \                                                                                         |
| bazel-out/k8-fastbuild/bin/a_library/_objs/lib/lib.pic.o)                    | bazel-out/k8-fastbuild/bin/a_library/_objs/lib/lib.pic.o)                                    |












|
































