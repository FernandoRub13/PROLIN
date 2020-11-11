#!/bin/bash
#
# Nombre del juego: Ahorcado
#
# Este juego tiene como base de datos un fichero de nombre dict.dat en el cual se 
# concentran las palabras que conforman el juego.
#
# Este juego esta basado  en el hangman de Ashton Seth Reimer, repositorio de github:
# https://github.com/asreimer/bash_hangman
# Con la funcionalidad añadida de que soporta un lenguaje mas, es decir,
# soporta la funcionalidad para adivinar palabras o solo en ingles o solo en español
#
#Aqui se declaran variables de tipo arreglo (-a
declare -a word
declare -a imagen_de_palabra
declare -a imagen_abecedario
i=0
error=0
ind_de_la_palabra=0
correct=0
abecedario=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
char=0

#Aqui se la función lectura_de_archivo lee el diccionario llamado dict.dat
#para posteriormente colocar las palabras linea por linea en el arreglo
function lectura_de_archivo
{
echo "Digite el idioma de las palabras a adivinar:"
echo "1. Español"
echo "2. Ingles"
read lenguaje_dic

if [ $lenguaje_dic -eq 1 ]
then
	#statements

	exec 3<&0				#Aqui se abre el archivo para poder redireccionar las entradas desde el fichero dict.dat.
	exec 0< dict.dat 		
	while read LINEA		#Aqui se lee linea por linea del fichero
	do

	word[i]=$LINEA
	i=`expr $i + 1`
	done
	exec 0<&3
else

	exec 3<&0				#Aqui se abre el archivo para poder redireccionar las entradas desde el fichero dict2.dat.
	exec 0< dict2.dat 		
	while read LINEA		#Aqui se lee linea por linea del fichero
	do

	word[i]=$LINEA
	i=`expr $i + 1`
	done
	exec 0<&3


fi
}

#Aqui la funcion lectura_de_palabra selecciona una palabra aleatoria.
function lectura_de_palabra {
	indice_de_palabra=$RANDOM

	while [ $indice_de_palabra -ge $i ]	#En este while se establece aleatoriamente un numero para el indice de la palabra que no exceda la cantidad de palabras
	do
		indice_de_palabra=$RANDOM
	done
	a=0
	while [ $a -lt ${#word[${indice_de_palabra}]} ] 		#Este while establece las palabras anteriores a la palabra seleccionada aleatoriamente en cero, para encontrar el indice de la palabra.
	do
		imagen_de_palabra[$a]=0
		a=`expr $a + 1`
	done
}

#Aqui la funcion adivina_letra solicita una letra al usuario
#y comprueba si es valida o no la letra introducida.
function adivina_letra
{
	j=0
	correct=0
	echo -n "Digita una letra: " #Solicita una letra al usuario y la guarda
	read adivina_letra
	char=$adivina_letra
	if [ ${#adivina_letra} -eq "1" ]
	then
	
		adivina_letra=`echo $adivina_letra | tr "[:upper:]" "[:lower:]"` #Remplazamos mayusculas por minusculas
		while [ $j -lt ${#word[${indice_de_palabra}]} ]
		do
			if [ "$adivina_letra" == "${word[${indice_de_palabra}]:$j:1}" ] #Si la letra ingresada corresponde con alguna de las contenidas por la palabra se toma como buena
			then
				imagen_de_palabra[${j}]=1
				correct=1
			fi
			j=`expr $j + 1`
		done
	fi
	r=0
	numero_de_letra=0
	while [ ! $r == ${#word[${indice_de_palabra}]} ]
	do
		
		numero_de_letra=`expr $numero_de_letra + ${imagen_de_palabra[$r]}`
		r=`expr $r + 1`
	done
}

#Aqui estan los dubjos que aparecerane n la terminal
function dib_horcas 
{
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}
function dib_horcas_cabeza 
{
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        (_)        |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}
function dib_horcas_cuerpo {
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        (_)        |"
echo "         |         |"
echo "         |         |"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}
function dib_horcas_brazo1 {
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        (_)        |"
echo "         |         |"
echo "      ---|         |"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}
function dib_horcas_brazo2 {
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        (_)        |"
echo "         |         |"
echo "      ---|---      |"
echo "         |         |"
echo "         |         |"
echo "                   |"
echo "                   |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}
function dib_horcas_pierna1 {
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        (_)        |"
echo "         |         |"
echo "      ---|---      |"
echo "         |         |"
echo "         |         |"
echo "        /          |"
echo "      _/           |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}
function dib_horcas_pierna2 {
clear
echo "          __________"
echo "         |         |"
echo "         |         |"
echo "       _/_\_       |"
echo "        (_)        |"
echo "         |         |"
echo "      ---|---      |"
echo "         |         |"
echo "         |         |"
echo "        / \        |"
echo "      _/   \_      |"
echo "                   |"
echo "      _____________|_____"
echo "                           "
}

#Aqui la funcion imprime_ganaste notifica al usuario de su victoria
function imprime_ganaste {
echo " _  ____    _    _   _    _    ____ _____ _____ _ "
echo "(_)/ ___|  / \  | \ | |  / \  / ___|_   _| ____| |"
echo "| | |  _  / _ \ |  \| | / _ \ \___ \ | | |  _| | |"
echo "| | |_| |/ ___ \| |\  |/ ___ \ ___) || | | |___|_|"
echo "|_|\____/_/   \_\_| \_/_/   \_\____/ |_| |_____(_)"

echo -en "\n\n\n"
}

#Aqui la funcion imprime_ganaste notifica al usuario de su derrota
function imprime_perdiste {
echo " _                 _ "
echo "(_)_   _ _ __  ___| |"
echo "| | | | | '_ \/ __| |"
echo "| | |_| | |_) \__ \_|"
echo "|_|\__,_| .__/|___(_)"
echo "        |_|          "
echo "La palabra incognita era: \"${word[$indice_de_palabra]}\""
}

#Aqui la funcion imprime abecedario imprime las palabras acertadas y las que aun no se adivinan 
#son colocadas con un guión haciendo referencia a que aún no las ha introducido
function imprime_abecedario {
	echo -e "\nLetras introducidas:"
	
	e=0
	while [ ! "$e" == "26" ]	#En este while se estructura la forma en que se imprimiran las letras
	do
		if [ "$char" == "${abecedario[$e]}" ]
		then
			imagen_abecedario[$e]="1"
		fi
		
		if [ ${imagen_abecedario[$e]} == "1" ] 
		then
			echo -n ${abecedario[$e]} #Se establece que se imprima la letra acertada
		else
			echo -n "-" #Se establece que se impriman con guion las no acertadas
		fi
		
		if [ $e == "12" ]
		then
			echo -e "\n"
		fi
		((e++))
	done
	echo -ne "\n\n"
	char=""
}

#Aqui la función imprime_la_palabra va imprimiendo las letras conforme vayamos acertandolas
function imprime_la_palabra {
	echo -ne "\nPalabra incognita: "
	t=0
	while [ ! $t == ${#word[${indice_de_palabra}]} ]
	do
			if [ ${imagen_de_palabra[${t}]} == "1" ]
			then
				echo -n "${word[${indice_de_palabra}]:$t:1}" #Especificamente aqui realiza la acción
			else
				echo -n "-"
			fi
			t=`expr $t + 1`
	done
	echo -e "\n\n"
}


#################################################
#!!! Aqui es el comienzo de la función principal#
#################################################

lectura_de_archivo;
gameover=0
error=0
correct=0
while [ "$gameover" == "0" ] #Mientras no hayamos perdido aun podremos seguir jugando gracias a este while
do

	a=0
	while [ ! "$a" == "26" ]
	do
		imagen_abecedario[$a]=0
		a=`expr $a + 1`
	done

	imagen_de_palabra=0
	imagen_abecedario=0	
	error=0
	correct=0
	lectura_de_palabra;  # De la linea 303-307 se llaman las funciones para dar formato al juego e imprimir las funcionalidades de cada modulo
	a=0
	dib_horcas;
	imprime_abecedario;
	imprime_la_palabra;

        #Este while nos ayuda a contabilizar las fallas 
	while [[ ! "${numero_de_letra}" == "${#word[${indice_de_palabra}]}" && ! "$error" == "6" ]]
	do
		adivina_letra;
	
		if [ $correct == "0" ]
		then 
			error=`expr $error + 1`
		fi	
	
		if [ $error == "0" ]
		then
			dib_horcas;
		elif [ $error == "1" ]
		then
			dib_horcas_cabeza;
		elif [ $error == "2" ]
		then
			dib_horcas_cuerpo;
		elif [ $error == "3" ]
		then
			dib_horcas_brazo1;
		elif [ $error == "4" ]
		then
			dib_horcas_brazo2;
		elif [ $error == "5" ]
		then
			dib_horcas_pierna1;
		elif [ $error == "6" ]
		then
			dib_horcas_pierna2;
		fi
		imprime_abecedario;
		imprime_la_palabra;
		
	done
	#En caso de ganar manda a llamar a funcion imprime_ganaste de lo contrario llama a imprime_perdiste
	if [ "${numero_de_letra}" == "${#word[${indice_de_palabra}]}" ]
	then
	imprime_ganaste;
	gameover=1
	fi
	if [ $error == "6" ]
	then
	clear;
	imprime_perdiste;
	gameover=1
	fi

	if [ "$gameover" == "1" ] 
	then
		echo -e "\n\n Quieres jugar de nuevo? (s/n)"
		read answer
		if [ "$answer" == "s" ]
		then
			gameover=0
		fi
		clear
	fi
done
exit 0

