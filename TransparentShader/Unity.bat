@echo off  

echo ��������APK�ļ�... 
 
C:\Program Files\Unity\Hub\Editor\2018.3.9f1\Editor\Unity.exe -projectPath E:\GitItem\MulThreadAndShader\TransparentShader -quit -batchmode -executeMethod APKBuild.Build -logFile build.log

%1 -projectPath %2 -quit -batchmode -executeMethod APKBuild.Build -logFile build.log


echo APK�ļ��������!  

pause 