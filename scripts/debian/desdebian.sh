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

	a2=0
	nx=0
	ph=0
	pt=0
	ms=0
	pm=0

if [[ $apache2 -eq 1 ]];
then
	i1=1
	sna2="No"
else
	i1=0
fi

if [[ $nginx -eq 1 ]];
then
	i2=1
	snnx="No"
else
	i2=0
fi

if [[ $php -eq 1 ]];
then
	i3=1
	snph="No"
else
	i3=0
fi

if [[ $python -eq 1 ]];
then
	i4=1
	snpt="No"
else
	i4=0
fi

if [[ $mysql -eq 1 ]];
then
	i5=1
	snms="No"
else
	i5=0
fi

if [[ $phpmyadmin -eq 1 ]];
then
	i6=1
	snpm="No"
else
	i6=0
fi

salir=0
while [ $salir -eq 0 ]; do
	num=1
	clear
	echo "╔═══════════════════════════════════════╗"
	echo "║Paquete:		Selección:	║"
	echo "╚═══════════════════════════════════════╝"
	echo "┌---------------------------------------┐"
	if [ "$i1" = 1 ];then
	echo "|"$num"-Apache2		" $sna2"		|"
	x1=$num
	num=$[$num+1]
	fi
	if [ "$i2" = 1 ];then
	echo "|"$num"-nginx		" $snnx"		|"
	x2=$num
	num=$[$num+1]
	fi
	if [ "$i3" = 1 ];then
	echo "|"$num"-php			" $snph"		|"
	x3=$num
	num=$[$num+1]
	fi
	if [ "$i4" = 1 ];then
	echo "|"$num"-python		" $snpt"		|"
	x4=$num
	num=$[$num+1]
	fi
	if [ "$i5" = 1 ];then
	echo "|"$num"-mysql		" $snms"		|"
	x5=$num
	num=$[$num+1]
	fi
	if [ "$i6" = 1 ];then
	echo "|"$num"-PhpMyAdmin		" $snpm"		|"
	x6=$num
	num=$[$num+1]
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
		$x1)
		if [[ $sna2 == "Si" ]];
		then
			sna2="No"
			a2=0
		else
			sna2="Si"
			a2=1
		fi
		;;
		$x2)
                if [[ $snnx == "Si" ]];
                then
			snnx="No"
			nx=0
                else
			snnx="Si"
			nx=1
                fi
		;;
		$x3)
                if [[ $snph == "Si" ]];
                then
			snph="No"
			ph=0
                else
			snph="Si"
			ph=1
                fi
		;;
		$x4)
                if [[ $snpt == "Si" ]];
                then
			snpt="No"
			pt=0
                else
			snpt="Si"
			pt=1
                fi
		;;
		$x5)
                if [[ $snms == "Si" ]];
                then
			snms="No"
			ms=0
                else
			snms="Si"
			ms=1
                fi
		;;
		$x6)
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
                clear
                echo "╔══════════════════════════════════════════════╗"
                echo "║ Eliminando paquetes seleccionados...         ║"
                echo "╚══════════════════════════════════════════════╝"

                if [ "$a2" = 1 ]; then
                        if [ "$snnx" = "Existe" ]; then
                                service nginx stop
                        fi
                        apt remove -y apache2 &>/dev/null
                        apt purge -y apache2 &>/dev/null
                fi
                if [ "$nx" = 1 ]; then
                        if [ "$sna2" = "Existe" ]; then
                                service apache2 stop
                        fi
                        apt remove -y nginx &>/dev/null
                        apt purge -y nginx &>/dev/null
                fi
                if [ "$ph" = 1 ]; then
                        apt remove -y php &>/dev/null
                        apt purge -y php &>/dev/null
                fi
                if [ "$pt" = 1 ]; then
                        apt remove -y python3 &>/dev/null
                        apt purge -y python3 &>/dev/null
                fi
                if [ "$ms" = 1 ]; then
                        apt remove -y mariadb-server &>/dev/null
                        apt purge -y mariadb-server &>/dev/null
                fi
                if [ "$pm" = 1 ]; then
                        apt remove -y phpmyadmin &>/dev/null
                        apt purge -y phpmyadmin &>/dev/null
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
                        echo "║ Paquetes eliminados correctamente.           ║"
                        echo "║ Presiona enter para continuar.               ║"
                        echo "╚══════════════════════════════════════════════╝"
                        read
		fi
		;;
        8)
		salir=1
		;;
	esac
	clear
done
