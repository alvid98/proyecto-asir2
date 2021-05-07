#!/bin/bash
clear
#Script de instalación de debian.

#Comprobamos si los paquetes están instalados.
apache2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
nginx=$(dpkg-query -W -f='${Status}' nginx 2>/dev/null | grep -c "ok installed")
php=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c "ok installed")
python=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
mysql=$(dpkg-query -W -f='${Status}' mariadb-server 2>/dev/null | grep -c "ok installed")
phpmyadmin=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c "ok installed")

if [[ $apache2 -eq 1 ]];
then
	sna2="Existe"
	a2=0
else
	sna2="Si"
	a2=1
fi

if [[ $nginx -eq 1 ]];
then
	snnx="Existe"
	nx=0
else
	snnx="No"
	nx=0
fi

if [[ $php -eq 1 ]];
then
	snph="Existe"
	ph=0
else
	snph="Si"
	ph=1
fi

if [[ $python -eq 1 ]];
then
	snpt="Existe"
	pt=0
else
	snpt="No"
	pt=0
fi

if [[ $mysql -eq 1 ]];
then
	snms="Existe"
	ms=0
else
	snms="Si"
	ms=1
fi

if [[ $phpmyadmin -eq 1 ]];
then
	snpm="Existe"
	pm=0
else
	snpm="Si"
	pm=1
fi

salir=0
ins=1
	clear
	valor=$(dialog --nocancel --title "Instalacion" --stdout --checklist "Escoge los paquetes que desees" 0 0 0 1 "Apache2 - Servidor Web" off 2 "Nginx   - Servidor Web" off 3 "Php     - Interprete " off 4 "Python  - IDE" off 5 "Mysql   - Bases de datos" off 6 "Phpmyadmin" off)
	dialog --stdout --title "Confirmación" --yesno "¿Seguro que desea instalar los siguientes paquetes?" 0 0
	sino=$?
	if [ $sino -eq 0 ]; then
		clear
		echo $valor
		for valor in $valor; do
			case $valor in
				1)
					if [[ "$snnx" = "Existe" ]]; then
						service nginx stop
					fi
					echo '                            _          ___  '
					echo '     /\                    | |        |__ \ '
					echo '    /  \   _ __   __ _  ___| |__   ___   ) |'
					echo '   / /\ \ | ´_ \ / _` |/ __|  _ \ / _ \ / / '
					echo '  / ____ \| |_) | (_| | (__| | | |  __// /_ '
					echo ' /_/    \_\ .__/ \__,_|\___|_| |_|\___|____|'
					echo '          | |                               '
					echo '          |_|'
					apt install -y apache2 || ins=0
				;;
				2)
					if [[ "$sna2" = "Existe" ]]; then
						service apache2 stop
					fi
					echo '   _   _       _            '
					echo '  | \ | |     (_)           '
					echo '  |  \| | __ _ _ _ __ __  __'
					echo '  | . ` |/ _` | | ´_ \\ \/ /'
					echo '  | |\  | (_| | | | | |>  < '
					echo '  |_| \_|\__, |_|_| |_/_/\_\'
					echo '         __/ |             '
					echo '        |___/  '
					apt install -y nginx || ins=0
				;;
				3)
					echo '  _____  _           '
					echo ' |  __ \| |          '
					echo ' | |__) | |__  _ __  '
					echo ' |  ___/|  _ \| ´_ \ '
					echo ' | |    | | | | |_) |'
					echo ' |_|    |_| |_| .__/ '
					echo '              | |    '
					echo '              |_|    '
					apt install -y php || ins=0
			        ;;
				4)
					echo '  _____       _   _                 ____  '
					echo ' |  __ \     | | | |               |___ \ '
					echo ' | |__) |   _| |_| |__   ___  _ __   __) |'
					echo ' |  ___/ | | | __|  _ \ / _ \| ´_ \ |__ < '
					echo ' | |   | |_| | |_| | | | (_) | | | |___) |'
					echo ' |_|    \__, |\__|_| |_|\___/|_| |_|____/ '
					echo '         __/ |                            '
					echo '        |___/                     '
					apt install -y python3 || ins=0
			        ;;
				5)
					echo '  __  __            _       _____  ____  '
					echo ' |  \/  |          (_)     |  __ \|  _ \ '
					echo ' | \  / | __ _ _ __ _  __ _| |  | | |_) |'
					echo ' | |\/| |/ _` | ´__| |/ _` | |  | |  _ < '
					echo ' | |  | | (_| | |  | | (_| | |__| | |_) |'
					echo ' |_|  |_|\__,_|_|  |_|\__,_|_____/|____/ '
					apt install -y mariadb-server || ins=0
			        ;;
				6)
					apt install -y phpmyadmin || ins=0
        			;;
			esac
		done

		if [[ $ins -eq 1 ]]; then
			dialog --title "Información" --msgbox "Paquetes instalados correctamente." 0 0
		elif [[ $ins -eq 0 ]];then
			dialog --title "ERROR" --msgbox "Ha ocurrido un error al instalar los paquetes." 0 0
		fi
	else
		dialog --title "Información" --msgbox "Instalación cancelada." 0 0
	fi
