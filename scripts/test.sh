#!/usr/local/bin/zsh

if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  exit 1
fi

cd `dirname $0`
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d @$1 $2

