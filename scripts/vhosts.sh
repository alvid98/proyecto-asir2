#!/bin/bash
salir1=1

aon=$(dialog --backtitle "Configuracion VirualHosts" --title "Servidor" --stdout --menu "Cuál vamos a usar:" 0 0 0 1 "Apache2" 2 "Nginx")
if [ $? -eq 0 ]; then
	case $aon in
		1)
			sitesavailable="/etc/apache2/sites-available/"
			sitesenabled="/etc/apache2/sites-enabled/"
			savevhost="/etc/apache2/sites-available/"
			server="Apache2"
		;;
		2)
			sitesavailable="/etc/nginx/sites-available/"
			sitesenabled="/etc/nginx/sites-enabled/"
			savevhost="/etc/nginx/sites-available/"
			server="Nginx"
		;;
	esac
while [ $salir1 -eq 1 ]; do
	salir2=1
	salir3=1
	salir4=1
	salir5=1
	salir6=1
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
						directorio=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio donde alojes los archivos de la web" --stdout --dselect /var/www/  14 70)
						;;
						4)
						if [ $server == "Apache2" ]; then
							echo "Listen 80" > $savevhost$nombrevhost
							echo "<VirtualHost *:80>" >> $savevhost$nombrevhost
							echo "    DocumentRoot $directorio" >> $savevhost$nombrevhost
							echo "    ServerName $servername" >> $savevhost$nombrevhost
							echo "    <Directory $directorio >" >> $savevhost$nombrevhost
							echo "            Require all granted" >> $savevhost$nombrevhost
							echo "    </Directory>" >> $savevhost$nombrevhost
							echo "</VirtualHost>" >> $savevhost$nombrevhost
						else
							echo "server {" > $savevhost$nombrevhost
							echo "        listen 80;" >> $savevhost$nombrevhost
							echo "        root $directorio;" >> $savevhost$nombrevhost
							echo "        index index.html index.php index.htm" >> $savevhost$nombrevhost
							echo "        server_name $servername;" >> $savevhost$nombrevhost
							echo "        location / {" >> $savevhost$nombrevhost
							echo '                 try_files $uri $uri/ =404;' >> $savevhost$nombrevhost
							echo "        }" >> $savevhost$nombrevhost
							echo "}" >> $savevhost$nombrevhost
						fi
						dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost creado para $server." 0 0
						salir2=0
						;;
					esac
				elif [ $? -eq 1 ]; then
					dialog --title "Informacion" --msgbox "Creacion de VirtualHost cancelada." 0 0
					salir2=0
				fi
			done
			rm -rf lista.*
			;;
			2)
			nombrevhost=""
			servername=""
			directorio=""
			while [ $salir3 -eq 1 ]; do
				edita=$(dialog --backtitle "Editar VirtualHost" --title "Editar VHost $server" --stdout --menu "Elija una opcion para rellenar" 0 0 0 1 "Nombre Configuracion: $nombrevhost" 2 "Dominio: $servername" 3 "Directorio: $directorio" 4 "Editar Vhost")
				if [ $? -eq 0 ]; then
					case $edita in
						1)
						ls $sitesavailable > lista.vhost
			                        terminal=$(echo $(tty))
			                        i=1
			                        j=1
									unset 'array1[@]'
			                        while read line; do
			                                array1[ $i ]=$j
			                                (( j++ ))
			                                array1[ ($i + 1) ]=$line
			                                (( i=($i+2) ))
                        			done < lista.vhost
			                        vhost=$(dialog --backtitle "Elegir VHost" --title "Editar VHost" --menu "Elige el VHost que desea editar:" 0 0 0 "${array1[@]}" 2>&1 >$terminal)
									if [ $? -eq 0 ]; then
										if [ $server == "Apache2" ]; then
											nombrevhost=$(cat lista.vhost | cut -f$vhost -d$'\n')
											servername=$(cat $sitesavailable$nombrevhost | grep ServerName | cut -d" " -f 6)
											sold="$servername"
											directorio=$(cat $sitesavailable$nombrevhost | grep Directory | cut -d" " -f 6)
											dold="$directorio"
										else
											nombrevhost=$(cat lista.vhost | cut -f$vhost -d$'\n')
											servername=$(cat $sitesavailable$nombrevhost | grep server_name | cut -d" " -f 10 | sed "s/;/ /g")
											sold="$servername"
											directorio=$(cat $sitesavailable$nombrevhost | grep root | cut -d" " -f 10 | sed "s/;/ /g")
											dold="$directorio"
										fi
										
									fi
						;;
						2)
						servername=$(dialog --stdout --title "Dominio" --inputbox "Introduce el dominio (www.ejemplo.com):" 0 0)
						;;
						3)
						directorio=$(dialog --backtitle "Para seleccionar un directorio, pulsa espacio 1 vez, para entrar en el, pulsa espacio 2 veces." --title "Selecciona el directorio que desea copiar" --stdout --dselect /var/www/  14 70)
						;;
						4)
						sed -i "s|$sold|$servername|g" $sitesavailable$nombrevhost
						sed -i "s|$dold|$directorio|g" $sitesavailable$nombrevhost
						dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost editado para $server." 0 0
						salir3=0
						;;
					esac
				elif [ $? -eq 1 ]; then
					dialog --title "Informacion" --msgbox "Edicion de VirtualHost cancelada." 0 0
					salir3=0
				fi
			done
			rm -rf lista.*
			;;
			3)
			while [ $salir4 -eq 1 ]; do
				ls $sitesavailable > lista.vhosts
				ls $sitesenabled >> lista.vhosts
				cat lista.vhosts | sort |uniq -u > lista.vhostdisabled
	                        terminal=$(echo $(tty))
	                        i=1
	                        j=1
				unset 'array2[@]'
	                        while read line; do
	                                array2[ $i ]=$j
	                                (( j++ ))
	                                array2[ ($i + 1) ]=$line
	                                (( i=($i+2) ))
                      			done < lista.vhostdisabled
	                        vhost=$(dialog --backtitle "Elegir VHost" --title "Activar VHost" --menu "Elige el VHost que desea activar:" 0 0 0 "${array2[@]}" 2>&1 >$terminal)
				if [ $? -eq 0 ]; then
					nombrevhost=$(cat lista.vhostdisabled | cut -f$vhost -d$'\n')
					if [ $server == "Apache2" ]; then
						a2ensite $nombrevhost
						systemctl reload apache2
					else
						ln -s /etc/nginx/sites-available/$nombrevhost /etc/nginx/sites-enabled/
					fi
					dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost activado para $server." 0 0
					salir4=0
				else
					dialog --title "Informacion" --msgbox "Activacion cancelada." 0 0
					salir4=0
				fi
			rm -rf lista.*
			done
			;;
			4)
			while [ $salir5 -eq 1 ]; do
				ls $sitesenabled > lista.vhostenabled
	                        terminal=$(echo $(tty))
	                        i=1
	                        j=1
				unset 'array3[@]'
	                        while read line; do
	                                array3[ $i ]=$j
	                                (( j++ ))
	                                array3[ ($i + 1) ]=$line
	                                (( i=($i+2) ))
                      			done < lista.vhostenabled
	                        vhost=$(dialog --backtitle "Elegir VHost" --title "Desactivar VHost" --menu "Elige el VHost que desea desactivar:" 0 0 0 "${array3[@]}" 2>&1 >$terminal)
				if [ $? -eq 0 ]; then
					nombrevhost=$(cat lista.vhostenabled | cut -f$vhost -d$'\n')
					if [ $server == "Apache2" ]; then
						a2dissite $nombrevhost
						systemctl reload apache2
					else
						rm "${sitesenabled}${nombrevhost}"
					fi
					dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost desactivado para $server." 0 0
					salir5=0
				else
					dialog --title "Informacion" --msgbox "Desactivacion cancelada." 0 0
					salir5=0
				fi
			done
			rm -rf lista.*
			;;
			5)
			while [ $salir6 -eq 1 ]; do
				ls $sitesavailable > lista.vhost
	                        terminal=$(echo $(tty))
	                        i=1
	                        j=1
				unset 'array4[@]'
	                        while read line; do
	                                array4[ $i ]=$j
	                                (( j++ ))
	                                array4[ ($i + 1) ]=$line
	                                (( i=($i+2) ))
                      			done < lista.vhost
	                        vhost=$(dialog --backtitle "Elegir VHost" --title "Eliminar VHost" --menu "Elige el VHost que desea eliminar:" 0 0 0 "${array4[@]}" 2>&1 >$terminal)
				if [ $? -eq 0 ]; then
					nombrevhost=$(cat lista.vhost | cut -f$vhost -d$'\n')
					if [ $server == "Apache2" ]; then
						a2dissite $nombrevhost
						systemctl reload apache2
						rm "${sitesavailable}${nombrevhost}"
					else
						rm "${sitesenabled}${nombrevhost}"
						rm "${sitesavailable}${nombrevhost}"
					fi
					dialog --title "Informacion" --msgbox "VirtualHost $nombrevhost eliminado para $server." 0 0
					salir6=0
				else
					dialog --title "Informacion" --msgbox "Eliminado cancelado." 0 0
					salir6=0
				fi

			done
			rm -rf lista.*
			;;
		esac
	else
		salir1=0
	fi
done
fi
