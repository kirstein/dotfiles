#!/bin/bash
while [[ $# -gt 1 ]]
do
  key="$1"

  case $key in
    -f)
      FILE="$2"
      shift # past argument
      ;;
    --append)
      APPEND="$2"
      shift # past argument
      ;;
  esac
  shift # past argument or value
done

echo $@
echo "loading $FILE"

jsctags -f - $APPEND >> $FILE
