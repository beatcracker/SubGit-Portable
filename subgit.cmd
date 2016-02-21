@echo off
setlocal

rem Set jre_dir to match your unpacked JRE dir name in JRE_Portable
set jre_dir=
set jre_check=bin\java.exe
set subgit=%~dp0SubGit\bin\subgit.bat
set JAVA_HOME=%~dp0JRE_Portable\%jre_dir%

if exist "%JAVA_HOME%\%jre_check%" (

	%subgit% %*

) else (

	echo Can't find JRE in folder: "%jre_dir%"
	echo Set name of the extracted JRE folder in "%~nx0".
	echo Example: "set jre_dir=jre-8u40-windows-x64"
	pause

)

endlocal
