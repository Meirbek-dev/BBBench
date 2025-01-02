console.time("Benchmark");
let sum: number = 0;
let product: number = 1;
for (let i: number = 0; i < 1_000_000_000; i++) {
  if (i % 2 === 0) {
    sum += i;
  } else {
    product = (product * (i % 100)) % 1_000_000_007;
  }
  if (i % 5 === 0) {
    sum -= Math.floor(i / 2);
  }
}
console.timeEnd("Benchmark");
console.log("Sum:", sum, "Product:", product);
