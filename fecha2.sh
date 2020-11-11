#!/bin/bash
#Script que muestra la fecha completa empezando por el
#dia de la semana
#dia del mes
#nombre del mes
#año actual
#Se utiliza el etiquetdo \e[1;100;33m donde 
#"\e[" indica el inicio de etiquetado,
#"1" represnta letras impresas en negritas,
#"100" color de remarcado de texto, 
#"Colo del texto", 
echo -e "\e[1;100;33mEl día de hoy es: `date +"%A"` `date +"%d"` de `date +"%B"` de `date +"%Y :)"`\e[0m";
#Se utiliza el etiquetdo \e[0m para terminar el etiquetado de color