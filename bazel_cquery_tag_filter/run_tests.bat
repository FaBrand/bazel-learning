@echo off

CALL :run_test 2.0.0
CALL :run_test 2.1.0

EXIT /B 0

:run_test
SETLOCAL
set version=%1
echo Runnning with version: %version%
echo %version%> .bazelversion
break>.bazelrc

bazel shutdown
bazel version

echo ############################################################
echo Expect to see //package_b:package_b as a dependency
pause
echo 
CALL :call_bazel 0
echo ############################################################
pause

echo ############################################################
echo Expect to see no dependency:
pause
echo 
echo build --build_tag_filters=-foo> .bazelrc
CALL :call_bazel 1
echo ############################################################
pause


break>.bazelrc

echo ############################################################
echo Expect to see //package_b:package_b as a dependency
pause
echo 
CALL :call_bazel 0
echo ############################################################
pause
ENDLOCAL
EXIT /B 0



:call_bazel
echo Content of .bazelrc:
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
type .bazelrc
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

bazel  cquery deps(//package_a/...) --noimplicit_deps --nohost_deps --notool_deps  >output.txt 2>&1
EXIT /B 0
