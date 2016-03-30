#include <stdio.h>
#include <string.h>
#include <dlfcn.h>

int have_arg(int argc, char ** argv, const char * arg)
{
    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], arg)) {
            return 1;
        }
    }
    return 0;
}

int main(int argc, char ** argv)
{
    /* This has a RUNPATH pointing to ".", so loads that copy of
     * libncurses
     */
    fprintf(stderr, "Loading A\n");
    void * A = dlopen("./A.so", RTLD_LOCAL | RTLD_LAZY);
    /* Close A.so causes B.so to go back to finding the system libncurses */
    if (have_arg(argc, argv, "--close-A")) {
        dlclose(A);
    }

    /* This has no RUNPATH, so according to the docs it should load the system
     * libncurses from /lib -- but if A is open and not yet closed then it
     * doesn't, it loads the version in "."
     */
    fprintf(stderr, "Loading B\n");
    void * B = dlopen("./B.so", RTLD_LOCAL | RTLD_LAZY);

    /* Likewise: according to the docs this dlopen() should load the system
     * library from /lib -- but if A is open and not yet closed then it
     * doesn't, it loads the version in "."
     */
    fprintf(stderr, "Loading libncurses.so.5\n");
    void * ncurses = dlopen("libncurses.so.5", RTLD_LOCAL | RTLD_LAZY);
}
