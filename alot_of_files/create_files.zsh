#!/bin/zsh
git clean -xfd
n=1000
mkdir target_{1..$n}
touch target_{1..$n}/BUILD
touch target_{1..$n}/source_file.cpp
touch target_{1..$n}/source_file.h

cat ./BUILD.template > target_{1..$n}/BUILD
cat ./source_file.cpp.template > target_{1..$n}/source_file.cpp
cat ./source_file.h.template > target_{1..$n}/source_file.h

sed -i "/<DEP>/d" target_1/BUILD

for n in {2..$n}; do
    (( x=$n - 1 ))
    sed -i "s#<DEP>#//target_${x}:a_lib#g" target_${n}/BUILD
done

mkdir /tmp/profile 2>&1 > /dev/null

bazel build --nobuild --profile=/tmp/profile/no-build-profile //...
bazel analyze-profile /tmp/profile/no-build-profile

bazel build --profile=/tmp/profile/build-profile //...
bazel analyze-profile /tmp/profile/build-profile
