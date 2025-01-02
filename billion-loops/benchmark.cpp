#include <iostream>
#include <chrono>

int main()
{
    auto start = std::chrono::high_resolution_clock::now();
    long long sum = 0, product = 1;

    for (long long i = 0; i < 1'000'000'000; ++i)
    {
        if (i % 2 == 0)
        {
            sum += i;
        }
        else
        {
            product = (product * (i % 100)) % 1'000'000'007;
        }

        if (i % 5 == 0)
        {
            sum -= i / 2;
        }
    }

    auto elapsed = std::chrono::high_resolution_clock::now() - start;
    std::cout << "Sum: " << sum << ", Product: " << product
              << ", Elapsed Time: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(elapsed).count()
              << " seconds\n";

    return 0;
}
