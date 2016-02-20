@echo off
setlocal

rem Change jre_dir to match your unpacked JRE dir name in JRE_Portable
set jre_dir=jre-8u40-windows-x64
set subgit=%~dp0subgit\bin\subgit.bat
set JAVA_HOME=%~dp0JRE_Portable\%jre_dir%
set HOME=%~dp0home

%subgit% %*

endlocal
