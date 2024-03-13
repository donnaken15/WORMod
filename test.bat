@echo off
pushd "%~dp0"
cmd /c build.bat notimeout
set WITH=for /f "usebackq tokens=*" %%v in
%WITH% ("outdir.txt") do (
	if exist "%%v\..\..\game.exe" (
		rem stupid
		start /D "%%v\..\..\" "" "%%v\..\..\game.exe"
	)
)
popd
