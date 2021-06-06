#!/bin/bash
valor=$(dialog --backtitle "Copias de seguridad" --title "Copias de seguridad" --stdout --menu "Elija una opción" 0 0 0 1 "Ver copiados configurados" 2 "Configurar nuevo copiado" 3 "Eliminar configuracion de copiado")
case $valor in
    1)
	crontab -l | grep "#tfg"> lista.cron
	sed -i -E 's/.* (.*) (.*) (.*) .*"\/.* (\/.*) (\/.*)" .*/MES: \1 DIA MES: \2 DIA SEMANA: \3 DIRECTORIO: \4 DESTINO: \5/g' lista.cron
	sed -i -E 's/\*/-/g' lista.cron
	dialog --title "Lista de cron" --textbox lista.cron 0 0
    rm -r lista.cron
	;;
    2)
	directorio1=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio que desea copiar" --stdout --dselect $HOME/  14 70)
	if [ $? -eq 0 ]; then
		directorio2=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio donde guardar la copia" --stdout --dselect $HOME/  14 70)
		if [ $? -eq 0 ]; then
			frecuencia=$(dialog --nocancel --backtitle "Copias de seguridad" --title "Frecuencia de la copia de seguridad" --stdout --menu "Elija una opción" 0 0 0 1 "Diariamente" 2 "Mensualmente" 3 "Anualmente")
			case $frecuencia in
       		    1)
				ndia=$(dialog --nocancel --backtitle "Copias de seguridad" --title "Diario" --stdout --menu "Elija una opción" 0 0 0 1 "Lunes" 2 "Martes" 3 "Miercoles" 4 "Jueves" 5 "Viernes" 6 "Sábado" 7 "Domingo")
				case $ndia in
        		    1)
					dia="lunes"
					;;
        	        2)
					dia="martes"
					;;
        		    3)
					dia="miercoles"
					;;
        	        4)
					dia="jueves"
					;;
        		    5)
					dia="viernes"
					;;
        	        6)
					dia="sábado"
					;;
        		    7)
					dia="domingo"
					;;
				esac
				crontab -l | { cat; echo '* * * * '$ndia' "/cp -r '$directorio1' '$directorio2'" #tfg'; } | crontab -
				dialog --title "Informacion" --msgbox "Se ha configurado la copia del directorio $directorio1 en $directorio2 cada $dia." 0 0
				;;
       			2)
				valido=0
				while [[ $valido -eq 0 ]]; do
					mesd=$(dialog --stdout --title "Mensual" --inputbox "Escribe un dia del mes:" 0 0)
					if [ $? -eq 1 ]; then break; fi
					if [[ $mesd =~ ^[0-9]+$ ]]; then
						if [[ $mesd -le 28 && $mesd -ge 1 ]]; then
							valido=1
							crontab -l | { cat; echo '* * '$mesd' * * "/cp -r '$directorio1' '$directorio2'" #tfg'; } | crontab -
							dialog --title "Informacion" --msgbox "Se ha configurado la copia del directorio $directorio1 en $directorio2 el dia $mesd de cada mes." 0 0
						else
						dialog --title "Informacion" --msgbox "El dia debe ser entre el 1 y el 28" 0 0
						fi
					else
						dialog --title "Informacion" --msgbox "Debe escribir un número" 0 0
					fi
				done
	            ;;
       			3)
				fecha=$(dialog --stdout --title "Anual" --calendar "Elige una fecha" 0 0)
				Ydia=$(echo $fecha | cut -d"/" -f1)
				Ymes=$(echo $fecha | cut -d"/" -f2)
				crontab -l | { cat; echo '* * '$Ydia' '$Ymes' * "/cp -r '$directorio1' '$directorio2'" #tfg'; } | crontab -
				dialog --title "Informacion" --msgbox "Se ha configurado la copia del directorio $directorio1 en $directorio2 cada dia $Ydia del mes $Ymes de cada año." 0 0
               	;;
			esac
           fi
	fi
	;;
       3)
	crontab -l | grep "#tfg" > lista.cron
	sed -i -E 's/.* (.*) (.*) (.*) .*"\/.* (\/.*) (\/.*)" .*/MES: \1 DIA MES: \2 DIA SEMANA: \3 DIRECTORIO: \4 DESTINO: \5/g' lista.cron
	sed -i -E 's/\*/-/g' lista.cron
	i=1
	j=1
	while read line; do
		array[ $i ]=$j
		(( j++ ))
		array[ ($i + 1) ]=$line
		(( i=($i+2) ))
	done < lista.cron
	terminal=$(echo $(tty))
	seleccion=$(dialog --backtitle "Eliminar copia automatica" --title "Eliminar copia automatica" --menu "Elige la copia de seguridad que desea borrar" 0 0 0 "${array[@]}" 2>&1 >$terminal)
	if [ $? -eq 0 ]; then
		crontab -l > lista.cron
		crontab -l | grep "#tfg" | cut -f$seleccion -d$'\n' >> lista.cron
		cat lista.cron | sort | uniq -u | crontab -
		dialog --title "Informacion" --msgbox "Se ha eliminado el crontab seleccionado." 0 0
	fi
	rm -r lista.cron
    ;;
esac
