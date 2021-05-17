#!/bin/bash
aon=$(dialog --backtitle "Configuracion VirualHosts" --title "Servidor" --stdout --menu "Cuál vamos a usar:" 0 0 0 1 "Apache2" 2 "Nginx")
if [ $? -eq 0 ]; then
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
			salir=1
			nombrevhost=""
			servername=""
			directorio=""
			while [ $salir -eq 1 ]; do
				crea=$(dialog --backtitle "Crear VirtualHost" --title "Crear VHost $server" --stdout --menu "Elija una opcion para rellenar" 0 0 0 1 "Nombre Configuracion: $nombrevhost" 2 "Dominio: $servername" 3 "Directorio: $directorio" 4 "Crear Vhost")
				if [ $? -eq 0 ]; then
					case $crea in
						1)
						nombrevhost=$(dialog --title "Nombre fichero" --inputbox "Introduce un nombre para el archivo de configuracion:" 0 0)
						;;
						2)
						servername=$(dialog --title "Dominio" --inputbox "Introduce el dominio (www.ejemplo.com):" 0 0)
						;;
						3)
						nombrevhost=$(dialog --title "Nombre" --inputbox "Enter the directory name:" 0 0)
						;;
					esac
				elif [ $? -eq 1 ]; then
				
				salir=0
				fi
			done
			;;
			2)
				savevhost="/etc/nginx/sites-available"
				server="Nginx"
			;;
		esac
	fi
else
	exit
fi
exit
