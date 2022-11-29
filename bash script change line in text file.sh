#SCRIPT FOR CHANGE LINE IN TEXT FILE AND LOGG CHANGES
# /bin/bash
changepwd=$(pwd)
script=$( dirname -- "$0"; )
filelog="$changepwd"'/files.log'
cd /

read filename
read string1
read string2

if [[ "$filename" == "" || "$string1" == "" ]];
then
echo "error"
fi


if ! [[ -f "$filename" ]]; then
        echo "error2"
        exit 1
fi



filesize=$(wc -c $filename | awk '{print $1}')
filesum=$(shasum -a 256 $filename | awk '{print$1;}')

sed -i '' 's/'$string1'/'$string2'/g' $filename

log="$filename - $filesize - $(date -r "$filename" "+%Y-%m-%d %H:%M") -  $filesum -  sha256"

cd "$changepwd"
cd "$script"
echo "$log" >> "$filelog"

