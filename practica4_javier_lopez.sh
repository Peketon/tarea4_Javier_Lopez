#!/bin/bash

usuario=$(whoami)

echo $usuario

incrementar=0



if [[ $usuario == "root" ]]

then

	while IFS=":" read nome instalar;

	do

		arraynome[${incrementar}]=$nome

		arrayinstalar[${incrementar}]=$instalar

	if [[ ${arrayinstalar[$incrementar]} == "remove" || ${arrayinstalar[$incrementar]} == "r" ]];

	then

		eliminar=$(whereis ${arraynome[$incrementar]} | grep bin | wc -l)

		if [[ $eliminar == 1 ]];

		then

			sudo apt remove ${arraynome[$incrementar]}

			sudo apt purge ${arraynome[$incrementar]}

		fi

	elif [[ ${arrayinstalar[$incrementar]} == "add" || ${arrayinstalar[$incrementar]} == "a" ]];

	then

            descargar=$(whereis ${arrayinstalar[$incrementar]} | grep bin | wc -l)

            if [[ $descargar == 0 ]];

            then

                if [[ ${arraynome[$incrementar]} == "google-chrome" ]];

                then 

                    wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 2>/dev/null

                    apt-get install libappindicator1

                    sudo dpkg -i google-chrome-stable_current_amd64.deb

                elif [[ ${arraynome[$incrementar]} == "atom" ]];

                then

                    sudo apt install -y atom4

                elif [[ ${arraynome[$incrementar]} == "gdebi" ]];

                then

                    sudo apt install gdebi

                fi

                sudo apt install -y ${arraynome[$incrementar]}

		elif [[ ${arraynome[$incrementar]} == "brave" ]];

		then

			sudo snap install brave

            fi

	else

	   estados=$(whereis ${arraynome[$incrementar]} | grep bin | wc -l)

            if [[ $estados -eq 0 ]];

            then

                echo "paquete no instalado" ${arraynome[$incrementar]}

            else

                echo "paquete instalado" ${arraynome[$incrementar]}

            fi

       fi

       (( incrementar++ ))

    done < paquetes.txt

else

    echo "Non tes permisos"

fi
