#!/bin/bash
clear

sistemas=(debian fedora opensuse arch)
source /etc/*release
id=$(echo $ID)
idlike=$(echo $ID_LIKE)
if [ "$EUID" -ne 0 ];then
	echo "╔═══════════════════════════════════════╗"
	echo "║Por favor, inicia el script como root. ║"
	echo "╚═══════════════════════════════════════╝"
	exit
else
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
			echo "╔═══════════════════════════════════════╗"
			echo "║Sistema operativo no detectado         ║"
			echo "║Elija una opción:                      ║"
			echo "╚═══════════════════════════════════════╝"
			echo "┌---------------------------------------┐"
			echo "|1- Debian o variante                   |"
			echo "|2- Fedora o variante                   |"
			echo "|3- Opensuse o variante                 |"
			echo "|4- Arch o variante                     |"
			echo "└---------------------------------------┘"
			read -p "Opción: " linux
		fi
	else
	#Iniciamos el menú enviandole el sistema que se está usando
	./scripts/menu.sh $detectado
	fi

fi
