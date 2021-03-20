#!/bin/bash
clear
echo "------------------------------------------|"
echo "|Bienvenido al script de instalación LAMP |"
echo "|Con este script podremos instalar        |"
echo "|las herramientas básicas que se usarian  |"
echo "|en el Grado Superior DAW.                |"
echo "|-----------------------------------------|"
sleep 5

sistemas=(debian fedora opensuse arch)
source /etc/*release
id=$(echo $ID)
idlike=$(echo $ID_LIKE)

for x in ${sistemas[@]}
do
	detectado+=$(echo $id | grep $x)
done


if [[ $detectado == "" ]]; then
	for x in ${sistemas[@]}
	do
		detectado+=$(echo $idlike | grep $x)
	done
	if [[ $detectado == "" ]]; then
		echo "Sistema operativo no detectado, elija una opción:"
		echo "1- Debian o variante"
		echo "2- Fedora o variante"
		echo "3- Opensuse o variante"
		echo "4- Arch o variante"
		read -p "Elija una opción: " linux
	fi
else
	echo "Sistema operativo detectado."
	echo "Aplicando configuración para "$detectado"..."
	for i in "${!sistemas[@]}"
	do
		if [[ ${sistemas[$i]} = $detectado ]]; then
			linux=$[$i+1]
		fi
	done
	sleep 3
fi

case $linux in
	1)
	./scripts/debian.sh
	;;
	2)
	./scripts/fedora.sh
	;;
	3)
	./scripts/opensuse.sh
	;;
	4)
	./scripts/arch.sh
	;;
esac
