#! /bin/bash
#Menú de opciones

option=0

                            #funcion de instalacion de Postgres
instalar_postgres () {
    echo -e "\nVerificando postgres..."
    verificacion=$(which psql)                  #busca la palabra psql, si la encuentra devuelve resultado 0, sino la encuentra devuelve 1
    if [[ $? -eq 0 ]]; then                     #condicional que hace que el Valor devuelto por el último comando invocado se compare igual a 0, si da 0 es que ya esta instalado postgres, sino da 0 comienza a instalar
        echo -e "\nPostgres se encuentra instalado"
        else
        read -s -p "Primero ingresar contraseña de sudo: " contraseñaSudo
        read -s -p "Segundo ingresar contraseña a utilizar en postgres: " contraseñaPostgres
        echo "$contraseñaSudo" | sudo -S apt-get update
        echo "$contraseñaSudo" | sudo -S apt-get install postgresql postgresql-contrib
      #ESTOS COMANDOS A CONTINUACION SON PARA QUE EMPIECE A CORRER EL PROGRAMA POSTGRES
      #  sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD ´{$contraseñaPostgres}´"
      #  echo "$contraseñaSudo" | sudo -S systemctl enable postgresql.service 
      #  echo "$contraseñaSudo" | sudo -S systemctl start postgresql.service 
    fi
read -n1 -s -r -p "Para continuar presione cualquier tecla..."
}

                            #funcion para desinstalar Postgres
desinstalar_postgres () {
    verificacion=$(which psql)                  #busca la palabra psql, si la encuentra devuelve resultado 0, sino la encuentra devuelve 1
    if [[ $? -ne 0 ]]; then                     #condicional que hace que el Valor devuelto por el último comando invocado se compare igual a 0, si da 0 es que ya esta instalado postgres, sino da 0 comienza a instalar
       echo -e "\nPostgres NO se encuentra en el sistema"
     else
                                                 #  ESTE COMANDO ES PARA CUANDO YA ESTA CORRIENDO POSTGRES EN EL SISTEMA, SINO SE PASA A DESINSTALAR DIRECTAMENTE
                                                 #  echo "$contraseñaSudo" | sudo -S systemctl stop postgresql.service 

        echo "$contraseñaSudo" | sudo -S apt-get --purge remove postgresql\*
        echo "$contraseñaSudo" | sudo -S rm -r /etc/postgresql
        echo "$contraseñaSudo" | sudo -S rm -r /etc/postgresql-common
        echo "$contraseñaSudo" | sudo -S rm -r /var/lib/postgresql
        echo "$contraseñaSudo" | sudo -S userdel -r postgres #elimina usuarios creados en postgres
        echo "$contraseñaSudo" | sudo -S groupdel  postgresql #elimina grupso creados en postgres
        -e "\nPostgres NO se encuentra en el sistema"
    fi
}

                            #funcion para generar respaldo
generar_respaldo () {
    echo -e "\nGenerando respaldo..."
    echo "Directorio del backup: "$1
}
                            #funcion para restaurar el respaldo generado
restaurar_respaldo () {
    echo -e "\nRestaurando respaldo..."
    echo "Directorio del respaldo: " $1
}

while :
    do

                            #limpiar pantalla   
    clear
    
                            #opciones del menu
    echo "-----------------------------------------"
    echo "PGUTIL - PROGRAMA DE UTILIDAD DE POSTGRES"
    echo "-----------------------------------------"
    echo "              MENU PRINCIPAL             "
    echo "-----------------------------------------"
    echo "1.- Instalar programa"
    echo "2.- Desinstalar programa"
    echo "3.- Hacer respaldo"
    echo "4.- Restaurar respaldo"
    echo "5.- Salir del programa"

                            #capturar informacion del usuario
    read -e -n1 -p "INGRESE UNA OPCION [1-5]: " option

                            #relacionar la informacion ingresada por el usuario con las opciones dadas"
    case $option in
        1) instalar_postgres 
            sleep 1;;
        2) desinstalar_postgres
            sleep 1;;
        3)  read -p "Indique directorio de backup: " directorioBackup
            generar_respaldo $directorioBackup
            sleep 1;;
        4)  read -p "Indique directorio de respaldo a restaurar: " directorioRespaldo
            restaurar_respaldo $directorioRespaldo
            sleep 1;;
        5) echo -e "\nSalir..."
            exit
    esac
done
