#!/bin/bash

#Comprobamos si los paquetes están instalados.
i=1
x=1
if ! command -v apache2 &> /dev/null; then
	a2=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Apache2 - Servidor web'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if ! command -v nginx &> /dev/null; then
	nx=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Nginx - Servidor web'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if ! command -v php &> /dev/null; then
	ph=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Php - Interprete'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if ! command -v python3 &> /dev/null; then
	py=$x
	array[$i]="$x"
	i=$[$i+1]
	array[$i]='Python - Interprete'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if ! command -v mariadb-server &> /dev/null; then
	bd=$x
	array[$i]=$x
	i=$[$i+1]
	array[$i]='MariaDB - Base de datos'
	i=$[$i+1]
	array[$i]='off'
	i=$[$i+1]
	x=$[$x+1]
fi
if ! command -v phpmyadmin &> /dev/null; then
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
        dialog --title "Informacion" --msgbox "No hay paquetes para instalar." 0 0
        exit
fi
touch log.instalacion
valor=$(dialog --nocancel --backtitle "Instalar paquetes" --title "Instalacion" --checklist "Escoge los paquetes que desees" 0 0 0 "${array[@]}" 2>&1 >$terminal)
dialog --stdout --title "Confirmacion" --yesno "¿Seguro que desea instalar los siguientes paquetes?" 0 0
	if [ $? -eq 0 ]; then
		echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere..." 10 80 0
		for valor in $valor; do
		prog=$[$prog+20]
			case $valor in
				$a2)
					if command -v nginx &> /dev/null; then
						service nginx stop
					fi
					echo '                            _          ___  ' &>> log.instalacion
					echo '     /\                    | |        |__ \ ' &>> log.instalacion
					echo '    /  \   _ __   __ _  ___| |__   ___   ) |' &>> log.instalacion
					echo '   / /\ \ | ´_ \ / _` |/ __|  _ \ / _ \ / / ' &>> log.instalacion
					echo '  / ____ \| |_) | (_| | (__| | | |  __// /_ ' &>> log.instalacion
					echo ' /_/    \_\ .__/ \__,_|\___|_| |_|\___|____|' &>> log.instalacion
					echo '          | |                               ' &>> log.instalacion
					echo '          |_|' &>> log.instalacion
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Apache2" 10 80 0
					zypper install --no-confirm apache2 &>> log.instalacion || ins=0
					systemctl enable apache2 &>> log.instalacion
					firewall-cmd --permanent --add-service=http --add-service=https &>> log.instalacion
					firewall-cmd --reload &>> log.instalacion
					chown --recursive wwwrun:wwwrun /srv/www/ &>> log.instalacion
				;;
				$nx)
					if command -v apache2 &> /dev/null; then
						service apache2 stop
					fi
					echo '   _   _       _            ' &>> log.instalacion
					echo '  | \ | |     (_)           ' &>> log.instalacion
					echo '  |  \| | __ _ _ _ __ __  __' &>> log.instalacion
					echo '  | . ` |/ _` | | ´_ \\ \/ /' &>> log.instalacion
					echo '  | |\  | (_| | | | | |>  < ' &>> log.instalacion
					echo '  |_| \_|\__, |_|_| |_/_/\_\' &>> log.instalacion
					echo '         __/ |             ' &>> log.instalacion
					echo '        |___/  ' &>> log.instalacion
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Nginx" 10 80 0
					zypper install --no-confirm nginx &>> log.instalacion || ins=0
					systemctl enable nginx &>> log.instalacion
					firewall-cmd --permanent --add-service=http --add-service=https &>> log.instalacion
					firewall-cmd --reload &>> log.instalacion
					chown --recursive wwwrun:wwwrun /srv/www/ &>> log.instalacion
				;;
				$ph)
					echo '  _____  _           ' &>> log.instalacion
					echo ' |  __ \| |          ' &>> log.instalacion
					echo ' | |__) | |__  _ __  ' &>> log.instalacion
					echo ' |  ___/|  _ \| ´_ \ ' &>> log.instalacion
					echo ' | |    | | | | |_) |' &>> log.instalacion
					echo ' |_|    |_| |_| .__/ ' &>> log.instalacion
					echo '              | |    ' &>> log.instalacion
					echo '              |_|    ' &>> log.instalacion
					zypper install --no-confirm php7-fpm php7 &>> log.instalacion || ins=0
					systemctl enable php-fpm.service &>> log.instalacion
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Php" 10 80 0
			        ;;
				$py)
					echo '  _____       _   _                 ____  ' &>> log.instalacion
					echo ' |  __ \     | | | |               |___ \ ' &>> log.instalacion
					echo ' | |__) |   _| |_| |__   ___  _ __   __) |' &>> log.instalacion
					echo ' |  ___/ | | | __|  _ \ / _ \| ´_ \ |__ < ' &>> log.instalacion
					echo ' | |   | |_| | |_| | | | (_) | | | |___) |' &>> log.instalacion
					echo ' |_|    \__, |\__|_| |_|\___/|_| |_|____/ ' &>> log.instalacion
					echo '         __/ |                            ' &>> log.instalacion
					echo '        |___/                     ' &>> log.instalacion
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Python3" 10 80 0
					zypper install --no-confirm python-pip python3-virtualenv &>> log.instalacion || ins=0
			        ;;
				$bd)
					echo '  __  __            _       _____  ____  ' &>> log.instalacion
					echo ' |  \/  |          (_)     |  __ \|  _ \ ' &>> log.instalacion
					echo ' | \  / | __ _ _ __ _  __ _| |  | | |_) |' &>> log.instalacion
					echo ' | |\/| |/ _` | ´__| |/ _` | |  | |  _ < ' &>> log.instalacion
					echo ' | |  | | (_| | |  | | (_| | |__| | |_) |' &>> log.instalacion
					echo ' |_|  |_|\__,_|_|  |_|\__,_|_____/|____/ ' &>> log.instalacion
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando MariaDB" 10 80 0
					zypper install --no-confirm mariadb mariadb-client mariadb-tools &>> log.instalacion || ins=0
					systemctl enable mysql &>> log.instalacion
			        ;;
				$pp)
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Apache2" 10 80 0
					zypper install --no-confirm phpmyadmin &>> log.instalacion || ins=0
        			;;
			esac
		done
		echo "100" | dialog --title "Instalacion en progreso." --gauge "Instalacion completada." 10 80 0
		sleep 2
		if [[ $ins -eq 1 ]]; then
			dialog --title "Informacion" --yesno "Paquetes instalados correctamente. ¿Quieres ver el log?" 0 0
			if [ $? -eq 0 ]; then
				dialog --title "Log de instalacion" --textbox log.instalacion 0 0
			fi
		elif [[ $ins -eq 0 ]];then
			dialog --title "ERROR" --yesno "Ha ocurrido un error al instalar los paquetes. ¿Quieres ver el log?" 0 0
			if [ $? -eq 0 ]; then
				dialog --title "Log de instalacion" --textbox log.instalacion 0 0
			fi
		fi
	else
		dialog --title "Informacion" --msgbox "Instalacion cancelada." 0 0
	fi

rm -r log.instalacion
