#!/bin/bash

#Comprobamos si los paquetes están instalados.
touch log.instalacion
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
                                        yum -y install httpd &>> log.instalacion || ins=0
                                        firewall-cmd --permanent --add-port=80/tcp &>> log.instalacion
                                        firewall-cmd --permanent --add-port=443/tcp &>> log.instalacion
                                        firewall-cmd --reload &>> log.instalacion
                                        systemctl start httpd &>> log.instalacion
                                        systemctl enable httpd &>> log.instalacion
				;;
				$nx)
					if command -v apache2 &> /dev/null; then
						service httpd stop
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
                                        yum -y install nginx &>> log.instalacion || ins=0
                                        firewall-cmd --permanent --add-port=80/tcp &>> log.instalacion
                                        firewall-cmd --permanent --add-port=443/tcp &>> log.instalacion
                                        firewall-cmd --reload &>> log.instalacion
	                                systemctl start nginx &>> log.instalacion
                                        systemctl enable nginx &>> log.instalacion
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
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Php" 10 80 0
					dnf -y install https://rpms.remirepo.net/fedora/remi-release-33.rpm &>> log.instalacion
					dnf config-manager --set-enabled remi &>> log.instalacion
					dnf module reset php &>> log.instalacion
					dnf module -y install php:remi-7.4 &>> log.instalacion || ins=0
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
					dnf install -y python3-setuptools python3-devel redhat-rpm-config &>> log.instalacion || ins=0
			        ;;
				$bd)
					echo '  __  __            _       _____  ____  ' &>> log.instalacion
					echo ' |  \/  |          (_)     |  __ \|  _ \ ' &>> log.instalacion
					echo ' | \  / | __ _ _ __ _  __ _| |  | | |_) |' &>> log.instalacion
					echo ' | |\/| |/ _` | ´__| |/ _` | |  | |  _ < ' &>> log.instalacion
					echo ' | |  | | (_| | |  | | (_| | |__| | |_) |' &>> log.instalacion
					echo ' |_|  |_|\__,_|_|  |_|\__,_|_____/|____/ ' &>> log.instalacion
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando MariaDB" 10 80 0
					dnf install mariadb-server &>> log.instalacion || ins=0
					systemctl start mariadb &>> log.instalacion
					systemctl enable mariadb &>> log.instalacion
			        ;;
				$pp)
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Apache2" 10 80 0
					dnf install -y phpmyadmin &>> log.instalacion || ins=0
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
