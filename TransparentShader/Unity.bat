@echo off

set UNITY_PATH="C:\Program Files\Unity\Hub\Editor\2018.3.9f1\Editor\Unity.exe"
set UNITY_PROJECT_PATH="E:\GitItem\MulThreadAndShader\TransparentShader"
set UNITY_LOG_PATH=%cd%\unity_log.txt

echo ���� Unity.exe ���Ժ�...

%UNITY_PATH% -quit -batchmode -logFile %UNITY_LOG_PATH% -projectPath %UNITY_PROJECT_PATH% -executeMethod APKBuild.Build

%1 -projectPath %2 -quit -batchmode  -logFile -executeMethod APKBuild.Build

pause