#!/bin/bash
echo "SCRIPT AUTO INSTALL WINDOWS by HIDESSH"
echo
echo "Pilih OS yang ingin anda install"
echo "[1] Windows 2019(Default)"
echo "[2] Windows 2016"
echo "[3] Windows 2012"
echo "[4) Windows 10"
echo "[5] Chat Ryan Untuk Add OS lain"

read -p "Pilih [1]: " PILIH OS

case "$PILIHOS" in
	1|"") PILIHOS="http://165.232.167.154/win7.gz";;
	2) PILIHOS="http://165.232.167.154/win7.gz";;
	3) PILIHOS="http://165.232.167.154/win7.gz";;
	4) PILIHOS="http://165.232.167.154/win7.gz";;
	5) read -p "[?] Masukkan Link GZ mu : " PILIHOS;;
	*) echo "[!] Pilihan salah"; exit;;
esac

echo "[*] Password yang saya buat sudah masuk wordlist bruteforce, silahkan masukkan password yang lebih aman!"
read -p "[?] Masukkan password untuk akun Administrator Rdp anda(minimal 12 karakter) : " PASSADMIN

IP4=$(curl -4 -s icanhazip.com)
GW=$(ip route | awk '/default/ { print $3 }')


cat >/tmp/net.bat<<EOF
@ECHO OFF
cd.>%windir%\GetAdmin
if exist %windir%\GetAdmin (del /f /q "%windir%\GetAdmin") else (
echo CreateObject^("Shell.Application"^).ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\Admin.vbs"
"%temp%\Admin.vbs"
del /f /q "%temp%\Admin.vbs"
exit /b 2)
net user Administrator $PASSADMIN


for /f "tokens=3*" %%i in ('netsh interface show interface ^|findstr /I /R "Local.* Ethernet Ins*"') do (set InterfaceName=%%j)
netsh -c interface ip set address name="Ethernet Instance 0" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="Ethernet Instance 0" address=8.8.8.8 index=1 validate=no
netsh -c interface ip add dnsservers name="Ethernet Instance 0" address=8.8.4.4 index=2 validate=no

cd /d "%ProgramData%/Microsoft/Windows/Start Menu/Programs/Startup"
del /f /q net.bat
exit
EOF

wget --no-check-certificate -O- $PILIHOS | gunzip | dd of=/dev/vda bs=3M status=progress

mount.ntfs-3g /dev/vda2 /mnt
cd "/mnt/ProgramData/Microsoft/Windows/Start Menu/Programs/"
cd Start* || cd start*; \
wget https://nixpoin.com/ChromeSetup.exe
cp -f /tmp/net.bat net.bat
cp -f /tmp/dpart.bat dpart.bat

echo "reboot Rdp dulu mazzeh baru bisa pake"
