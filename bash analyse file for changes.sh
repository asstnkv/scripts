#SCRIPT FOR ANALYSE A TEXT FILE

# /bin/bash
changepwd=$(pwd)
script=$( dirname -- "$0"; )
filelog="$changepwd"'/files.log'
cd /

read filename

if ! [[ -f "$filename" ]]; then
        echo "error2"
        exit 1
fi


if ! [[ -z "$filename" ]]; then
        echo "error2"
        exit 1
fi

#кол-во записей
k=$(cat $filename | wc -l | awk '{print $1}')

#кол-во уникальных файлов
unfiles=$(cut -d'-' -f1 $filename | sort | uniq -c | wc -l)
unhach=$(cut -d'-' -f6 $filename | sort | uniq -c | wc -l)


#кол-во изменений которые привели к изменению hash файла

echo "$k $unfiles $unhach"



cd "$changepwd"
cd "$script"
