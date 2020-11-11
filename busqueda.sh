#!/bin/bash
#Proyecto Linux: Prebelin
#Formato de ejecución : ./busqueda.sh nomb_archivo nomb_directorio
## Como argumentos, primero recibe el nombre del archivo seguido del directorio

arch=$1
dir=$2
directorio="/home/$USER";
if [ -z "$arch" ] || [ -z "$dir" ]; then #Valida que los argumentos no sean la cadena vacia, -z devuelve true si la variable
	echo "Argumentos insuficientes. Escriba ayuda para conocer la sintaxis." #no está definida o es la cadena vacia.
	exit
fi
## Valida que el directorio del usuario exista, de lo contraroio, realizará la busqueda a partir de la carpeta /home
if [[ -d "$directorio" ]]; then
	#echo "$USER tiene directorio propio."
	echo ""
else
	echo "El directorio /home/$USER no existe. Usará como punto de partida, la carpeta /home"
	directorio=/home/
fi

pos=0
ubicFin="";

#busca el archivo en el directorio, si lo encuentra duevuelve 1, sino, continua con los demás 
fileSearch()
{
  
  for archivo in "$directorio"/*; do
    if [ "${archivo##*/}" = "${arch}" ]; then
      #printf "Encontre a $arch\n"
      ubicFin="${archivo}"
      #printf "${ubicFin}\n"
      return $((1))
    fi
  done
}

#Busca el directorio, si coincide con el ingresado, llama a la función para buscar el archivo especificado
dirSearch()
{
  for archivo in "$directorio"/*; do

    #-d para directorios
    if [ -d "${archivo}" ]; then
      if [ "${archivo##*/}" = "${dir}" ]; then
        pos=$(($1+4));
        directorio=${directorio}/${archivo##*/}
        cd "$directorio"
        fileSearch $pos "$directorio" 1
        # Salimos de la búsqueda si encontramos al archivo dentro del directorio
        # $? toma el estatus de lo que regresa fileSearch
        if [ "$?" -eq 1 ]; then
          cd ..
          directorio=$(pwd)
          return
        else
          echo "${arch} no existe en el directorio indicado: ${dir}"
          cd ..
          directorio=$(pwd)
          exit
        fi
        return
      fi
      pos=$(($1+4));
      directorio=${directorio}/${archivo##*/}
      cd "$directorio"
      dirSearch $pos "$directorio" 1
      cd ..
      directorio=$(pwd)
    fi
  done
}

dirSearch 0 "$directorio" 0 #llamamos a la función dirSearch
echo -e "Ubicación del archivo: \e[1;96;3m \e[41m ${ubicFin} \e[0m"