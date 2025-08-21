---
date: "2024-09-05T09:06:23Z"
tags:
- go
- error handling
- programming
title: 'Go Error Handling Techniques: Exploring Sentinel Errors, Custom Types, and Client-Facing Errors'
---

In this blog post, I share my experiments with error handling in Go. I'm new to Go, and there's a lot to learn, but one important aspect is proper error handling: I wanted to know how to keep track of the error cause, how to enrich its context, and finally how to present it to the clients.  
This is just me documenting the things I've read and tried so far. Let me know what you think. I'm here to learn and improve.

### Defining Errors in Go

An error in Go is an interface that implements the `Error() string` method. You can create an error using the `errors.New` function, which "creates errors whose only content is a text message":

```go
err := errors.New("This is an error")
```

Now, let's create a sentinel error:

```go
import "errors"
var errDbConnection = errors.New("db connection")
```

These exported error variables are called sentinel errors. They represent specific failure conditions in a program, such as `io.EOF`, `sql.ErrNoRows`, and various errors in the [fs package](https://pkg.go.dev/io/fs#pkg-variables).

Since there's only one global definition of a sentinel error, you can check for it using a simple equality operator:

```go
err := db.QueryRow("SELECT items LIMIT 1").Scan()
if err != nil && err != sql.ErrNoRows {
    log.Fatal(err)
}
```

### Issues with Sentinel Errors

Sentinel errors have two primary issues:

1. **They are not descriptive enough**: Sentinel errors often do not carry additional context about the failure.
2. **They can become part of your public API**: Since sentinel errors are typically global, they can unintentionally become part of a program’s public API.

For a deeper dive, check out [Don’t just check errors, handle them gracefully](https://dave.cheney.net/2016/04/27/dont-just-check-errors-handle-them-gracefully). (Note that this article is a bit outdated, especially since Go 1.13 deprecates [github.com/pkg/errors](https://github.com/pkg/errors).)

### Enriching Error Messages with Context

To address the lack of descriptiveness in sentinel errors, we can add more data to our errors. Here's an example where we add context to a query execution error:

```go
func NewQueryExecutionError(query string, err error) error {
    return errors.New(fmt.Sprintf("query execution failed for %v: %v", query, err))
}
```

This provides more context around the error, but how do we later check the underlying error?

If you create errors by appending strings like the example above, you'll have to search for substrings in the error message:

```go
err := NewQueryExecutionError("foo", someError)
if strings.Contains(err.Error(), "foo") {
    log.Fatal(err)
}
```

The issue here is that changing the error message will break this check.

### A Better Way: Custom Error Types

To overcome this, let's move to a more structured error-handling approach by creating custom error types.

In the following example, we have a `Record` type, and we'll handle reading a file, parsing its contents, and returning a record.

First, define a dummy `Record` type:

```go
type Record struct {
    num int
    str string
}
```

Next, create a sentinel error and a `readFile` function to simulate reading a file:

```go
var errFileRead = errors.New("reading file failed")

func readFile(fileName string) (string, error) {
    data, err := os.ReadFile(fileName)
    if err != nil {
        fmt.Printf("[readFile] function: %v\n", err)
        return "", errFileRead
    }
    return string(data), nil
}
```

As you can see, after logging the error returned by `ReadFile`, we return our own custom `errFileRead` error.

We then parse the file content in the `readInput` function, which returns a more descriptive error by calling `NewRecordParseError`:

```go
func readInput(fileName string) (int, string, error) {
    data, err := readFile(fileName)
    if err != nil {
        return 0, "", NewRecordParseError("cannot open the file", fileName, err)
    }
    var num int
    var str string
    _, err = fmt.Sscanln(data, &num, &str)
    if err != nil {
        return 0, "", NewRecordParseError("parsing file", fileName, err)
    }
    return num, str, nil
}
```

The custom error type `RecordParseError` holds additional context about the error:

```go
type RecordParseError struct {
    fileName   string
    innerError error
}

func (p *RecordParseError) Error() string {
    return fmt.Sprintf("parsing %q: %v", p.fileName, p.innerError)
}

func (p *RecordParseError) Unwrap() error {
    return p.innerError
}
```

The `Unwrap` method allows us to use Go's `errors.Is` and `errors.As` for unwrapping nested errors.  
These are critical concepts that you can read more about in [this blog post](https://go.dev/blog/go1.13-errors) on the Go website.  
It's better to check them out before moving on with the post.

### Propagating and Wrapping Errors

In the `fetchData` function, we propagate the error and wrap it with more context using `fmt.Errorf`:

```go
func fetchData(fileName string) (*Record, error) {
    num, str, err := readInput(fileName)
    if err != nil {
        return nil, fmt.Errorf("reading record: %w", err)
    }
    return &Record{num, str}, nil
}
```

### Structuring Errors for Clients

Up to this point, the errors are intended for internal usage, and it's not something that we want to send to the clients that have called this function.  
When exposing errors to external clients, you often want structured error responses. To handle this, I created an `AppError` type that includes an error code and message:

```go
type AppError struct {
    ErrorCode    string
    ErrorMessage string
    innerError   error
}

func (e *AppError) Error() string {
    return e.innerError.Error()
}
```

You can then create specific application errors, like so:

```go
var FetchDataAppErrorCode = "FETCH_DATA_ERROR"

func NewFetchDataAppError(err error) error {
    return &AppError{
        ErrorMessage: fmt.Sprintf("fetching data: %v", err),
        ErrorCode:    FetchDataAppErrorCode,
        innerError:   err,
    }
}
```

### Wrapping Up the Application

Here's how we tie everything together in the `runApp` function:

```go
func runApp() (*Record, error) {
    res, err := fetchData("input.txt")
    if err == nil {
        return res, nil
    }
    return nil, NewFetchDataAppError(err)
}
```

The main function then shows how we can use `errors.Is` and `errors.As` to unwrap and check error types:

```go
func main() {
	res, err := runApp()

	if err == nil {
		fmt.Println("Program succeeded: ", res)
		return
	}

	if err == errFileRead {
		// False: This will not work, since we're checking with the error instance
		fmt.Printf("1. reading file: %v\n", err)
	}
	if errors.Is(err, errFileRead) {
		// True: Unwrapped error is errDbConnection
		fmt.Printf("2. reading file: %v\n", err)
	}

	if errors.Is(err, &RecordParseError{}) {
		// False: &RecordParseError{} is not the same as err
		fmt.Printf("3. parsing input: %v\n", err)
	}
	var parsingError *RecordParseError
	if errors.As(err, &parsingError) {
		// True: err is of the RecordParseError type
		fmt.Printf("4. parsing input: %v\n", err)
	}

	if strings.Contains(err.Error(), "reading record") {
		// True: We can check the exact error message
		fmt.Printf("5. app: %v\n", err)
	}

	var appErr *AppError
	if errors.As(err, &appErr) {
		// There's only one error of AppError type
		if appErr.ErrorCode == FetchDataAppErrorCode {
			fmt.Printf("6. App failed: %v\n", appErr)
		}
		fmt.Printf(`7. HTTP 400 Response: {"error_code": "%s", error_message: "%s" }`, appErr.ErrorCode, appErr.ErrorMessage)
		fmt.Println()
	} else {
		fmt.Println("8. HTTP 500", err)
		return
	}
}
```

And by passing a file name that does not exist, I get this output:

```
> go run main.go
[readFile] function: open input.txt: no such file or directory
2. reading file: reading record: parsing "input.txt": can not open the file reading file
4. parsing input: reading record: parsing "input.txt": can not open the file reading file
5. app: reading record: parsing "input.txt": can not open the file reading file
6. App failed: reading record: parsing "input.txt": can not open the file reading file
7. HTTP 400 Response: {"error_code": "FETCH_DATA_ERROR", error_message: "fetching data: reading record: parsing "input.txt": can not open the file reading file" }
```

[Here](https://go.dev/play/p/hlred_iCkfG) you can find the code for the application in Go Playground.

---

In this post, I explored different techniques for error handling in Go. I started with basic sentinel errors and gradually moved towards custom error types that add more context. I also demonstrated how to structure errors for client-facing applications using `AppError`. While these techniques cover various aspects of Go error handling, I'm eager to hear your thoughts and suggestions for improvement.

**Update (August 2025)**: I've written a follow-up post about [Better Error Handling in Go]({{< ref "better-error-handling-in-go.md" >}}) that addresses some issues with the `AppError` approach and provides an improved solution.

*Edits:  
8 Sep: Updated the error messages after [this comment](https://www.reddit.com/r/golang/comments/1fbc7c0/comment/lm1vr7t/) on Reddit to remove all the "failure" repetitions*