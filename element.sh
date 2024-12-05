#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo -e  "Please provide an element as an argument."
fi

ELEMENT_INPUT=$1



echo $RESULT