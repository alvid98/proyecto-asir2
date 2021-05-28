#!/bin/bash -x
salir1=1
salir2=1
salir3=1

aon=$(dialog --backtitle "Configuracion VirualHosts" --title "Servidor" --stdout --menu "Cuál vamos a usar:" 0 0 0 1 "Apache2" 2 "Nginx")
if [ $? -eq 0 ]; then
	case $aon in
		1)
			fichero="default_apache"
			savevhost="/etc/apache2/sites-available"
			server="Apache2"
		;;
		2)
			fichero="default_nginx"
			savevhost="/etc/nginx/sites-available"
			server="Nginx"
		;;
	esac
	menu=$(dialog --backtitle "Configuracion VirualHosts" --title "$server" --stdout --menu "¿Qué desea hacer?" 0 0 0 1 "Crear VHost" 2 "Editar VHost" 3 "Activar VHost" 4 "Desactivar VHost" 5 "Eliminar VHost")
	if [ $? -eq 0 ]; then
		case $menu in
			1)
			nombrevhost=""
			servername=""
			directorio=""
			while [ $salir2 -eq 1 ]; do
				crea=$(dialog --backtitle "Crear VirtualHost" --title "Crear VHost $server" --stdout --menu "Elija una opcion para rellenar" 0 0 0 1 "Nombre Configuracion: $nombrevhost" 2 "Dominio: $servername" 3 "Directorio: $directorio" 4 "Crear Vhost")
				if [ $? -eq 0 ]; then
					case $crea in
						1)
						nombrevhost=$(dialog --stdout --title "Nombre fichero" --inputbox "Introduce un nombre para el archivo de configuracion:" 0 0)
						;;
						2)
						servername=$(dialog --stdout --title "Dominio" --inputbox "Introduce el dominio (www.ejemplo.com):" 0 0)
						;;
						3)
						directorio=$(dialog --stdout --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio donde alojes los archivos de la web" --dselect /var/www/  14 70)
						;;
						4)
						cp ficheros/$fichero ficheros/$nombrevhost
						sed -i -E "s/(DocumentRoot) @/\1 $directorio/g" ficheros/$nombrevhost
						sed -i -E "s/(ServerName) @/\1 $servername/g" ficheros/$nombrevhost
						sed -i -E "s/.*(Directory) .*/<\1 $directorio >/g" ficheros/$nombrevhost
						dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost creado para $server." 0 0
						salir2=0
						;;
					esac
				elif [ $? -eq 1 ]; then
					dialog --title "Informacion" --msgbox "Creacion de VirtualHost cancelada." 0 0
					salir2=0
				fi
			done
			;;
			2)
			nombrevhost=""
			servername=""
			directorio=""
			while [ $salir3 -eq 1 ]; do
				edita=$(dialog --backtitle "Crear VirtualHost" --title "Crear VHost $server" --stdout --menu "Elija una opcion para rellenar" 0 0 0 1 "Nombre Configuracion: $nombrevhost" 2 "Dominio: $servername" 3 "Directorio: $directorio" 4 "Crear Vhost")
				if [ $? -eq 0 ]; then
					case $edita in
						1)
						ls ficheros/ > lista.vhost
			                        terminal=$(echo $(tty))
			                        i=1
			                        j=1
			                        while read line; do
			                                array[ $i ]=$j
			                                (( j++ ))
			                                array[ ($i + 1) ]=$line
			                                (( i=($i+2) ))
                        			done < lista.vhost
			                        vhost=$(dialog --backtitle "Elegir VHost" --title "Editar VHost" --menu "Elige el VHost que desea editar:" 0 0 0 "${array[@]}" 2>&1 >$terminal)
						if [ $? -eq 0 ]; then
							nombrevhost=$(cat lista.vhost | cut -f$vhost -d$'\n')
							servername=$(cat ficheros/$nombrevhost | grep ServerName | cut -d" " -f 6)
							directorio=$()
						fi
						;;
						2)
						servername=$(dialog --stdout --title "Dominio" --inputbox "Introduce el dominio (www.ejemplo.com):" 0 0)
						;;
						3)
						directorio=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio que desea copiar" --stdout --dselect /var/www/  14 70)
						;;
						4)
						dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost creado para $server." 0 0
						salir3=0
						;;
					esac
				elif [ $? -eq 1 ]; then
					dialog --title "Informacion" --msgbox "Editado de VirtualHost cancelada." 0 0
					salir3=0
				fi
			done
			;;
		esac
	fi
else
	salir1=0
fi
