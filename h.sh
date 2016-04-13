#!/bin/bash

trap backspace SIGTSTP

debug=false
if [ -n "$1" ]; then
    echo "Running in DEBUG mode"
    debug=true
fi

word=
function backspace {
	word=${word%?}
	search
}

function search {
    clear
    echo "Searching for: $word"           
    if [ "$debug" = true ]; then
        echo "Hexdump of the input word follows: "
        echo "$word" | hexdump -c
	echo "Ord of last letter is" "$input_ord"
    fi
    if [ -n "$word" ]; then
        grep --color=always "${word}" ~/hosts | head -n 10
    fi
}

function ord {
    printf %x "'$1"
}

backspace

while true; do
    read -sn1 input
    input_ord=`ord "$input"`
    if [ "$input_ord" == "7f" ]; then
    	backspace
    else
        word=${word}${input}
        search
    fi
done

