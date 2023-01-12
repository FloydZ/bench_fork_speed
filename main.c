#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

// global benchmark values
#define RUNS 1

size_t counter = 0;
uint64_t start = 0;
uint64_t v[RUNS]; //total race cond. but who cares

//taken from DJB, Make it someday more
long long cycles(void)
{
    unsigned long long result;
    asm volatile(".byte 15;.byte 49;shlq $32,%%rdx;orq %%rdx,%%rax"
    : "=a" (result) ::  "%rdx");
    return result;
}


typedef void (*f)(void);
void _fork(f);

void function(){
    v[counter] =  cycles()- start;
    printf("Child: Timing; %" PRIu64 "\n", v[counter]);

    counter += 1;
}

int main() {
    printf("Hello, World!\n");

    for (size_t i = 0; i < RUNS; ++i) {
        start = cycles();
        _fork(function);
    }

    // cacl the avg
    uint64_t sum = 0;
    for (size_t j = 0; j < RUNS; ++j) {
        sum += v[j];
    }

    printf("avg: %.5f \n", (double)sum/(double)RUNS);
    return 0;
}