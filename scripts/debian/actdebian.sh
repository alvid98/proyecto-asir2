#!/bin/bash
clear
echo "╔══════════════════════════════════════════════╗"
echo "║ Actualizando paquetes del sistema...         ║"
echo "╚══════════════════════════════════════════════╝"
apt-get update &>/dev/null
apt-get upgrade -y 1>/dev/null
echo "╔══════════════════════════════════════════════╗"
echo "║ Paquetes actualizados.                       ║"
echo "║ Pulsa enter para continuar.                  ║"
echo "╚══════════════════════════════════════════════╝"
read
