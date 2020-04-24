@echo off

pushd C:\dev\bazel-learning\bazel_cquery_tag_filter
set bazel=C:\dev\home\bazel\bazel-bin\src\bazel.exe

break>.bazelrc

%bazel% shutdown

REM Expect to see //package_b:package_b as a dependency
CALL :call_bazel
set result=%errorlevel%
IF /I "%result%" NEQ "0" (
    popd
    EXIT /B 1
)

REM Expect to see no dependency:
echo build --build_tag_filters=-foo> .bazelrc
CALL :call_bazel
set result=%errorlevel%
IF /I "%result%" NEQ "1" (
    popd
    EXIT /B 1
)


break>.bazelrc
REM Expect to see //package_b:package_b as a dependency
CALL :call_bazel
set result=%errorlevel%
IF /I "%result%" NEQ "0" (
    popd
    EXIT /B 1
)
EXIT /B 0


:call_bazel
%bazel%  cquery deps(//package_a/...) --noimplicit_deps --nohost_deps --notool_deps 2>&1 | findstr /R /C:"//package_b:package_b"
EXIT /B %errorlevel%
