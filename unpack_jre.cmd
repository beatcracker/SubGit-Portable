@echo off
setlocal

set pwd=%~dp0
set zip=7z.exe
set no_zip_msg=Can't find 7z.exe! Set full path to 7z.exe in %~nx0 if it's not in %%PATH%%!
set jre_tmp=tmp
set jre_src=JRE_Installer
set jre_dst=JRE_Portable
set jre_bin=installerexe
set jre_packfiles=*.pack

where %zip% >nul 2>nul
if %errorlevel%==1 (
    echo %no_zip_msg%
    goto end
)

for /r "%pwd%%jre_src%\" %%a in ("jre-*.exe") do (
	echo Processing Java installer: %%a

	echo Removing previous version: "%pwd%%jre_dst%\%%~na"
	rd /s /q "%pwd%%jre_dst%\%%~na%"

	echo Unpacking "%%a" to "%pwd%%jre_dst%\%%~na\%jre_tmp%"
	"%zip%" e "%%a" -aoa -o"%pwd%%jre_dst%\%%~na\%jre_tmp%"

	echo Unpacking "%pwd%%jre_dst%\%%~na\%jre_tmp%\%jre_bin%" to "%pwd%%jre_dst%\%%~na"
	"%zip%" x "%pwd%%jre_dst%\%%~na\%jre_tmp%\%jre_bin%" -aoa -o"%pwd%%jre_dst%\%%~na"

	echo Deleting: "%pwd%%jre_dst%\%%~na\%jre_tmp%"
	rd /s /q "%pwd%%jre_dst%\%%~na\%jre_tmp%"

	echo Unpacking %jre_packfiles% files
	pushd "%pwd%%jre_dst%\%%~na"
	for /r %%b in (%jre_packfiles%) do (

		echo Unpacking "%%b" to "%%~db%%~pb%%~nb.jar"
		"%pwd%%jre_dst%\%%~na\bin\unpack200" -r "%%b" "%%~db%%~pb%%~nb.jar"

	)
	popd

)

:end
echo All done
pause

endlocal