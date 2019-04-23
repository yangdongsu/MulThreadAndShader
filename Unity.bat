@echo off

set UNITY_PATH="C:\Program Files\Unity\Hub\Editor\2018.3.9f1\Editor\Unity.exe"
set UNITY_PROJECT_PATH="E:\GitItem\MulThreadAndShader\TransparentShader"
set UNITY_LOG_PATH= unity_log.txt

echo ∆Ù∂Ø Unity.exe «Î…‘∫Û...

%UNITY_PATH% -quit -batchmode -logFile %UNITY_LOG_PATH%  -executeMethod APKBuild.Build

pause