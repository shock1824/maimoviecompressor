@echo off
setlocal enabledelayedexpansion

set input=
set output=

uvx wannacri extractusm %input% --key 0x7F4551499DF55E68 -o %output%

pause
