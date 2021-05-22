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
        		mysql -u root -e 'show databases;' | sed '1d' > lista.mysql
        	        i=1
	                j=1
                	while read line; do
                        	array[ $i ]=$j
                        	(( j++ ))
                       		array[ ($i + 1) ]=$line
                        	(( i=($i+2) ))
                	done < lista.mysql

                	terminal=$(echo $(tty))
                	BBDD=$(dialog --stdout --backtitle "Exportar BBDD" --title "Exportar BBDD" --menu "Elige la BBDD que desea exportar:" 0 0 0 "${array[@]}" 2>&1 >$terminal)

			if [ $? -eq 0 ]; then
				echo $BBDD
				DIRECTORIO=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio donde desee guardar la BBDD" --stdout --dselect $HOME/  14 70)
				NOMBRE=$( cat lista.mysql | cut -d$'\n' -f"$BBDD" )
				mysqldump -u root -p $NOMBRE > $DIRECTORIO$NOMBRE.sql
				dialog --title "Informacion" --msgbox "Se ha exportado la base de datos $NOMBRE en el directorio $DIRECTORIO." 0 0
			else
				salir2=1
			fi
		done
		;;
		3)
		salir=1
		;;
	esac
done
