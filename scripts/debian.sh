#!/bin/bash
clear
#Script de instalación de debian.


salir=0
while [ $salir -eq 0 ]; do

	echo "┌---------------------------------------┐"
	echo "|Sistema: Debian                        |"
	echo "├---------------------------------------┤"
	echo "|1-Instalar paquetes                    |"
	echo "|2-Desinstalar paquetes                 |"
	echo "|3-Actualizar paquetes                  |"
	echo "|4-Configuracion Virtualhosts           |"
	echo "|5-Instalacion de certificados          |"
	echo "|6-Importar/Exportar BBDD               |"
	echo "|7-Copias de seguridad                  |"
	echo "├---------------------------------------┤"
	echo "|8-Salir                                |"
	echo "└---------------------------------------┘"
	read -p "Opción: " valor
	case $valor in
		1)
		./scripts/debian/instdebian.sh
		;;
		2)

		;;
		3)

		;;
		4)

		;;
		5)

		;;
		6)

		;;
		7)

		;;
		8)
		kill
		;;
	esac
	clear
done




#echo '<html><body><h1>Funciona.</h1></body></html>' >> index.html
