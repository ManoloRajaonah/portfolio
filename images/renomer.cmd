@echo off
setlocal enabledelayedexpansion

:: Configuration
set "prefix=7cbfec2e"
set "extension=.png"
set /a count=1

echo --- Debut du renommage automatique ---

:: Boucle sur tous les fichiers .png du dossier (triés par nom)
for /f "delims=" %%f in ('dir /b /a-d /on "*%extension%"') do (
    
    :: Préparation du numéro (ajoute un 0 devant)
    set "number=0!count!"
    
    :: On ne garde que les 2 derniers chiffres (ex: 01, 09, 10, 31...)
    set "number=!number:~-2!"
    
    :: Construction du nouveau nom
    set "newname=%prefix%-!number!%extension%"
    
    :: Renommage effectif (en ignorant le script lui-même)
    if /i "%%f" neq "%~nx0" (
        if /i "%%f" neq "!newname!" (
            echo Renommage : "%%f" -^> "!newname!"
            ren "%%f" "!newname!"
            set /a count+=1
        )
    )
)

echo.
echo Operation terminee. !count! fichiers ont ete indexes de 01 a !number!.
pause