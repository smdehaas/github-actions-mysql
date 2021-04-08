#!/bin/sh

cmd="docker run --rm"

if [ -n "$INPUT_ROOTPASSWORD" ]; then
  cmd="$cmd -e MYSQL_ROOT_PASSWORD=$INPUT_ROOTPASSWORD"
fi

if [ -n "$INPUT_DATABASE" ]; then
  cmd="$cmd -e MYSQL_DATABASE=$INPUT_DATABASE"
fi

cmd="$cmd -d -p $INPUT_HOSTPORT:$INPUT_CONTAINERPORT"
cmd="$cmd --hostname=mysql"
cmd="$cmd --name=mysql"
cmd="$cmd mysql:$INPUT_VERSION"
cmd="$cmd --port=$INPUT_CONTAINERPORT"
cmd="$cmd --character-set-server=$INPUT_CHARACTERSET"
cmd="$cmd --collation-server=$INPUT_COLLATION"
cmd="$cmd --sql-mode=NO_ENGINE_SUBSTITUTION"
cmd="$cmd --default-authentication-plugin=mysql_native_password"
cmd="$cmd -e ALLOW_EMPTY_PASSWORD=yes"
echo "CMD: $cmd"

sh -c "$cmd"
