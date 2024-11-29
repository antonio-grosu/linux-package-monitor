#!/bin/bash

data_dir="data"

# Meniul principal
echo "Select an option:"
echo "1. The list of currently installed packages and the date of the last installation"
echo "2. The list of removed packages and the date of the last removal"
echo "3. The history of a software package"
echo "4. The list of packages installed/removed within a time interval"
read -p "Choose an option: " opt

case $opt in

    1)
        echo "The list of currently installed packages and the date of the last installation:"
        for dir in "$data_dir"/*; do
            grep "installed" "$dir/history.txt" | echo "$dir" | awk -F/ '{ print $NF }'
        done
        ;;
    2)
        echo "The list of removed packages and the date of the last removal:"
          for dir in "$data_dir"/*; do
            if grep -q "removed" "$dir/history.txt" ; then
                while read -r line; do
                    isRemoved=$(echo "$line" | awk '{ print $3 }')
                    if [[ "$isRemoved" == "removed" ]]; then
                        echo "$(echo "$dir" | awk -F/ '{ print $NF }') => Last Removal : $(echo "$line" | awk '{print $1, $2}')"

                    fi
                done < "$dir/history.txt"
            fi
            done
       ;;
    3)
        read -p "Insert the name of the package: " package
        if [[ -d "$data_dir/$package" ]]; then
            echo "History of $package:"
            cat "$data_dir/$package/history.txt"
        else
            echo "The package $package doesn't exist."
        fi
       ;;
         
    4)
        read -p "Insert the start time (YYYY-MM-DD HH:MM:SS): " start_time
    read -p "Insert the end time (YYYY-MM-DD HH:MM:SS): " end_time

    echo "Packages modified between $start_time and $end_time are:"

    for dir in "$data_dir"/*; do
        if [[ -d "$dir" ]]; then
        history_file="$dir/history.txt"
        package_name=$(basename "$dir") 

        if [[ -f "$history_file" ]]; then
            
            awk -v start="$start_time" -v end="$end_time" '
            {
    # Combina data si ora
                timestamp = $1 " " $2; 
                if (timestamp >= start && timestamp <= end) {
                    found = 1;
                    }
            }
            END {
                if (found) {
                    print "'"$package_name"'"; 
                }
            }
            ' "$history_file"
                fi
        fi
    done
esac
