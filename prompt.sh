#!/bin/bash
#Cambiar de clolor
ROJO="\e[31m"
AZUL="\e[0;34m"
MAGENTA="\e[35m"
BLANCO="\e[97m"
NEGRITA="\e[1m"
RESET="\e[0m"
CURSIVA="\e[3m"
SUBRAYADO="\e[4m"
OCULTAR="\e[8m"
FONDOBLA="\e[107m"


#Valida que el programa whois que se usa para encriptar la contraseña esté instalado.
aux=$(aptitude show whois | grep "Estado: instalado") #aptitude show muestra información sobre el paquete.
if `echo "$aux" | grep "Estado: instalado" >/dev/null` #grep busca en esta información la frase "Estado: instalado"
														#En caso de que si esté instalado, manda un mensaje.
then
	echo "$NEGRITA $MAGENTA Whois instalado. $RESET" #Si está instalado, no hace nada.
	clear
else
	echo -e "$NEGRITA $MAGENTA Instalando whois, paquete necesario." #Si no está instalado, lo hace con apt-get
	sudo apt-get install whois
	clear
fi

aux=$(aptitude show mpg123 | grep "Estado: instalado") #Los mismos pasos que el anterior pero con mpg123
if `echo "$aux" | grep "Estado: instalado" >/dev/null`

then

	echo "$NEGRITA $MAGENTA mpg123 instalado. $RESET"
	clear
else
	echo -e "$NEGRITA $MAGENTA Instalando mpg123, paquete necesario. $RESET"
	sudo apt-get install mpg123
	clear
fi

#Cancelar las señales enviadas por la combinación de teclas.

trap "" SIGINT   # INT es la señal que manda Ctrl + c
trap "" SIGTSTP  # TSTP es la señal que manda Ctrl + z
ubi=$(pwd);

#Inicio de sesión.
echo -e "\n $NEGRITA $ROJO $SUBRAYADO Introduzca su usuario y contraseña. $RESET\n "
read -p "$(echo -e "$NEGRITA $MAGENTA $CURSIVA Usuario: $RESET" )" usuario
read -p "$(echo -e "$NEGRITA $MAGENTA $CURSIVA Contraseña: $RESET" )" -s contra
echo -e "\n"

#busca usuario  y guarda en un arreglo la linea donde lo encontro 
buscaUsuario=`sudo -S grep -r $usuario /etc/shadow 2>/dev/null ` 
IFS='$' 
read -a array <<< "$buscaUsuario" 
IFS=' '

contra_encript=`mkpasswd -m sha-512 "$contra" "${array[2]}"` #Encriptamos la contraseña y la buscamos en la línea obtenida
															#de etc/shadow
if [ `echo "$buscaUsuario" | grep -c "$contra_encript"` -eq 1   ] #si es la misma, entramos a PROLIN
	then
		clear
		USER=$usuario
		#cd /home/$usuario
		echo -e "$NEGRITA$FONDOBLA
		░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
		$RESET$NEGRITA$ROJO	Hola $usuario bienvenido a PROLIN $RESET	   
		$NEGRITA$FONDOBLA░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░$RESET\n"

		
		while :
		do
			#IFS=' '																		
			read -p  "$(echo -en "$NEGRITA$MAGNETA$usuario:$NEGRITA$ROJO$PWD$RESET"$  )" -a comando 
			
			
      		case ${comando[0]} in
				
				'arbol')

					bash $ubi/arbol.sh "${comando[1]}"
				;;
						
          		'hora')
          			bash $ubi/hora.sh
				;;

				'hora2')
					bash $ubi/hora2.sh
				;;

				'fecha')
					bash $ubi/fecha.sh
				;;

				'fecha2')
					bash $ubi/fecha2.sh
				;;

				'ayuda')
						bash $ubi/ayuda.sh
				;;

				'infosis')
						bash $ubi/infosis.sh
				;;

				'prebeplayer')
						
          				bash $ubi/prebeplayer.sh "${comando[@]}"
          				
				;;

				'gato')
						bash $ubi/gato.sh
				;;

				'ahorcado')
						bash $ubi/ahorcado.sh
				;;

				'buscar')

					bash $ubi/busqueda.sh "${comando[1]}" "${comando[2]}" 
				;;

				'creditos')
					bash $ubi/creditos.sh
				;;

				'salir')
						clear
						exit
				;;

				'exit')
						echo "Esriba salir para abandonar PROLIN."
				;;

				*)
						command ${comando[@]}
				;;
			
			esac
   	 	done
	else
		echo -e "$NEGRITA Usuario o contraseña incorrecto.\n $RESET $ROJO $NEGRITA $FONDOBLA $SUBRAYADO Ejecute de nuevo. $RESET"
	fi 