#!/bin/bash
dialog --stdout --title "Confirmación" --yesno "¿Desea configurar copias de seguridad?" 0 0
if [ $? -eq 0 ]; then
	respuesta=$(dialog --backtitle "Para seleccionar un directorio, pulsa 1 vez, para entrar en el, pulsa espacio 2 veces" \
	--title "Selecciona un directorio" --stdout --dselect $HOME/  14 70)
	echo "Directorio seleccionado: ${respuesta}"
fi
echo "fin de programa"
sleep 5
