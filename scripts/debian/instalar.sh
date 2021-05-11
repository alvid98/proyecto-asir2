#!/bin/bash
clear
#Script de instalación de debian.

#Comprobamos si los paquetes están instalados.
apache2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
nginx=$(dpkg-query -W -f='${Status}' nginx 2>/dev/null | grep -c "ok installed")
php=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c "ok installed")
python=$(dpkg-query -W -f='${Status}' python3 2>/dev/null | grep -c "ok installed")
mysql=$(dpkg-query -W -f='${Status}' mariadb-server 2>/dev/null | grep -c "ok installed")
phpmyadmin=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c "ok installed")

salir=0
prog=0
ins=1
	clear
	valor=$(dialog --nocancel --backtitle "Instalar paquetes" --title "Instalacion" --stdout --checklist "Escoge los paquetes que desees" 0 0 0 1 "apache2 - Servidor Web" off 2 "Nginx   - Servidor Web" off 3 "Php     - Interprete" off 4 "Python  - IDE" off 5 "Mysql   - Bases de datos" off 6 "Phpmyadmin" off)
	dialog --stdout --title "Confirmacion" --yesno "¿Seguro que desea instalar los siguientes paquetes?" 0 0
	sino=$?
	if [ $sino -eq 0 ]; then
		for valor in $valor; do
		prog=$[$prog+20]
			case $valor in
				1)
					if [[ "$snnx" = "Existe" ]]; then
						service nginx stop
					fi
					echo '                            _          ___  ' > log.og
					echo '     /\                    | |        |__ \ ' >> log.og
					echo '    /  \   _ __   __ _  ___| |__   ___   ) |' >> log.og
					echo '   / /\ \ | ´_ \ / _` |/ __|  _ \ / _ \ / / ' >> log.og
					echo '  / ____ \| |_) | (_| | (__| | | |  __// /_ ' >> log.og
					echo ' /_/    \_\ .__/ \__,_|\___|_| |_|\___|____|' >> log.og
					echo '          | |                               ' >> log.og
					echo '          |_|' >> log.og
					apt-get install -y apache2 >> log.og || ins=0
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Apache2" 10 80 0
				;;
				2)
					if [[ "$sna2" = "Existe" ]]; then
						service apache2 stop
					fi
					echo '   _   _       _            ' >> log.og
					echo '  | \ | |     (_)           ' >> log.og
					echo '  |  \| | __ _ _ _ __ __  __' >> log.og
					echo '  | . ` |/ _` | | ´_ \\ \/ /' >> log.og
					echo '  | |\  | (_| | | | | |>  < ' >> log.og
					echo '  |_| \_|\__, |_|_| |_/_/\_\' >> log.og
					echo '         __/ |             ' >> log.og
					echo '        |___/  ' >> log.og
					apt-get install -y nginx >> log.og || ins=0
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Nginx" 10 80 0
				;;
				3)
					echo '  _____  _           ' >> log.og
					echo ' |  __ \| |          ' >> log.og
					echo ' | |__) | |__  _ __  ' >> log.og
					echo ' |  ___/|  _ \| ´_ \ ' >> log.og
					echo ' | |    | | | | |_) |' >> log.og
					echo ' |_|    |_| |_| .__/ ' >> log.og
					echo '              | |    ' >> log.og
					echo '              |_|    ' >> log.og
					apt-get install -y php >> log.og || ins=0
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Php" 10 80 0
			        ;;
				4)
					echo '  _____       _   _                 ____  ' >> log.og
					echo ' |  __ \     | | | |               |___ \ ' >> log.og
					echo ' | |__) |   _| |_| |__   ___  _ __   __) |' >> log.og
					echo ' |  ___/ | | | __|  _ \ / _ \| ´_ \ |__ < ' >> log.og
					echo ' | |   | |_| | |_| | | | (_) | | | |___) |' >> log.og
					echo ' |_|    \__, |\__|_| |_|\___/|_| |_|____/ ' >> log.og
					echo '         __/ |                            ' >> log.og
					echo '        |___/                     ' >> log.og
					apt-get install -y python3 >> log.og || ins=0
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Python3" 10 80 0
			        ;;
				5)
					echo '  __  __            _       _____  ____  ' >> log.og
					echo ' |  \/  |          (_)     |  __ \|  _ \ ' >> log.og
					echo ' | \  / | __ _ _ __ _  __ _| |  | | |_) |' >> log.og
					echo ' | |\/| |/ _` | ´__| |/ _` | |  | |  _ < ' >> log.og
					echo ' | |  | | (_| | |  | | (_| | |__| | |_) |' >> log.og
					echo ' |_|  |_|\__,_|_|  |_|\__,_|_____/|____/ ' >> log.og
					apt-get install -y mariadb-server >> log.og || ins=0
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando MariaDB" 10 80 0
			        ;;
				6)
					apt-get install -y phpmyadmin >> log.og || ins=0
					echo $prog | dialog --title "Instalacion en progreso." --gauge "Por favor, espere...\n Instalando Apache2" 10 80 0
        			;;
			esac
		done
		echo "100" | dialog --title "Instalacion en progreso." --gauge "Instalacion completada." 10 80 0
		sleep 2
		if [[ $ins -eq 1 ]]; then
			dialog --title "Informacion" --yesno "Paquetes instalados correctamente. ¿Quieres ver el log?" 0 0
			if [ $? -eq 0 ]; then
				dialog --title "Log de instalacion" --textbox log.og 0 0
			fi
		elif [[ $ins -eq 0 ]];then
			dialog --title "ERROR" --yesno "Ha ocurrido un error al instalar los paquetes. ¿Quieres ver el log?" 0 0
			if [ $? -eq 0 ]; then
				dialog --title "Log de instalacion" --textbox log.og 0 0
			fi
		fi
	else
		dialog --title "Informacion" --msgbox "Instalacion cancelada." 0 0
	fi
rm -r log.og
