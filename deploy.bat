@echo off
setlocal

set "SOURCE=C:\Users\Magguu\Documents\MagguuUI"
set "TARGET=C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\MagguuUI"

echo.
echo   MagguuUI Deploy
echo   ===============
echo.
echo   Von: %SOURCE%
echo   Nach: %TARGET%
echo.

if not exist "%SOURCE%" (
    echo   FEHLER: Quellordner nicht gefunden!
    pause
    exit /b 1
)

if not exist "%TARGET%" (
    echo   Zielordner existiert nicht, wird erstellt...
    mkdir "%TARGET%"
)

echo   Kopiere Dateien...
robocopy "%SOURCE%" "%TARGET%" /MIR /XD ".git" ".github" /XF "push.bat" "push.ps1" "unlock-git.bat" "deploy.bat" ".gitignore" "LICENSE.md" "README.md" "CODE_REVIEW.md" "CHANGELOG.md" "pkgmeta.yaml" "SharedMedia.lua" /NFL /NDL /NJH /NJS /NC /NS

if %ERRORLEVEL% LEQ 7 (
    echo.
    echo   Fertig! MagguuUI wurde aktualisiert.
    echo   Starte WoW oder /reload im Spiel.
) else (
    echo.
    echo   FEHLER beim Kopieren! Errorlevel: %ERRORLEVEL%
)

echo.
pause
