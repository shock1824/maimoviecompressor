@echo off
setlocal enabledelayedexpansion

#set INPUT to a folder location instead of a file directory to process one file and folder directory to process multiple files automatically.
set KEY=
set INPUT=
set WORK=
set OUTPUT=
#Directory where the mai2dat is located.
set DIRECTORY=
#Set GPU PRESET it to P1(better quality) to P7(faster processing)
set GPU_PRESET=
set compression rate=

uvx wannacri extractusm "%INPUT%" --key %KEY% -o "%WORK%"

for /r "%WORK%" %%f in (*.ivf) do (
    for /f "tokens=2 delims== " %%a in ('ffprobe -v 0 -select_streams v:0 -show_entries format^=bit_rate -of default^=noprint_wrappers^=1 "%%f"') do (
        
        set /a target=%%a/%compression rate%
        set /a buffer=!target!*2
        
        ffmpeg -init_hw_device qsv=hw:hw,child_device=1 -hwaccel qsv -c:v vp9 -i "%%f" -r 30 -c:v vp9_qsv -preset %GPU_PRESET% -b:v !target! -minrate !target!-maxrate !target! -bufsize !buffer! -pix_fmt yuv420p "%%f.tmp.ivf"
        move /y "%%f.tmp.ivf" "%%f"
    )
)

cd /d %DIRECTORY%
set "processedFolders="

for /r %WORK% %%f in (*.ivf) do (
    set "fullpath=%%~dpf"
    
    rem remove trailing backslash
    if "!fullpath:~-1!"=="\" set "fullpath=!fullpath:~0,-1!"
    
    rem extract grandparent folder reliably
    for %%a in ("!fullpath!") do set "parentFolder=%%~nxa"
    for %%a in ("!fullpath!") do set "tempPath=%%~dpa"
    if "!tempPath:~-1!"=="\" set "tempPath=!tempPath:~0,-1!"
    for %%a in ("!tempPath!") do set "grandparentFolder=%%~nxa"
    
    rem check if already processed
    echo !processedFolders! | findstr /i /c:"!grandparentFolder!" >nul
    if errorlevel 1 (
        uv run main.py "%%f" "%OUTPUT%\!grandparentFolder!"
        set "processedFolders=!processedFolders! !grandparentFolder!"
    )
)

pause
