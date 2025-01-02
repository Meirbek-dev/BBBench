public class Benchmark {
    public static void main(String[] args) {
        long start = System.nanoTime();
        long sum = 0;
        long product = 1;
        long limit = 1_000_000_000L;

        for (long i = 0; i < limit; i++) {
            if (i % 2 == 0) {
                sum += i;
            } else {
                product = (product * (i % 100)) % 1_000_000_007L;
            }

            if (i % 5 == 0) {
                sum -= i / 2;
            }
        }

        long end = System.nanoTime();
        System.out.println("Final Sum: " + sum);
        System.out.println("Final Product: " + product);
        System.out.println("Elapsed Time: " + (end - start) / 1_000_000 + " ms");
    }
}
