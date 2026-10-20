@echo off
mvn clean verify
if errorlevel 1 exit /b %ERRORLEVEL%
if not exist "target\hello.jar" (
    echo Expected target\hello.jar was not created. 1>&2
    exit /b 1
)
