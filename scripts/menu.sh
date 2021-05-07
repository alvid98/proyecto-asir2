#!/bin/bash

#Script de instalación de debian.


salir=0
while [ $salir -eq 0 ]; do
valor=$(dialog --nocancel --title "Sistema "$1":" --stdout --menu "Elija una opcion" 0 0 0 1 "Instalar paquetes" 2 "Desinstalar paquetes" 3 "Actualizar Paquetes" 4 "Configuracion de VirtualHosts" 5 "Instalacion de certificados" 6 "Importar/Exportar BBDD" 7 "Copias de seguridad" 8 "Salir")
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

		;;
		5)

		;;
		6)
		./scripts/$1/mysql.sh
		;;
		7)

		;;
		8)
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
