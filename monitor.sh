#!/bin/bash

#create the directory if it doesn't exist
fisier="data"
x="0"
for entry in `ls $1`;do
    if [ $entry == $fisier ]; then
        x="1"
    fi
done
if [ "$x" -eq "0" ]; then
    mkdir data
fi

# what does awk do
# 1st position => date
# 2nd position => time
# 3rd position => the word "status"
# 4th position => the status of the package
# 5th position => the name of the package

logfile="/var/log/dpkg.log"
ct=0
while read line
do

    if [[ $line == *"installed"* ]];then
    package=$(echo "$line" | awk '{print $5}')
    if [[ ! -d "data/$package" ]]; then
        mkdir data/$package && echo "The directory $package has been created." && touch data/$package/history.txt && echo "Created the history.txt for the ${packages} package."
    fi
    echo "$line" | awk '{print $1,$2,$4}' > data/$package/history.txt 
    elif [[ $line == *"removed"* ]]; then
    package=$(echo "$line" | awk '{print $5}')
    
    if [[ ! -d "data/$package" ]]; then
        mkdir data/$package && echo "The directory $package has been created." && touch data/$package/history.txt && echo "Created the history.txt for the ${packages} package."
    fi

    fi
done < $logfile

echo "The Monitor script has been finalized"