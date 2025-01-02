console.time("Benchmark");
var sum = 0;
var product = 1;
for (var i = 0; i < 1000000000; i++) {
    if (i % 2 === 0) {
        sum += i;
    }
    else {
        product = (product * (i % 100)) % 1000000007;
    }
    if (i % 5 === 0) {
        sum -= Math.floor(i / 2);
    }
}
console.timeEnd("Benchmark");
console.log("Sum:", sum, "Product:", product);
