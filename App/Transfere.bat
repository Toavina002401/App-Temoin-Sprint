@echo off

rem Votre destination pour le transfere du lib
set destination="lib"

if exist "%destination%" (
    rd /S /Q "%destination%"
    echo Le dossier %destination% et son contenu ont ete supprimes avec succes.
)

mkdir "%destination%"
echo Le nouveau dossier %destination% a ete cree avec succes.

rem Copie les lib .jar dans le lib
for /r "D:\Boss\ITU\Session4\Web Dynamic\ProjetSprint\FrameWork\lib" %%f in (*.jar) do copy "%%f" "%destination%\"

echo Copie effectuez avec succes...

pause