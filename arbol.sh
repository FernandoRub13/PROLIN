#!/bin/bash
#Este script simula el funcionamiento del comando tree, es decir,
#imprime los directorios, archivos de forma recursiva a partir
#del directorio actual de trabajo

directorio_especifico=$1
posicion_actual=0
ubicacion_actual="/home/$USER"


if [ -z "$directorio_especifico" ]; then #Valida que el argumento no sea la cadena vacia, -z devuelve true si la variable
  echo "Arbol se ejecutará sobre la carpeta actual." #no está definida o es la cadena vacia.
else
  if [[ -d "$ubicacion_actual" ]]; then
  #echo "$USER tiene directorio propio."
    echo ""
  else
    echo "El directorio /home/$USER no existe. Usará como directorio principal, la carpeta del usuario que ejecutó PROLIN."
    ubicacion_actual=/home/
  fi
fi
#Esta función es la principal encargada de llevar la lógica 
#ya que revisa y compara los archivos de un directorio
#en específico o por defecto

directorio_recursivo()
{
  #Este for acota las iteraciones a todos los 
  #directorios hijos y ficheros del directorio actual
  for archivo in "$ubicacion_actual"/*; do

    #Este if entra cuando estamos trabajando con un directorio
    if [ -d "${archivo}" ]; then
      
     #Extrae el nombre del archivo y su extension y lo compara con el
     #directorio o fichero actual
      if [ "${archivo##*/}" = "${directorio_especifico}" ]; then
        #Asigna ubicacion a la del directorio
        ubicacion_actual=${ubicacion_actual}/${archivo##*/}
        cd "$ubicacion_actual"
        #Aqui entra en juego la recursividad, al buscar
        #el directorio actual
        arbol 0 "$ubicacion_actual" 1
        cd ..
        #Actualiza el directorio acutal depues de
        #llamar a la funcion arbol
        ubicacion_actual=$(pwd)
        return
      fi
      posicion_actual=$(($1+4));
      ubicacion_actual=${ubicacion_actual}/${archivo##*/}
      cd "$ubicacion_actual"
      directorio_recursivo $posicion_actual "$ubicacion_actual" 1
      cd ..
      ubicacion_actual=$(pwd)
    fi
  done
}

#Aqui es la funcion donde se la da formato a la impresion de 
#la jerarquía de ficheros de linux
arbol()
{
  # Declaramos la variable del contador y de rama actuales
  contador_de_posicion=0
  rama_actual=0

  #Se imprime el directorio actual en caso de no existir
  if [ $1 -eq 0 ];then
    printf "   \e[1;37m.\e[0m\n"
    printf "   \e[1;37m${directorio_especifico}\e[0m\n"
  fi

  #Imprimimos los archivos de la ruta actual con su formato
  #Se le da color, posicion y aspecto
  for archivo in "$ubicacion_actual"/*; do

    #Imprimimos las ramas en caso de existir
    while [ $contador_de_posicion -le $1 ]; do
      if [ $contador_de_posicion -eq 0 ]; then
        printf "   |"
      fi
      if [ $rama_actual -eq 4 ]; then
        printf "|"
        rama_actual=0
      fi
      printf " "

      rama_actual=$(($rama_actual+1))
      contador_de_posicion=$((contador_de_posicion+1))
    done
    rama_actual=0

    #Impresión de formato, color jerarquía y disposicion
    #de los directorios 
    if [ -d "${archivo}" ]; then
      printf "__ \e[1;33m${archivo##*/}\e[0m \n"
      posicion_actual=$(($1+4));
      ubicacion_actual=${ubicacion_actual}/${archivo##*/}
      cd "$ubicacion_actual"
      arbol $posicion_actual "$ubicacion_actual" 1
      cd ..
      ubicacion_actual=$(pwd)

    #Impresión de formato, color jerarquía y disposicion
    #de los ejecutables
    elif [ -x "$archivo" ]; then
      printf "__ \e[1;34m${archivo##*/}\e[0m \n"

   #Impresión de formato, color jerarquía y disposicion
    #de los fichero normales
    elif [ -f "$archivo" ]; then
      printf "__ ${archivo##*/} \n"

    #Impresión de formato, color jerarquía y disposicion
    #de los fichero con extension .mp2
    elif [ "${archivo##*.}" = "mp2" ]; then
      printf "__ \e[1;35m${archivo##*/}\e[0m \n"

    #Impresión de formato, color jerarquía y disposicion
    #de los fichero con extension .mp3
    elif [ "${archivo##*.}" = "mp3" ]; then
      printf "__ \e[1;32m${archivo##*/}\e[0m \n"

    #Impresión de formato, color jerarquía y disposicion
    #de los fichero con extension .mp4
    elif [ "${archivo##*.}" = "mp4" ];then
      printf "__ \e[1;36m${archivo##*/}\e[0m \n"

    
    else
      #En caso de estar vacío
      printf "    (Vacio)\n"

    fi

    contador_de_posicion=0
  done
}

##Aquí es la implementación de funciones principalmente donde
#se van a llamar a las funciones, es aquí donde verificamos 
#las banderas, y si no tiene se procede a realizarse sobre
#el directorio actual
if [ -z "$directorio_especifico" ]; then
  ubicacion_actual=$(pwd);
  directorio_especifico="${ubicacion_actual##*/}"
  #printf "Nulo\n"
  arbol 0 "${ubicacion_actual}" 0
else
  #printf "${ubicacion_actual}\n"
  directorio_recursivo 0 "${ubicact}" 0
fi 
   


