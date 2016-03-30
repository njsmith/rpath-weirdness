Simple example to demonstrate strange aspect of glibc library lookup

See: https://sourceware.org/bugzilla/show_bug.cgi?id=19884

Usage:
```
$ ./build.sh
$ LD_DEBUG=libs,scopes ./main
```
