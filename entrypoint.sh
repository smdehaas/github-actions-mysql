#!/bin/sh

cmd="docker run --rm"

if [ -n "$INPUT_ROOTPASSWORD" ]; then
  cmd="$cmd -e MYSQL_ROOT_PASSWORD=$INPUT_ROOTPASSWORD"
elif [ -n "$INPUT_USER" ] && [ -z "$INPUT_PASSWORD" ]; then
  echo "If you provide a `user` then the `password` should not be empty. Exiting...."
  exit 1
elif [ -n "$INPUT_USER" ] && [ -n "$INPUT_PASSWORD" ]; then
  cmd="$cmd -e MYSQL_RANDOM_ROOT_PASSWORD=true -e MYSQL_USER=$INPUT_USER -e MYSQL_PASSWORD=$INPUT_PASSWORD"
else
  echo "No credentials for root or user have been provided. Exiting...."
  exit 1
fi

if [ -n "$INPUT_DATABASE" ]; then
  cmd="$cmd -e MYSQL_DATABASE=$INPUT_DATABASE"
fi

cmd="$cmd -d -p $INPUT_HOSTPORT:$INPUT_CONTAINERPORT"
#cmd="$cmd --hostname=$INPUT_HOSTNAME"
#cmd="$cmd --name=mysql"
cmd="$cmd mysql:$INPUT_VERSION"
cmd="$cmd --port=$INPUT_CONTAINERPORT"
cmd="$cmd --character-set-server=$INPUT_CHARACTERSET"
cmd="$cmd --collation-server=$INPUT_COLLATION"
cmd="$cmd --sql-mode=NO_ENGINE_SUBSTITUTION"

echo "CMD: $cmd"

sh -c "$cmd"