using System;

class Benchmark
{
    static void Main()
    {
        var start = DateTime.Now;
        long sum = 0;
        long product = 1;

        for (long i = 0; i < 1_000_000_000; i++)
        {
            if (i % 2 == 0)
            {
                sum += i;
            }
            else
            {
                product = (product * (i % 100)) % 1_000_000_007;
            }

            if (i % 5 == 0)
            {
                sum -= i / 2;
            }
        }

        var elapsed = DateTime.Now - start;
        Console.WriteLine($"Sum: {sum}, Product: {product}, Elapsed Time: {elapsed.TotalSeconds} seconds");
    }
}
