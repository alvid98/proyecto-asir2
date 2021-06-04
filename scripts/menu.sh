#!/bin/bash

#Script de instalación de debian.


salir=0
while [ $salir -eq 0 ]; do
valor=$(dialog --nocancel --backtitle "Proyecto asir" --title "Sistema "$1":" --stdout --menu "Elija una opcion" 0 0 0 1 "Instalar paquetes" 2 "Desinstalar paquetes" 3 "Actualizar Paquetes" 4 "Configuracion de VirtualHosts" 5  "Importar/Exportar BBDD" 6 "Copias de seguridad" 7 "Salir")
	clear

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
		./scripts/vhosts.sh
		;;
		5)
		./scripts/mysql.sh
		;;
		6)
		./scripts/copiaseg.sh
		;;
		7)
		dialog --stdout --title "Confirmación" --yesno "¿Seguro que desea salir?" 0 0
		if [[ $? -eq 0 ]]; then
		salir=1
		else
		salir=0
		fi
		;;
	esac
	clear
done
