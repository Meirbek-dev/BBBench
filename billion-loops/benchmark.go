package main

import (
	"fmt"
	"time"
)

func main() {
	start := time.Now()
	var sum int64 = 0
	var product int64 = 1
	const limit int64 = 1_000_000_000

	for i := int64(0); i < limit; i++ {
		if i%2 == 0 {
			sum += i
		} else {
			product = (product * (i % 100)) % 1_000_000_007
		}

		if i%5 == 0 {
			sum -= i / 2
		}
	}

	elapsed := time.Since(start)
	fmt.Printf("Final Sum: %d\n", sum)
	fmt.Printf("Final Product: %d\n", product)
	fmt.Printf("Elapsed Time: %v\n", elapsed)
}
