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

wget --no-check-certificate -O- $PILIHOS | gunzip | dd of=/dev/vda bs=3M status=progress

echo "reboot Rdp dulu mazzeh baru bisa pake"