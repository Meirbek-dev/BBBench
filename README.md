# BBBench

## Better Billion-loop Benchmark

A simple, not-super-useful program that does a total of 1 billion loop iterations, with some arithmetic operations for each. The idea with this is to emphasize loop, conditional, and basic math performance.

Below is the reference C program.

```c
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

```

---

| **Programming Language** | **Elapsed Time** |
| ------------------------ | ---------------- |
| **C (GCC) 14.2.0**       | 1550 ms          |
| **C++ (GCC) 14.2.0**     | 1556 ms          |
| **Go 1.23.3**            | 1625 ms          |
| **Java 23**              | 1765 ms          |
| **Bun 1.1.42 (TS)**      | 6240 ms          |
| **Bun 1.1.42 (JS)**      | 6260 ms          |
| **Deno 2.1.4 (TS)**      | 8347 ms          |
| **Node.js 22.9.0 (JS)**  | 8396 ms          |
| **Deno 2.1.4 (JS)**      | 8465 ms          |
| **PHP 8.3.12**           | 38682 ms         |
| **Python 3.13.0**        | 177510 ms        |

Notes:

- JS/TS results are off the mark (199999999782419460 instead of 199999999800000000)
