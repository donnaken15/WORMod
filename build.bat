@echo off
set "OKNOTOK=|| goto :fail"
pushd "%~dp0"
echo [97m^<^<^<^<^<^<         GLOBAL.PAK          ^>^>^>^>^>^>[0m
::echo [97m######   emptying output folder    ######[0m
del "!cache\*" /S/Q 2>nul >nul
rmdir !cache\zones\global !cache\zones !cache 2>nul
echo [92m######   compile highway sprites   ######[0m
pushd highway
..\bin\buildtex >nul
popd
pushd fonts
..\bin\mkfonts
popd
mkdir "!cache" "!cache\zones\global"
copy "highway\__output.scn" "!cache\zones\global\global_gfx.scn.xen" /y >nul
copy "highway\__output.tex" "!cache\zones\global\global_gfx.tex.xen" /y >nul
del "highway\__output.scn" "highway\__output.tex"
echo [91m######      image generation       ######[0m
bin\imggen root\*.png root\*.jpg root\*.dds >nul %OKNOTOK%
echo [93m###### moving new generated images ######[0m
move root\*.img.xen "!cache" >nul %OKNOTOK%
echo [38;2;95;95;255m######     copying fonts (raw)     ######[0m
copy fonts\*.fnt.xen "!cache" >nul %OKNOTOK%
echo [38;2;255;127;0m###### compiling optional scripts  ######[0m
mkdir scripts 2>nul
for %%f in (scripts\*.q) do ( bin\node bin\QBC\QBC.js c "%%f" -o "!cache\%%fb.xen" -g gh3 )
echo [95m######        compiling PAK        ######[0m
bin\pakdir !cache global -z
echo [92mDone![0m
if not exist "global.pak.xen" ( echo [91mthe built global.pak cannot be found[0m & goto :fail )
del "!cache\*" /S/Q 2>nul >nul
rmdir !cache\zones\global !cache\zones !cache\scripts !cache 2>nul


echo.
echo [97m^<^<^<^<^<^<        GLOBAL_SFX.PAK       ^>^>^>^>^>^>[0m
echo [31m###### RENAMING SOUND FILES SRSLY  ######[0m
pushd sounds
mkdir zones zones\global_sfx 2>nul
rename *.mp3 *.wav.xen
echo [97m######        compiling PAK        ######[0m
..\bin\pakdir . ..\global_sfx
:: actual cringe
rename *.wav.xen *.
rename *.wav *.mp3
popd
echo [92mDone![0m
if not exist "global_sfx.pak.xen" ( echo [91mthe built global_sfx.pak cannot be found[0m & goto :fail )


set WITH=for /f "usebackq tokens=*" %%v in
%WITH% ("outdir.txt") do (
	copy globa*.pa*.xen "%%v"
)


if not "%1"=="notimeout" "%WINDIR%\system32\timeout" /t 5
popd
exit /b

:fail
echo [91mOne of the commands errored. Aborting.[0m
pause
popd
exit /b
