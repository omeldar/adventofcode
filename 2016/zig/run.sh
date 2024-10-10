#!/bin/sh

day=$1

if [ -z "$day" ]; then
  echo "Usage: ./run.sh day01"
  exit 1
fi

./zig-out/bin/$day
