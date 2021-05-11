#!/bin/bash
dialog --stdout --title "Confirmación" --yesno "¿Desea comprobar actualizaciónes?" 0 0
if [ $? -eq 0 ]; then
	nact=$(apt update 2>/dev/null | tail -1 | cut -d" " -f 4)
	dialog --stdout --title "Confirmación" --yesno "Hay $nact paquetes disponibles para actualizar, ¿desea actualizar ahora?" 0 0
	if [ $? -eq 0 ]; then
		apt update &>/dev/null
		apt-get upgrade -y &> log.upgrade
		if [ $? -eq 0 ];then
			dialog --stdout --title "Confirmación" --yesno "Paquetes actualizados correctamente, ¿Desea ver el log?" 0 0
			if [ $? -eq 0 ];then
			dialog --title "Log de actualización" --textbox log.upgrade 0 0
			fi
		else
			dialog --stdout --title "Confirmación" --yesno "Ha habido un error al actualizar, ¿Desea ver el log?" 0 0
			if [ $? -eq 0 ];then
			dialog --title "Log de actualización" --textbox log.upgrade 0 0
			fi
		fi
	fi
fi
rm -r log.upgrade
