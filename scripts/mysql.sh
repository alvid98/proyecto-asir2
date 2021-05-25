#!/bin/bash

salir=0
while [ $salir -eq 0 ]; do
	valor=$(dialog --nocancel --backtitle "Exportar/Importar BBDD" --title "Exportar/Importar BBDD" --stdout --menu "Elija una opcion :" 0 0 0 1 "Importar BBDD" 2 "Exportar BBDD" 3 "Atras")
	case $valor in
		1)
			SQL=$(dialog --stdout --title "Selecciona el archivo SQL que desea Importar" --fselect $HOME/ 20 100)
			if [ $? -eq 0 ]; then
				if [[ $SQL =~ .*.sql ]]; then
					dialog --title "Confirmación" --yesno "¿Seguro que desea importar $SQL?" 0 0
					if [ $? -eq 0 ]; then
						database=$(echo $SQL | sed -E 's/.*\/(.*).sql/\1/g')
						mysql -u root $database < $SQL
					fi
				else
					dialog --title "ERROR" --msgbox "NO es un fichero SQL por lo que no se va a importar.." 0 0
				fi
			fi
		;;
		2)
		salir2=0
		while [ $salir2 -eq 0 ]; do
        		mysql -u root -e 'show databases;' | sed '1d'  > lista.mysql
                	terminal=$(echo $(tty))
        	        i=1
	                j=1
                	while read line; do
                        	array[ $i ]=$j
                        	(( j++ ))
                       		array[ ($i + 1) ]=$line
                        	(( i=($i+2) ))
                	done < lista.mysql
                	BBDD=$(dialog --backtitle "Exportar BBDD" --title "Exportar BBDD" --menu "Elige la BBDD que desea exportar:" 0 0 0 "${array[@]}" 2>&1 >$terminal)
			if [ $? -eq 0 ]; then
				DIRECTORIO=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio donde desee guardar la BBDD" --stdout --dselect $HOME/  14 70)
				NOMBRE=$(cat lista.mysql | cut -f$BBDD -d$'\n')
				mysqldump -u root $NOMBRE > "$DIRECTORIO""$NOMBRE.sql"
				if [ $? -eq 0 ]; then
					salir2=1
					dialog --title "Informacion" --msgbox "Se ha exportado la base de datos $NOMBRE en el directorio $DIRECTORIO." 0 0
				else
					salir2=1
					dialog --title "ERROR" --msgbox "No ha sido posible exportar la Base de Datos, intentelo de nuevo." 0 0
				fi
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

