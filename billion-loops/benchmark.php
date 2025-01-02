<?php
$start = microtime(true);
$sum = 0;
$product = 1;

for ($i = 0; $i < 1_000_000_000; $i++) {
    if ($i % 2 === 0) {
        $sum += $i;
    } else {
        $product = ($product * ($i % 100)) % 1_000_000_007;
    }

    if ($i % 5 === 0) {
        $sum -= intdiv($i, 2);
    }
}

$elapsed = microtime(true) - $start;
echo "Sum: $sum, Product: $product, Elapsed time: {$elapsed} seconds\n";
