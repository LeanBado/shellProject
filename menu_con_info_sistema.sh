#!/bin/bash
#Menu de prueba

option=0

while :
do
    clear
    #OPCIONES DEL MENU
    echo "-------------------------------------"
    echo "----------                -----------"
    echo "          MENU DEL SISTEMA           "
    echo "----------                -----------"
    echo "-------------------------------------"
    echo "1.- Procesos actuales----------------"
    echo "2.- Memoria disponible---------------"
    echo "3.- Espacio en disco-----------------"
    echo "4.- Información de red---------------"
    echo "5.- Variables de entorno configuradas"
    echo "6.- Información programa-------------"
    echo "7.- Backup información---------------"
    echo "8.- Eliminar backup------------------"
    echo "9.- -------------SALIR---------------"

    #INFORMACION DEL USUARIO
    read -n1 -p "Ingrese una opcion [1-8]: " option
    
    #RELACIONAR INFORMACION INGRESADA CON OPCION DEL MENU
    case $option in
        1) echo -e "\nMostrando procesos actuales..."
            ps aux
            sleep 2;;
        2) echo -e "\nMostrando memoria disponible..."
            free -h
            sleep 2;;
        3) echo -e "\nMostrando espacio en disco..."
            df -h
            sleep 2;;
        4) echo -e "\nMostrando información de red..."
            ifconfig
            sleep 2;;
        5) echo -e "\nMostrando variables de entorno configuradas..."
            env
            sleep 2;;
        6) echo -e "\nMostrando información del programa..."
            var1=$(users)
            var2=$(pwd)
            echo -e "\nLo ejecuta el usuario: $var1"
            echo -e "\nEn la locacion $var2"
            sleep 2;;
        7) echo -e "\nBackup información..."
            tar -cvzf backup.tar.gz /home/lean/shellCourse
            sleep 2;;
        8) echo -e "\nEliminando backup..."
            rm backup.tar.gz
            sleep 2;;
        9) echo -e "\nSALIR..."
            exit;;
     esac 
done
        
        
       
