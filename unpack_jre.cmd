@echo off
Setlocal EnableDelayedExpansion

rem Set full path to 7Zip.exe if it's not in %PATH%
set zip=7z.exe
set xtmp=tmp
set jre_distr=JRE_Installer
set jre_folder=JRE_Portable
set jre_inst=installerexe
set packfiles=*.pack
set pwd=%~dp0

for /r "%pwd%%jre_distr%\" %%a in ("jre-*.exe") do (
	echo Processing Java installer: %%a

	echo Removing previous version: "%pwd%%jre_folder%\%%~na"
	rd /s /q "%pwd%%jre_folder%\%%~na%"

	echo Unpacking "%%a" to "%pwd%%jre_folder%\%%~na\%xtmp%"
	"%zip%" e "%%a" -aoa -o"%pwd%%jre_folder%\%%~na\%xtmp%"

	echo Unpacking "%pwd%%jre_folder%\%%~na\%xtmp%\%jre_inst%" to "%pwd%%jre_folder%\%%~na"
	"%zip%" x "%pwd%%jre_folder%\%%~na\%xtmp%\%jre_inst%" -aoa -o"%pwd%%jre_folder%\%%~na"

	echo Deleting: "%pwd%%jre_folder%\%%~na\%xtmp%"
	rd /s /q "%pwd%%jre_folder%\%%~na\%xtmp%"

	echo Unpacking %packfiles% files
	pushd "%pwd%%jre_folder%\%%~na"
	for /r %%b in (%packfiles%) do (

		echo Unpacking "%%b" to "%%~db%%~pb%%~nb.jar"
		"%pwd%%jre_folder%\%%~na\bin\unpack200" -r "%%b" "%%~db%%~pb%%~nb.jar"

	)
	popd

)



echo All done
pause >nul

endlocal