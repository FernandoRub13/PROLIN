#!/bin/bash

ruta=$@
echo $ruta
ruta_cancion=${ruta:12}

if [[ "$ruta_cancion" == *".mp3"* ]]; then    
  
  command mpg123 "$ruta_cancion"
else
  command mpg123 "$ruta_cancion"/*.mp3
fi




