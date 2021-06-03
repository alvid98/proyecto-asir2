#!/bin/bash
dialog --stdout --title "Confirmación" --yesno "¿Desea comprobar actualizaciónes?" 0 0
if [ $? -eq 0 ]; then
	nact=$(checkupdates | wc -l)
	dialog --stdout --title "Confirmación" --yesno "Hay $nact paquetes disponibles para actualizar, ¿desea actualizar ahora?" 0 0
	if [ $? -eq 0 ]; then
		touch log.upgrade
		Y | pacman --sync --refresh --sysupgrade &> log.upgrade
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
rm -r log.upgrade
fi
