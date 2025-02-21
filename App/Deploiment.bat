@echo off

rem Récuperation des arguments
set nameProject=%~1


rem Chemin vers repertoire de temp
set temp=temp
set tempsrc=tempsrc

rem Vérifie si le dossier existe deja
if exist "%temp%" (
    rd /S /Q "%temp%"
    echo Le dossier %temp% et son contenu ont ete supprimes avec succes.
)

if exist "%tempsrc%" (
    rd /S /Q "%tempsrc%"
    echo Le dossier %tempsrc% et son contenu ont ete supprimes avec succes.
)

mkdir "%temp%"
echo Le nouveau dossier %temp% a ete cree avec succes.

mkdir "%tempsrc%"
echo Le nouveau dossier %tempsrc% a ete cree avec succes.

rem Les dossiers necessaire
set librairie=lib
set xml=web.xml
set src=src
set view=view
set assets=assets

rem Le destination de chaque dossier
set deslibrairie=%temp%/WEB-INF/lib/
set desxml=%temp%/WEB-INF/
set desview=%temp%/view/
set desassets=%temp%/WEB-INF/assets/

rem Copie le dossier librairie dans le dossier de destination
xcopy "%librairie%" "%deslibrairie%" /E /I /Y
echo Le copie du dossier %librairie% a ete effectuez avec succes dans %deslibrairie%.

rem Copie le dossier view dans le dossier de destination
xcopy "%view%" "%desview%" /E /I /Y
echo Le copie du dossier %view% a ete effectuez avec succes dans %desview%.

rem Copie le dossier assets dans le dossier de destination
xcopy "%assets%" "%desassets%" /E /I /Y
echo Le copie du dossier %assets% a ete effectuez avec succes dans %desassets%.

rem Copie les fichier .xml vers le dossier de destination
copy "%xml%" "%desxml%"

echo Le fichier %xml% a ete copie dans %desxml%.

rem Copie les sources dans le tempsrc
for /r "src" %%f in (*.java) do copy "%%f" "%tempsrc%"

rem Compilation de tous les fichiers Java du répertoire tempsrc
javac -parameters -cp "%temp%/WEB-INF/lib/*" -d "%temp%/WEB-INF/classes/" "%tempsrc%\*.java"

echo Compilation des fichiers Java dans %tempsrc% terminee. Les fichiers .class sont stockes dans %temp%/WEB-INF/classes/.


set projet=%nameProject%.war

rem Crée le fichier WAR à partir du dossier source
jar -cvf "%projet%" -C "%temp%" .

echo Le fichier WAR a ete cree : %projet%

rem Déplace le fichier WAR vers le nouveau dossier
move "%projet%" "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\"

echo Deploiment effectuer avec succes

pause