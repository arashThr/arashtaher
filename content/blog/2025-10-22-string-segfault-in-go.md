+++
title = "String operation are not atomic in Go"
date = "2025-10-22T13:00:00+02:00"

tags = ["go", "debug", "concurrency"]
+++

I was facing intermittent failure in one of our tests, and when looking at the stack trace, I could see that it's pointing out to this line:
`{Body: []byte(m.NextSubscriptionMessageToBeReceived)}`

How could we fail on this line?

That's when you know spending too much time in the single threaded world of JS has taken its toll on you :)

Let's go and check the official documentations:

> Strings are actually very simple: they are just read-only slices of bytes...

So what they practically are is a two-word headers (pointer + length).

Now, when you have concurrent reads and writes on the slices, it can cause a header to be old pointer + new length or vice versa.  
This now will lead to an invalid memory read during `[]byte(str)`

## Example

You can create the scenario for the race condition, but due to the non-deterministic nature of the problem, crashing the program is not that simple.

Here's an example of such case:

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	var message string
	var wg sync.WaitGroup

	// Start 10 goroutines that write to the same string
	for i := 0; i < 10; i++ {
		wg.Add(1)
		go func(id int) {
			defer wg.Done()
			// Writing to shared string variable
			message = fmt.Sprintf("Hello from goroutine %d", id)
			time.Sleep(time.Millisecond) // Simulate some work
		}(i)
	}

	// Start another goroutine that reads the string
	wg.Add(1)
	go func() {
		defer wg.Done()
		for j := 0; j < 5; j++ {
			// Reading from shared string variable
			fmt.Println("Reading:", message)
			time.Sleep(time.Millisecond)
		}
	}()

	wg.Wait()
	fmt.Println("Final message:", message)
}
```

If you run the code with `-race` option, you will get this result: 

```
==================
WARNING: DATA RACE
Write at 0x00c0000101b0 by goroutine 15:
  main.main.func1()
      /Users/cmd/exp/main.go:17 +0xbc
  main.main.gowrap1()
      /Users/cmd/exp/main.go:19 +0x40

Previous read at 0x00c0000101b0 by goroutine 16:
  main.main.func2()
      /Users/cmd/exp/main.go:27 +0xb0

Goroutine 15 (running) created at:
  main.main()
      /Users/cmd/exp/main.go:15 +0x9c

Goroutine 16 (running) created at:
  main.main()
      /Users/cmd/exp/main.go:23 +0x24c
==================
==================
WARNING: DATA RACE
Write at 0x00c0000101b0 by goroutine 10:
  main.main.func1()
      /Users/cmd/exp/main.go:17 +0xbc
  main.main.gowrap1()
      /Users/cmd/exp/main.go:19 +0x40

Previous write at 0x00c0000101b0 by goroutine 6:
  main.main.func1()
      /Users/cmd/exp/main.go:17 +0xbc
  main.main.gowrap1()
      /Users/cmd/exp/main.go:19 +0x40

Goroutine 10 (running) created at:
  main.main()
      /Users/cmd/exp/main.go:15 +0x9c

Goroutine 6 (running) created at:
  main.main()
      /Users/cmd/exp/main.go:15 +0x9c
==================
```

As you can see we have two race cases: one read/write race and one write/write race (when multiple Go routines want to write to the same string).

## Fix

We need to mark the variable access as critical section in the code. That can be done using a mutex.

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	var message string
	var mu sync.Mutex // Add mutex for synchronization
	var wg sync.WaitGroup

	// Start 10 goroutines that write to the same string
	for i := 0; i < 10; i++ {
		wg.Add(1)
		go func(id int) {
			defer wg.Done()
			mu.Lock() // Lock before writing
			message = fmt.Sprintf("Hello from goroutine %d", id)
			mu.Unlock() // Unlock after writing
			time.Sleep(time.Millisecond)
		}(i)
	}

	// Start another goroutine that reads the string
	wg.Add(1)
	go func() {
		defer wg.Done()
		for j := 0; j < 5; j++ {
			mu.Lock() // Lock before reading
			msg := message
			mu.Unlock() // Unlock after reading
			fmt.Println("Reading:", msg)
			time.Sleep(time.Millisecond)
		}
	}()

	wg.Wait()
	mu.Lock()
	fmt.Println("Final message:", message)
	mu.Unlock()
}
```
