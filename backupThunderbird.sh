#!/bin/bash

# -> AUTOR: Ricardo Assis
# -> Criação: 30/09/2018
#
#



PROCESSO=$( ps axu |grep thunderbird | cut -c10-14 | head -n 1 ) # Captura o número do processo do Thunderbird



# -> Declaração de funções

# -> Verifica se o processo do Thunderbird está up e derruba se tiver.
verifica () { 
	if [ $(ps axu | grep thunderbird | wc -l) -eq 2 ]
	then
		kill $PROCESSO > /dev/null
	fi
	sleep 5
}


compactadir () {					# -> Inicia a compactação do diretório a ser backpeado				
#	echo "Inicando compactação dos arquivos"
	sleep 3
	local DATE=$(date +%F)
	tar -cvpzf /tmp/thunder$DATE.tar.gz /home/ricardo/.thunderbird > /dev/null
	ARQUIVO="thunder$DATE.tar.gz"
#	echo "========================================================="
#	echo "compactado com sucesso"
}



montaPasta () { 					# -> Inicia a montagem do diretório da rede
#	echo "Montando Pasta"
        mount -t cifs -o username=ricardo.assis@sfti.local -o password=mudar@123 //192.168.2.2/corporativo/Backups/Ricardo /media/Backup
                echo "Diretório montado com sucesso"
		mv /tmp/$ARQUIVO /media/Backup


}

desmonta(){						# -> Desmonta a unidade de rede
#        echo "Desmontando unidade de rede"
        umount /media/Backup
        sleep 5
        echo "Unidade desmontada"


}


# -> Declaração de comandos

#echo "Iniciando ṕrocesso de Backup..."

verifica
compactadir
montaPasta
desmonta
poweroff

