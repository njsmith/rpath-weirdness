#!/bin/bash

cp /lib/x86_64-linux-gnu/libncurses.so.5 .

gcc main.c -o main -ldl
gcc -fPIC -shared lib.c  -Wl,-rpath='$ORIGIN' -lncurses -o A.so
gcc -fPIC -shared lib.c -lncurses -o B.so
