@echo off
setlocal

:: Set source and destination paths
set "SOURCE=C:\git\mountmaster"
set "DEST=C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\Ruthes_MountSelector"

:: Copy only files (ignore directories)
for %%F in ("%SOURCE%\*") do (
    if not exist "%%F\" (
        copy "%%F" "%DEST%"
    )
)

echo Files copied successfully.
pause
endlocal
