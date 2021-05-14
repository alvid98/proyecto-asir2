#!/bin/bash
aon=$(dialog --backtitle "Configuracion VirualHosts" --title "Servidor" --stdout --menu "Cuál vamos a usar:" 0 0 0 1 "Apache2" 2 "Nginx")
if [ $? -eq 0 ];then
	case $aon in
		1)
			savevhost="/etc/apache2/sites-available"
			server="Apache2"
		;;
		2)
			savevhost="/etc/nginx/sites-available"
			server="Nginx"
		;;
	esac
	menu=$(dialog --backtitle "Configuracion VirualHosts" --title "$server" --stdout --menu "¿Qué desea hacer?" 0 0 0 1 "Crear VHost" 2 "Editar VHost" 3 "Eliminar VHost")
	if [ $? -eq 0 ];then
		case $aon in
			1)
				nombrevhost=""
				servername=""
				directorio=""
				datos=$(dialog --ok-label "Crear" \
				  --backtitle "Creacion de VirtualHost" \
				  --title "$server" \
				  --form "Creacion de VirtualHost" \
				0 0 0 \
				"Nombre de la config:" 1 1	"$nombrevhost" 	1 23 30 0 \
				"Dominio del servidor:"    2 1	"$servername"  	2 23 30 0 \
				"Directorio de la web:"    3 1	"$directorio"  	3 23 30 0 \
				3>&1 1>&2 2>&3 3>&-)
				arraydatos=($datos)
				echo ${arraydatos[0]}
				echo ${arraydatos[1]}
				echo ${arraydatos[2]}
			;;
			2)
				savevhost="/etc/nginx/sites-available"
				server="Nginx"
			;;
		esac
	fi
fi

