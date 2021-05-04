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
	clear
	valor=$(dialog --title "Instalacion" --stdout --checklist "Escoge los paquetes que desees" 0 0 0 1 "Apache2" off 2 "Nginx" off 3 "Php" off 4 "Python" off 5 "Mysql" off 6 "Phpmyadmin" off --menu "Elige" 1 "Instalar" 2 "Salir")
	if [ $valor -eq 0 ]; then salir=1; else
	clear
	echo $valor
	if [[ $valor == "" ]]; then valor=8; fi
	for valor in $valor; do
		case $valor in
			1)
				if [[ "$snnx" = "Existe" ]]; then
					service nginx stop
				fi
				apt install -y apache2 &>/dev/null
			;;
			2)
				if [[ "$sna2" = "Existe" ]]; then
					service apache2 stop
				fi
				apt install -y nginx &>/dev/null
			;;
			3)
				apt install -y php &>/dev/null
		        ;;
			4)
				apt install -y python3 &>/dev/null
		        ;;
			5)
				apt install -y mariadb-server &>/dev/null
		        ;;
			6)
				apt install -y phpmyadmin &>/dev/null
        		;;
			7)
				salir=1
			;;
			8)
				dialog --title "ERROR" --msgbox "No has seleccionado ningún paquete." 0 0
			;;
		esac

		if [ $ins -eq 1 ]; then
			clear
			echo "╔══════════════════════════════════════════════╗"
			echo "║ Paquetes instalados correctamente.           ║"
			echo "║ Presiona enter para continuar.               ║"
			echo "╚══════════════════════════════════════════════╝"
			read
			salir=1
		fi
	done
	fi
