#!/bin/bash

salir=0
while [ $salir -eq 0 ]; do
    	clear
	valor=$(dialog --nocancel --backtitle "Exportar/Importar BBDD" --title "Exportar/Importar BBDD" --stdout --menu "Elija una opcion :" 0 0 0 1 "Importar BBDD" 2 "Exportar BBDD" 3 "Atras")
	case $valor in
		1)

		;;
		2)
		salir2=0
		while [ $salir2 -eq 0 ]; do
        		clear
        		echo "╔═══════════════════════════════════════╗"
			echo "║Exportar BBDD                          ║"
			echo "║Seleccione la BBDD que desea exportar. ║"
			echo "╚═══════════════════════════════════════╝"
        		lista=$(mysql -u root -e 'show databases;' | sed '1d')
			num=1
			echo "┌---------------------------------------┐"

			for x in $lista; do
				echo "| "$num"-"$x
				num=$[$num+1]
			done

			echo "└---------------------------------------┘"
			echo "╔═══════════════════════════════════════╗"
        		echo "║$num-Salir                                ║"
        		echo "╚═══════════════════════════════════════╝"
			read -p "Opción: " BBDD

			if [ "$BBDD" -lt "$num" ] && [ "$BBDD" -gt 0 ]; then
				NOMBRE=$( echo "$lista" | cut -d$'\n' -f$BBDD )
				mysqldump -u root -p $NOMBRE > ~/$NOMBRE.sql
				read -p "Se ha exportado la base de datos en $HOME"
			elif [ "$BBDD" -eq "$num" ]; then
				salir2=1
			fi
		done
		;;
		3)
		salir=1
		;;
	esac
done
