import time

start = time.time()
sum = 0
product = 1

for i in range(1_000_000_000):
    if i % 2 == 0:
        sum += i
    else:
        product = (product * (i % 100)) % 1_000_000_007

    if i % 5 == 0:
        sum -= i // 2

elapsed = time.time() - start
print("Sum:", sum, "Product:", product, "Elapsed time:", elapsed, "seconds")
