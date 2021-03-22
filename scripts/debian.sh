#!/bin/bash

#Script de instalación de debian.


salir=0
while [ $salir -eq 0 ]; do
	clear
	echo "╔═══════════════════════════════════════╗"
	echo "║Sistema: Debian                        ║"
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
		./scripts/debian/instdebian.sh
		;;
		2)
		./scripts/debian/desdebian.sh
		;;
		3)

		;;
		4)

		;;
		5)

		;;
		6)
		./scripts/debian/mysqldebian.sh
		;;
		7)

		;;
		8)
		salir=1
		;;
	esac
	clear
done




#echo '<html><body><h1>Funciona.</h1></body></html>' >> index.html