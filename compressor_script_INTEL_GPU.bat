@echo off
setlocal enabledelayedexpansion

#set INPUT to a file directory instead of a folder to process one file and folder directory to process multiple files automatically.


set "INPUT="
set "KEY="
set "WORK="
set "OUTPUT="
set "DIRECTORY="
#Directory where the command is located.
set "GPU_PRESET="
#Set it to P1(better quality) to P7(faster processing)

uvx wannacri extractusm "%INPUT%" --key %KEY% -o "%WORK%"
for /r "%WORK%" %%f in (*.ivf) do (
    for /f "tokens=2 delims== " %%a in ('ffprobe -v 0 -select_streams v:0 -show_entries format^=bit_rate -of default^=noprint_wrappers^=1 "%%f"') do (
        set /a target=%%a/6
        
        ffmpeg -init_hw_device qsv=hw -hwaccel qsv -c:v vp9 -i "%%f" -r 30 -c:v vp9_qsv -low_power 1 -b:v !target! -maxrate !target! -bufsize !target! -preset p4 -pix_fmt yuv420p "%%f.tmp.ivf"
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
