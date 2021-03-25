#!/bin/bash
clear
#Script de instalación de debian.
num=1
#Comprobamos si los paquetes están instalados.
apache2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
nginx=$(dpkg-query -W -f='${Status}' nginx 2>/dev/null | grep -c "ok installed")
php=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c "ok installed")
python=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
mysql=$(dpkg-query -W -f='${Status}' mariadb-server 2>/dev/null | grep -c "ok installed")
phpmyadmin=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c "ok installed")

if [[ $apache2 -eq 1 ]];
then
	i1=1
	sna2="No"
	a2=0
else
	i1=0
fi

if [[ $nginx -eq 1 ]];
then
	i2=1
	snnx="No"
	nx=0
else
	i2=0
fi

if [[ $php -eq 1 ]];
then
	i3=1
	snph="No"
	ph=0
else
	i3=0
fi

if [[ $python -eq 1 ]];
then
	i4=1
	snpt="No"
	pt=0
else
	i4=0
fi

if [[ $mysql -eq 1 ]];
then
	i5=1
	snms="No"
	ms=0
else
	i5=0
fi

if [[ $phpmyadmin -eq 1 ]];
then
	i6=1
	snpm="No"
	pm=0
else
	i6=0
fi

salir=0
while [ $salir -eq 0 ]; do
	clear
	echo "╔═══════════════════════════════════════╗"
	echo "║Paquete:		Selección:	║"
	echo "╚═══════════════════════════════════════╝"
	echo "┌---------------------------------------┐"
	if [ "$i1" = 1 ];then
	echo "|"$num"-Apache2		" $sna2"		|"
	num+=1
	fi
	if [ "$i2" = 1 ];then
	echo "|"$num"-nginx		" $snnx"		|"
	num+=1
	fi
	if [ "$i3" = 1 ];then
	echo "|"$num"-php			" $snph"		|"
	num+=1
	fi
	if [ "$i4" = 1 ];then
	echo "|"$num"-python		" $snpt"		|"
	num+=1
	fi
	if [ "$i5" = 1 ];then
	echo "|"$num"-mysql		" $snms"		|"
	num+=1
	fi
	if [ "$i6" = 1 ];then
	echo "|"$num"-PhpMyAdmin		" $snpm"		|"
	num+=1
	fi
	if [ "$i1" = 0 ] && [ "$i2" = 0 ] && [ "$i3" = 0 ] && [ "$i4" = 0 ] && [ "$i5" = 0 ] && [ "$i6" = 0 ];then
	echo "| No existe ningun paquete para eliminar|"
	echo "└---------------------------------------┘"
	echo "╔═══════════════════════════════════════╗"
	else
	echo "└---------------------------------------┘"
	echo "╔═══════════════════════════════════════╗"
	echo "║7-Desinstalar seleccionados.           ║"
	fi
	echo "║8-Atrás                                ║"
	echo "╚═══════════════════════════════════════╝"

	read -p "Opción: " valor
	case $valor in
		1)
		if [[ $sna2 == "Si" ]];
		then
			sna2="No"
			a2=0
		else
			sna2="Si"
			a2=1
		fi
		;;
		2)
                if [[ $snnx == "Si" ]];
                then
			snnx="No"
			nx=0
                else
			snnx="Si"
			nx=1
                fi
		;;
		3)
                if [[ $snph == "Si" ]];
                then
			snph="No"
			ph=0
                else
			snph="Si"
			ph=1
                fi
		;;
		4)
                if [[ $snpt == "Si" ]];
                then
			snpt="No"
			pt=0
                else
			snpt="Si"
			pt=1
                fi
		;;
		5)
                if [[ $snms == "Si" ]];
                then
			snms="No"
			ms=0
                else
			snms="Si"
			ms=1
                fi
		;;
		6)
                if [[ $snpm == "Si" ]];
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
		;;
        8)
		salir=1
		;;
	esac
	clear
done
