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
while [ $salir -eq 0 ]; do
	clear
	echo "Lista de paquetes que se van a instalar:"
	echo "Para cambiar un valor, elige la opción."
	echo "Si un paquete ya esta instalado, pondrá que existe."
	echo "╔═══════════════════════════════════════╗"
	echo "║Paquete:		Selección:	║"
	echo "╚═══════════════════════════════════════╝"
	echo "┌---------------------------------------┐"
	echo "|1-Apache2		" $sna2"		|"
	echo "|2-nginx		" $snnx"		|"
	echo "|3-php			" $snph"		|"
	echo "|4-python		" $snpt"		|"
	echo "|5-mysql		" $snms"		|"
	echo "|6-PhpMyAdmin		" $snpm"		|"
	echo "└---------------------------------------┘"
	echo "╔═══════════════════════════════════════╗"
	echo "║7-Instalar seleccionados.              ║"
        echo "║8-Atrás                                ║"
	echo "╚═══════════════════════════════════════╝"

	read -p "Opción: " valor
	case $valor in
		1)
		if [[ $sna2 == "Existe" ]];
			then a2=0
		elif [[ $sna2 == "Si" ]];
		then
			sna2="No"
			a2=0
		else
			sna2="Si"
			a2=1
		fi
		;;
		2)
		if [[ $snnx == "Existe" ]];
                	then nx=0
                elif [[ $snnx == "Si" ]];
                then
			snnx="No"
			nx=0
                else
			snnx="Si"
			nx=1
                fi
		;;
		3)
		if [[ $snph == "Existe" ]];
                	then ph=0
                elif [[ $snph == "Si" ]];
                then
			snph="No"
			ph=0
                else
			snph="Si"
			ph=1
                fi
		;;
		4)
		if [[ $snpt == "Existe" ]];
                	then pt=0
                elif [[ $snpt == "Si" ]];
                then
			snpt="No"
			pt=0
                else
			snpt="Si"
			pt=1
                fi
		;;
		5)
		if [[ $snms == "Existe" ]];
                	then ms=0
                elif [[ $snms == "Si" ]];
                then
			snms="No"
			ms=0
                else
			snms="Si"
			ms=1
                fi
		;;
		6)
		if [[ $snpm == "Existe" ]];
                	then pm=0
                elif [[ $snpm == "Si" ]];
                then
			snpm="No"
			pm=0
                else
			snpm="Si"
			pm=1
                fi
		;;
		7)
		echo $a2 $nx $ph $pt $ms $pm
		read -p "enter para continuar"
		if [ "$a2" = 1 ]; then
			if [ "$snnx" = "Existe" ]; then
				service nginx stop
			fi
			apt install -y apache2 &>/dev/null
		fi
	        if [ "$nx" = 1 ]; then
			if [ "$sna2" = "Existe" ]; then
				service apache2 stop
			fi
			apt install -y nginx &>/dev/null
		fi
	        if [ "$ph" = 1 ]; then
			apt install -y php &>/dev/null
	        fi
	        if [ "$pt" = 1 ]; then
			apt install -y python3 &>/dev/null
	        fi
	        if [ "$ms" = 1 ]; then
			apt install -y mariadb-server &>/dev/null
	        fi
	        if [ "$pm" = 1 ]; then
			apt install -y phpmyadmin &>/dev/null
        	fi
	        if [ "$a2" = 0 ] && [ "$nx" = 0 ] && [ "$ph" = 0 ] && [ "$pt" = 0 ] && [ "$ms" = 0 ] && [ "$pm" = 0 ]; then
			clear
			echo "╔══════════════════════════════════════════════╗"
			echo "║ ERROR: No se ha seleccionado ningun paquete. ║"
			echo "║ Presiona enter para continuar.               ║"
			echo "╚══════════════════════════════════════════════╝"
			read
		else
			clear
			echo "╔══════════════════════════════════════════════╗"
			echo "║ Paquetes instalados correctamente.           ║"
			echo "║ Presiona enter para continuar.               ║"
			echo "╚══════════════════════════════════════════════╝"
			read
			salir=1
		fi
		;;
        	8)
		salir=1
		;;
	esac
	clear
done
