#!/bin/bash

BKUP_DIR=~/.bkups

[ $# -lt 1 ] && { echo USAGE `basename $0` file..; exit; }
[ ! -d $BKUP_DIR ] && { echo ERROR $BKUP_DIR NOT EXIST OR NOT A DIRECTORY; exit; }

doit()
{
    [ -f "$1" ] && {
        [ -r "$1" ] && {
            NOW=`date +%Y-%m%d-%H%M%S-%N`
            BASEFN=`basename "$1"`
            SAVEME="$BKUP_DIR/$BASEFN.$NOW"
            cp -ip "$1" "$SAVEME"
            sha256sum "$1"
            sha256sum "$SAVEME"
        } || {
            echo $1 is not readable
            /bin/ls -l "$1"
        }
    } || {
        echo $1 is not a regular file
        file "$1"
    }
}

while [ $# -gt 0 ]
do
    doit $1 | cut -c53-
    shift
done

