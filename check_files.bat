@echo off
setlocal enabledelayedexpansion

REM Prompt the user for inputs
set /p "source_folder=Enter the path to the source folder: "
set /p "target_folder=Enter the path to the target folder: "
set /p "log_file=Enter the path to the log file (including file name): "

REM Check if the folders and log file are specified
if "%source_folder%"=="" (
    echo Source folder path cannot be empty.
    goto end
)
if "%target_folder%"=="" (
    echo Target folder path cannot be empty.
    goto end
)
if "%log_file%"=="" (
    echo Log file path cannot be empty.
    goto end
)

REM Initialize log file
> "%log_file%" echo Files not found in target folder:

REM Recursive file search
call :searchFiles "%source_folder%" "%target_folder%" "%log_file%"

echo Done. Check the log file at "%log_file%".

goto end

:searchFiles
set "source_folder=%~1"
set "target_folder=%~2"
set "log_file=%~3"

REM Iterate through each file in source folder
for /r "%source_folder%" %%F in (*) do (
    set "relative_path=%%F"
    set "relative_path=!relative_path:%source_folder%=!"
    if not exist "%target_folder%!relative_path!" (
        echo !relative_path! >> "%log_file%"
    )
)
exit /b

:end
pause
