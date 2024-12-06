#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]; then
    ARG=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE atomic_number = $1")
  elif [[ $1 =~ ^[A-Za-z]+$ ]]; then
    ARG=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE symbol = '$1' OR name ILIKE '$1'")
  else
    echo "I could not find that element in the database."
    exit
  fi

  if [[ -z $ARG ]]; then
    echo "I could not find that element in the database."
  else
    IFS="|" read -r ATOMIC_NUMBER SYMBOL NAME <<< "$ARG"

  
    PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM properties p INNER JOIN types t ON p.type_id = t.type_id WHERE p.atomic_number = $ATOMIC_NUMBER")
    IFS="|" read -r MASS MELTING_POINT BOILING_POINT TYPE <<< "$PROPERTIES"

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi
