#!/bin/bash
echo "SCRIPT AUTO INSTALL WINDOWS by HIDESSH"
echo
echo "Pilih OS yang ingin anda install"
echo "[4) Windows 10"
echo "[5] Chat Ryan Untuk Add OS lain"

read -p "Pilih [1]: " PILIH OS

case "$PILIHOS" in
	3) PILIHOS="http://165.232.167.154/win7.gz";;
	4) PILIHOS="http://165.232.167.154/win7.gz";;
	5) read -p "[?] Masukkan Link GZ mu : " PILIHOS;;
	*) echo "[!] Pilihan salah"; exit;;
esac

wget --no-check-certificate -O- $PILIHOS | gunzip | dd of=/dev/sda bs=3M status=progress

mount.ntfs-3g /dev/vda2 /mnt
cd "/mnt/ProgramData/Microsoft/Windows/Start Menu/Programs/"
cd Start* || cd start*; \
wget https://nixpoin.com/ChromeSetup.exe
cp -f /tmp/net.bat net.bat
cp -f /tmp/dpart.bat dpart.bat

echo "reboot Rdp dulu mazzeh baru bisa pake"
