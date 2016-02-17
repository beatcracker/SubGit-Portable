@echo off
setlocal

set verbose=^>nul
set pwd=%~dp0
set zip=7z.exe
set jre_tmp=tmp
set jre_src=JRE_Installer
set jre_dst=JRE_Portable
set jre_bin=installerexe
set jre_packfiles=*.pack
set jre_check=bin\java.exe

where %zip% >nul 2>nul
if %errorlevel%==1 (
    echo Can't find 7z.exe! Set full path to 7z.exe in %~nx0 if it's not in %%PATH%%!
    goto :end
)

for /r "%pwd%%jre_src%\" %%a in ("jre-*.exe") do (
	echo Processing JRE installer: %%~nxa

    if exist "%pwd%%jre_dst%\%%~na\%jre_check%" (

    	echo Removing previous version: "%pwd%%jre_dst%\%%~na"
    	rd /s /q "%pwd%%jre_dst%\%%~na%"

    )

	echo Unpacking "%%~nxa" to "%pwd%%jre_dst%\%%~na\%jre_tmp%"
	"%zip%" e "%%a" -aoa -o"%pwd%%jre_dst%\%%~na\%jre_tmp%" %verbose%

	echo Unpacking "%pwd%%jre_dst%\%%~na\%jre_tmp%\%jre_bin%" to "%pwd%%jre_dst%\%%~na"
	"%zip%" x "%pwd%%jre_dst%\%%~na\%jre_tmp%\%jre_bin%" -aoa -o"%pwd%%jre_dst%\%%~na" %verbose%

    if exist "%pwd%%jre_dst%\%%~na\%jre_tmp%\%jre_bin%" (

    	echo Deleting: "%pwd%%jre_dst%\%%~na\%jre_tmp%"
    	rd /s /q "%pwd%%jre_dst%\%%~na\%jre_tmp%"

    )

	echo Unpacking %jre_packfiles% files
	pushd "%pwd%%jre_dst%\%%~na"
	for /r %%b in (%jre_packfiles%) do (

        echo %%~nxb -^> %%~nb.jar %verbose%
		"%pwd%%jre_dst%\%%~na\bin\unpack200" -r "%%b" "%%~db%%~pb%%~nb.jar"

	)
	popd

)

for /r "%pwd%%jre_src%\" %%a in ("jre-*.tar.gz") do (

    echo Processing JRE archive: %%~nxa

    for /f "tokens=6 usebackq" %%J in (`call "%zip%" x "%%a" -so 2^>nul ^| "%zip%" l -ttar -si ^| findstr /r /i "jre[^^\\]*$"`) do (

        if exist "%pwd%%jre_dst%\%%J\%jre_check%" (
    
        	echo Removing previous version: "%pwd%%jre_dst%\%%J"
        	rd /s /q "%pwd%%jre_dst%\%%J"
    
        )

    	echo Unpacking "%%J" to "%pwd%%jre_dst%\%%J"
        "%zip%" x "%%a" -so 2>nul | "%zip%" x -aoa -ttar -o"%pwd%%jre_dst%" -si %verbose%

    )

)

:end
echo All done
pause

endlocal