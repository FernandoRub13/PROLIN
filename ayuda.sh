#!/bin/bash
#Este script despliega una ayuda para el usuario
#Se utiliza el etiquetdo \e[1;100;33m donde 
#"\e[" indica el inicio de etiquetado,
#"1" represnta letras impresas en negritas,
#"100" color de remarcado de texto, 
#"Colo del texto", 
echo -e "\e[1;100;33m Terminal PROLINv1.0"
echo ""
echo "Has accedido a la ayuda de PROLINv1.0 :)"
echo "A continuacion te enlistaré los comandos disponibles"
echo " los cuales pueden ser ejecutados por esta terminal;"
echo " el comando a utilizar se introduce en la terminal"
echo " omitiendo las comillas simples."
echo ""
echo "Comando 'arbol': simula la salida del comando tree, es decir,"
echo " muestra de manera grafica la jerarquia de un directorio que"
echo " hayas introducido como paramtero. Si al comando no se le"
echo " especifica directorio, el comando se ejecuta sobre el directorio actual."
echo " "
echo "Comando 'ayuda': despliega al informacion acerca de los comandos "
echo " implementados en la terminal (Comando actual)."
echo " "
echo "Comando 'infosis': despliega informacion sobre el sistema donde"
echo " se esta ejecutando la terminal. Debe mostrar la informacion de"
echo " que usuarios se encuentran logeados, la memoria ram, la"
echo " arquitectura, y la version del sistema operativo."
echo ""
echo "Comando 'fecha1': despliega la fecha."
echo ""
echo "Comando 'fecha2': despliega la fecha en un formato distinto."
echo ""
echo "Comando 'hora1': despliega la hora."
echo ""
echo "Comando 'hora2': despliega la hora en un formato distinto."
echo ""
echo "Comando 'prebeplayer': reproductor el cual te ayuda a navegar"
echo " sobre la biblioteca musical,"
echo " mustra el status actual de la reproducción."
echo ""
echo "Comando 'gato': despliega el juego de gato!"
echo ""
echo "Comando 'buscar': busca un archivo en particular en el directorio especificado"
echo "Modo de empleo: 'buscar [ARCHIVO] [RUTA] (Sin corchetes)"
echo -e "Comando 'ahorcado': despliega el juego del ahorcado! \e[0m"
echo ""

#Se utiliza el etiquetdo \e[0m para terminar el etiquetado de color