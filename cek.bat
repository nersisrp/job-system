@echo off
rem .bat dosyasının olduğu klasöre geç
cd /d %~dp0

rem En son değişiklikleri çek
git pull origin main