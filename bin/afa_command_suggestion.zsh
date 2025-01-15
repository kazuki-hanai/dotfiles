#!/bin/zsh

prompt_=""

while getopts p: OPT
do
  case $OPT in
    "p" ) prompt_="$OPTARG";;
    *) echo "Error: Invalid option." >&2; exit 1;;
  esac
done

shift `expr $OPTIND - 1`

suggested_command=$(afa new -script -j command_suggestion -u command_suggestion -p "$prompt_")
if [ $? -ne 0 ]; then
  echo "Error: Failed to generate suggested command." >&2
  exit 1
fi

command_new=$(printf "%s" "$suggested_command" | jq -r '.suggested_command')
if [ $? -ne 0 ]; then
  echo "Error: No suggested command received." >&2
  exit 1
fi

echo "$command_new"
