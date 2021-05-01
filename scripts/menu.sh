#!/bin/bash

#Script de instalación de debian.


salir=0
while [ $salir -eq 0 ]; do
	clear
	echo "╔═══════════════════════════════════════╗"
	echo "║Sistema: $1			║"
	echo "╚═══════════════════════════════════════╝"
	echo "┌---------------------------------------┐"
	echo "|1-Instalar paquetes                    |"
	echo "|2-Desinstalar paquetes                 |"
	echo "|3-Actualizar paquetes                  |"
	echo "├---------------------------------------┤"
	echo "|4-Configuracion Virtualhosts           |"
	echo "|5-Instalacion de certificados          |"
	echo "├---------------------------------------┤"
	echo "|6-Importar/Exportar BBDD               |"
	echo "├---------------------------------------┤"
	echo "|7-Copias de seguridad                  |"
	echo "└---------------------------------------┘"
	echo "╔═══════════════════════════════════════╗"
	echo "║8-Salir                                ║"
	echo "╚═══════════════════════════════════════╝"
	read -p "Opción: " valor
	case $valor in
		1)
		./scripts/$1/instalar.sh
		;;
		2)
		./scripts/$1/desinstalar.sh
		;;
		3)
		./scripts/$1/actualizar.sh
		;;
		4)

		;;
		5)

		;;
		6)
		./scripts/$1/mysql.sh
		;;
		7)

		;;
		8)
		salir=1
		;;
	esac
	clear
done
