@echo off
rem .bat dosyasının olduğu klasöre geç
cd /d %~dp0

rem Kullanıcıdan commit mesajını al
set /p msg=Yaptiginiz degisikligi aciklayip entera basiniz:

rem Değişiklikleri ekle, commit ve push yap
git add .
git commit -m "%msg%"
git push origin main