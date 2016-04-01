#include <stdio.h>
#include <ncurses.h>

void f()
{
    /* Make some reference to an ncurses function, to force our library to
     * include libncurses symbol versioning information -- this makes the
     * example more realistic, and triggers a bug in patchelf 0.9.
     */
    fprintf(stderr, "Hello from library; initscr is at %p\n", &initscr);
}
