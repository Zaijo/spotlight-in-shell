#!/bin/bash


trap my_clear SIGTSTP

word=
function my_clear {
	word=${word%?}
	search
}

function search {
    clear
    echo "Searching for: $word"           
    if [ -n "$word" ]; then
        grep --color=always "${word}" ~/hosts | head -n 10
    fi
}

my_clear

while true; do
    read -sn1 input
    word=${word}${input}
    search
done

