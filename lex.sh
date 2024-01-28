#!/bin/bash

# Your three commands here
if [ -e "lex.yy.c" ]; then
    # If lex.yy.c exists, remove it
    rm lex.yy.c
fi

if [ -e "./a.out" ]; then
    # If ./a.out exists, remove it
    rm ./a.out
fi
    if [ "$#" -eq 1 ]; then
    filename="$1"
    # Check if the file exists
    if [ -f "$filename" ]; then
        # Run lex with the content of the specified file
        lex "$filename"
    else
        echo "Error: File $filename not found."
        exit 1
    fi
else
    echo "Usage: $0 <filename>"
    exit 1
fi

gcc lex.yy.c
./a.out
