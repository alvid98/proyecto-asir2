#!/bin/bash

#Comprobamos si los paquetes están instalados.
touch log.desinstalacion
i=1
x=1
if command -v apache2 &> /dev/null; then
	a2=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Apache2 - Servidor web'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if command -v nginx &> /dev/null; then
	nx=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Nginx - Servidor web'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if command -v php &> /dev/null; then
	ph=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Php - Interprete'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if command -v python3 &> /dev/null; then
	py=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Python - Interprete'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if command -v mariadb &> /dev/null; then
	bd=$x
	array[$i]=$x
	i=$[$i+1]
	array[$i]='MariaDB - Base de datos'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if command -v phpmyadmin &> /dev/null; then
	pp=$x
	array[$i]=$x
	i=$[$i+1]
	array[$i]='PhpMyAdmin - Administrador WEB MariaDB'
	i=$[$i+1]
	array[$i]='off'
fi
terminal=$(echo $(tty))
salir=0
prog=0
ins=1
if [ -z "${array[@]}" ]; then
	dialog --title "Informacion" --msgbox "No hay paquetes para eliminar." 0 0
	exit
fi
valor=$(dialog --nocancel --backtitle "Desinstalar paquetes" --title "Desinstalacion" --checklist "Escoge los paquetes que desee eliminar:" 0 0 0 "${array[@]}" 2>&1 >$terminal)
dialog --stdout --title "Confirmacion" --yesno "¿Seguro que desea eliminar los siguientes paquetes?" 0 0
	if [ $? -eq 0 ]; then
		echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere..." 10 80 0
		for valor in $valor; do
		prog=$[$prog+20]
			case $valor in
				$a2)
					if command -v nginx &> /dev/null; then
						service nginx stop
					fi
					echo '                            _          ___  ' &>> log.desinstalacion
					echo '     /\                    | |        |__ \ ' &>> log.desinstalacion
					echo '    /  \   _ __   __ _  ___| |__   ___   ) |' &>> log.desinstalacion
					echo '   / /\ \ | ´_ \ / _` |/ __|  _ \ / _ \ / / ' &>> log.desinstalacion
					echo '  / ____ \| |_) | (_| | (__| | | |  __// /_ ' &>> log.desinstalacion
					echo ' /_/    \_\ .__/ \__,_|\___|_| |_|\___|____|' &>> log.desinstalacion
					echo '          | |                               ' &>> log.desinstalacion
					echo '          |_|' &>> log.desinstalacion
					echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere...\n Eliminando Apache2" 10 80 0
					Y | pacman -Rsc apache &>> log.desinstalacion || ins=0
				;;
				$nx)
					if command -v httpd &> /dev/null; then
						service httpd stop
					fi
					echo '   _   _       _            ' &>> log.desinstalacion
					echo '  | \ | |     (_)           ' &>> log.desinstalacion
					echo '  |  \| | __ _ _ _ __ __  __' &>> log.desinstalacion
					echo '  | . ` |/ _` | | ´_ \\ \/ /' &>> log.desinstalacion
					echo '  | |\  | (_| | | | | |>  < ' &>> log.desinstalacion
					echo '  |_| \_|\__, |_|_| |_/_/\_\' &>> log.desinstalacion
					echo '         __/ |             ' &>> log.desinstalacion
					echo '        |___/  ' &>> log.desinstalacion
					echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere...\n Eliminando Nginx" 10 80 0
					Y | pacman -Rsc nginx &>> log.desinstalacion || ins=0
				;;
				$ph)
					echo '  _____  _           ' &>> log.desinstalacion
					echo ' |  __ \| |          ' &>> log.desinstalacion
					echo ' | |__) | |__  _ __  ' &>> log.desinstalacion
					echo ' |  ___/|  _ \| ´_ \ ' &>> log.desinstalacion
					echo ' | |    | | | | |_) |' &>> log.desinstalacion
					echo ' |_|    |_| |_| .__/ ' &>> log.desinstalacion
					echo '              | |    ' &>> log.desinstalacion
					echo '              |_|    ' &>> log.desinstalacion
					echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere...\n Eliminando Php" 10 80 0
					Y | pacman -Rsc php php-apache php-fpm &>> log.desinstalacion || ins=0
			        ;;
				$py)
					echo '  _____       _   _                 ____  ' &>> log.desinstalacion
					echo ' |  __ \     | | | |               |___ \ ' &>> log.desinstalacion
					echo ' | |__) |   _| |_| |__   ___  _ __   __) |' &>> log.desinstalacion
					echo ' |  ___/ | | | __|  _ \ / _ \| ´_ \ |__ < ' &>> log.desinstalacion
					echo ' | |   | |_| | |_| | | | (_) | | | |___) |' &>> log.desinstalacion
					echo ' |_|    \__, |\__|_| |_|\___/|_| |_|____/ ' &>> log.desinstalacion
					echo '         __/ |                            ' &>> log.desinstalacion
					echo '        |___/                     ' &>> log.desinstalacion
					echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere...\n Eliminando Python3" 10 80 0
					Y | pacman -Rsc python &>> log.desinstalacion || ins=0
			        ;;
				$bd)
					echo '  __  __            _       _____  ____  ' &>> log.desinstalacion
					echo ' |  \/  |          (_)     |  __ \|  _ \ ' &>> log.desinstalacion
					echo ' | \  / | __ _ _ __ _  __ _| |  | | |_) |' &>> log.desinstalacion
					echo ' | |\/| |/ _` | ´__| |/ _` | |  | |  _ < ' &>> log.desinstalacion
					echo ' | |  | | (_| | |  | | (_| | |__| | |_) |' &>> log.desinstalacion
					echo ' |_|  |_|\__,_|_|  |_|\__,_|_____/|____/ ' &>> log.desinstalacion
					echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere...\n Eliminando MariaDB" 10 80 0
					Y | pacman -Rsc mysql &>> log.desinstalacion || ins=0
			        ;;
				$pp)
					echo $prog | dialog --title "Desinstalacion en progreso." --gauge "Por favor, espere...\n Eliminando PhpMyAdmin" 10 80 0
					Y | pacman -Rsc phpmyadmin php-mcrypt &>> log.desinstalacion || ins=0
        			;;
			esac
		done
		echo "100" | dialog --title "Desinstalacion en progreso." --gauge "Desinstalacion completada." 10 80 0
		sleep 2
		if [[ $ins -eq 1 ]]; then
			dialog --title "Informacion" --yesno "Paquetes eliminados correctamente. ¿Quieres ver el log?" 0 0
			if [ $? -eq 0 ]; then
				dialog --title "Log de desinstalacion" --textbox log.desinstalacion 0 0
			fi
		elif [[ $ins -eq 0 ]];then
			dialog --title "ERROR" --yesno "Ha ocurrido un error al eliminar los paquetes. ¿Quieres ver el log?" 0 0
			if [ $? -eq 0 ]; then
				dialog --title "Log de desinstalacion" --textbox log.desinstalacion 0 0
			fi
		fi
	else
		dialog --title "Informacion" --msgbox "Desinstalacion cancelada." 0 0
	fi

rm -r log.desinstalacion
