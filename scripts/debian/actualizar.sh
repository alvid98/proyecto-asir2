#!/bin/bash
dialog --stdout --title "Confirmación" --yesno "¿Desea comprobar actualizaciónes?" 0 0
if [ $? -eq 0 ]; then
  apt-get update &>/dev/null
  dialog --stdout --title "Confirmación" --yesno "Hay $nact paquetes disponibles para actualizar, ¿desea actualizar ahora?" 0 0
  if [ $? -eq 0 ]; then
    apt-get upgrade -y 1>/dev/null
  fi
fi
