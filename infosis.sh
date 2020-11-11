#!/bin/bash

#En este script se pretende imprimir la información básica del equipo
#en el cual se está ejecutando el sript.

#Es importante mencionar que los comandos entre acentos graves ("`")
#son los que nos permiten ejecutar los comandos.


clear
#Se utiliza el etiquetdo \e[1;100;33m donde 
#"\e[" indica el inicio de etiquetado,
#"1" represnta letras impresas en negritas,
#"100" color de remarcado de texto, 
#"Colo del texto", 
echo -e "\e[1;100;33mInformacion basica del sistema:"
echo -e ""
#Se utiliza el comando uname para imprimir el nombre del sistema operativo
echo -e "Sistema operativo: `uname`"
#Se utiliza el comando uname -v para imprimir la version del kernel
echo -e "Kernel version: `uname -v`"
#Se utiliza el comando uname -v para imprimir la arquitectura del equipo
echo -e "Usuario logueado: $USER"
echo -e ""
echo -e "Informacion avanzada del sistema:"
#Se utiliza el comando lscpu para imprimir información avanzada del sistema
#Se utiliza el etiquetdo \e[0m para terminar el etiquetado de color
echo -e "`lscpu `\e[0m"
