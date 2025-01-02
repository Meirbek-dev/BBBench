#include <stdio.h>
#include <time.h>

int main()
{
    clock_t start = clock();
    long long sum = 0, product = 1;

    for (long long i = 0; i < 1000000000; i++)
    {
        if (i % 2 == 0)
        {
            sum += i;
        }
        else
        {
            product = (product * (i % 100)) % 1000000007;
        }

        if (i % 5 == 0)
        {
            sum -= i / 2;
        }
    }

    double elapsed = (double)(clock() - start) / CLOCKS_PER_SEC;
    printf("Sum: %lld, Product: %lld, Elapsed Time: %.2f seconds\n", sum, product, elapsed);

    return 0;
}
