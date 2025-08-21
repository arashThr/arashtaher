+++
title = "Making errors.Is Simpler with Sentinels"
date = "2025-08-20T16:34:02+02:00"
description = "A second overview on the best ways to do error handling in Go"
tags = ["go", "error handling", "programming"]
+++

Here's an amendment to my [previous post]({{< ref "2024-09-05-go-error-handling-techniques-exploring-sentinel-errors-custom-types-and-client-facing-errors.md" >}}) on Go error handling that I wrote a year ago. Since then, my knowledge of Go has grown significantly, and I now have a better understanding of how things work.

The problem I faced with the solution suggested in that post is that, as it turned out, if you don't have an error constant that you can easily compare errors with, using `AppError` can become cumbersome: each time you have to convert the error with `As` and check if it's an `AppError`, and that's not ideal.

Instead, here's what you can do: We will have our `AppError` as before with the same methods and fields.

```go
type AppError struct {
    ErrorCode    string
    ErrorMessage string
    innerError   error
}

func (e *AppError) Error() string {
    return e.innerError.Error()
}

func (e *AppError) Unwrap() error {
    return e.innerError
}
```

Now here's the important step: We will define a variable for a specific type of error:

```go
var ErrFetchDataApp = &AppError{
    ErrorCode: FetchDataAppErrorCode,
}
```

This variable will be accessible by importers of this package.

The next step is to make sure we can create this app error with a custom message and inner error. For that, we will have a `New` function:

```go
func NewFetchDataAppError(message string, err error) error {
    return &AppError{
        ErrorCode:    FetchDataAppErrorCode,
        ErrorMessage: message,
        innerError:   err,
    }
}
```

**Important note**: We shouldn't modify the global `ErrFetchDataApp` variable directly, as this could cause race conditions in concurrent code. Instead, we create a new instance each time.

Everywhere that we need to return `FetchDataAppError`, we will use this function, and the beautiful part is that now we can easily check for the error type without any type conversion: `errors.Is(err, ErrFetchDataApp)`.

No more checking for `ErrorCode` or using `errors.As`.

## Final thoughts 
This solution brings me closer to the style I was aiming for:
- clean errors.Is checks for error categories,
- but still with rich context when I actually construct an `AppError`.

That said, I’m still learning. Maybe there are tradeoffs here that I haven’t seen yet. For example, will this pattern hold up well if I end up with dozens of error codes? I’d love to hear from other Go developers: would you prefer this sentinel-marker style, or stick with the Is method approach?
