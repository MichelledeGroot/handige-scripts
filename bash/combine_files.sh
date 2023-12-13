#!/usr/bin/env bash

# Script to combine multiple files retaining the header of the first file
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# constants
myname="`basename $0`"
# check input for less than two
if [[ $# -lt 2 ]]; then
    echo "$myname: Error, number of files supplied is "$#"."
    echo "         Please supply 2 or more files."
    echo ""
    echo "Usage: $myname file1 file2 ... "
    echo ""
    exit 1
else
    # arguments
    FILE1="$1"
    ALL_FILES="${@}"
    FIRST=1
    # check if compressed or note
    for f in $ALL_FILES;
    do
        if (file "${FILE1}" | grep -q compressed); then 
            # define the type of cat to use
            cattype=zcat
        else
            cattype=cat
        fi
        # concatenate the files
        if [ "$FIRST" ]; then
            $cattype "$f"
            # unset FIRST
            FIRST=
        else
            $cattype "$f"| tail -n +2
        fi
    done 
fi
# good exit
exit 0
