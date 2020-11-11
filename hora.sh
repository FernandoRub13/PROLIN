#!/bin/bash
#Script que nos imprime la hora en formato hora:minutos:segundos
#Se utiliza el etiquetdo \e[1;100;33m donde 
#"\e[" indica el inicio de etiquetado,
#"1" represnta letras impresas en negritas,
#"100" color de remarcado de texto, 
#"Colo del texto", 
echo -e "\e[1;100;33mQué tal humano, la hora actual es: `date|awk '{print $5}'` :) \e[0m"; 
#Se utiliza el etiquetdo \e[0m para terminar el etiquetado de color