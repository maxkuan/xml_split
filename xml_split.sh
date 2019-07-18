#!/bin/bash

start='^<us-patent-grant'
end='^</us-patent-grant>$'
result_arr=()

count=0

POSITIONAL=()
while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        -c|--count)
        NEED_COUNT=true
        shift # past argument
        ;;
        -f|--filename)
        FILENAME="$2"
        shift # past argument
        shift # past value
        ;;
        -s|--search)
        SEARCH_NO="$2"
        ;;
        -o|--output)
        OUTPUT_FOLDER="$2"
        shift
        shift
        ;;
        *)
        POSITIONAL+=("$1") 
        shift # past argument
        ;;
    esac
done
    set -- "${POSITIONAL[@]}" # restore positional parameters

# check filename isn't empty
if test -z "$FILENAME" 
then
    echo "Filename is empty"
    exit 0
else
    exec < $FILENAME
fi


while IFS='' read -r line || [[ -n "$line" ]]; do
    ((count++))
    if [[ $line =~ $start ]]; then
        result_arr+=( "$count" )
        # echo $count $line
    fi
    if [[ $line =~ $end ]]; then
        result_arr+=( "$count" )
        # echo $count $line
    fi
done < $FILENAME

if ! (test -z "$OUTPUT_FOLDER"); then
    if [ ! -L "$OUTPUT_FOLDER" ]; then
        mkdir -p -- "$OUTPUT_FOLDER"
    fi
    for ((i=0; i < ${#result_arr[@]}; i+=2))
    do
        echo ${result_arr[$i]} ${result_arr[$i+1]}
        # filename = 
        sed -n "${result_arr[$i]},${result_arr[$i+1]}p" $FILENAME > "./$OUTPUT_FOLDER/$i.xml"
    done
fi

if $NEED_COUNT; then
    echo "patents in $FILENAME: $((${#result_arr[@]}/2))"
fi