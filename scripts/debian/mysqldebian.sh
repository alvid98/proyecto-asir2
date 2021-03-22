#!/bin/bash


salir=0
while [ $salir -eq 0 ]; do
    clear
	echo "╔═══════════════════════════════════════╗"
	echo "║Importar/Exportar BBDD                 ║"
	echo "╚═══════════════════════════════════════╝"
	echo "┌---------------------------------------┐"
	echo "|1-Importar BBDD                        |"
	echo "├---------------------------------------┤"
    echo "|2-Exportar BBDD                        |"
	echo "└---------------------------------------┘"
	echo "╔═══════════════════════════════════════╗"
	echo "║3-Salir                                ║"
	echo "╚═══════════════════════════════════════╝"
	read -p "Opción: " valor
	case $valor in
		1)
        clear
        echo "╔═══════════════════════════════════════╗"
	    echo "║Importar/Exportar BBDD                 ║"
	    echo "╚═══════════════════════════════════════╝"
        mysql -u root -e 'show databases;'
		;;
		2)
        
		;;
		3)
		salir=1
		;;
	esac
	clear
done