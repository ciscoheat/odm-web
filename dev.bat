:: Exit with Ctrl+Break
@echo off
start /b cmd /c http-server bin -p8080 -o -c-1
start /b cmd /c php -S localhost:8081 -t bin