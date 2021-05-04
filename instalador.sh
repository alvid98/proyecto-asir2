#!/bin/bash
clear

sistemas=(debian fedora opensuse arch)
source /etc/*release
id=$(cat /etc/*release | grep "^ID=" | cut -d"=" -f 2)
idlike=$(cat /etc/*release | grep "^ID_LIKE" | cut -d"=" -f 2)
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
			echo "║Distribucion no detectada              ║"
			echo "║Elija una opción:                      ║"
			echo "╚═══════════════════════════════════════╝"
			echo "┌---------------------------------------┐"
			echo "|1- Debian o variante                   |"
			echo "|2- Fedora o variante                   |"
			echo "|3- Opensuse o variante                 |"
			echo "|4- Arch o variante                     |"
			echo "└---------------------------------------┘"
			read -p "Opción: " linux
			case $linux in
				1)
				detectado=$(echo debian)
				;;
				2)
				detectado=$(echo fedora)
				;;
				3)
				detectado=$(echo opensuse)
				;;
				4)
				detectado=$(echo arch)
				;;
			esac 
		fi
	fi
#Iniciamos el menú enviandole el sistema que se está usando
./scripts/menu.sh $detectado
fi
