#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]; then
    ARG=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  elif [[ $1 =~ ^[A-Za-z]+$ ]]; then
    # Check if it's a symbol (one or two characters)
    ARG=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1' OR name ILIKE '$1'")
  else
    echo "I could not find that element in the database."
  fi

  if [[ -z $ARG ]]; then
    echo "I could not find that element in the database."
  else
    # Your code for handling valid ARG should be here
    echo "Found element: $ARG"
  fi
fi
