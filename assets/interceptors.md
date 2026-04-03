# OkHttp Interceptors

## Overview
OkHttp interceptors let you observe, rewrite, and retry calls. The official OkHttp docs divide them into application interceptors and network interceptors.

## Application interceptors
Register with `addInterceptor(...)`.

These are useful for:

- adding common headers
- centralized logging
- simple retry behavior
- short-circuiting or rewriting requests and responses

Application interceptors typically see a single logical application-level request and response.

## Network interceptors
Register with `addNetworkInterceptor(...)`.

The OkHttp docs show that network interceptors can run multiple times, for example once for an initial request and again for a redirect. They observe data closer to the actual network layer.

## Basic pattern

```kotlin
class AuthInterceptor : Interceptor {
  override fun intercept(chain: Interceptor.Chain): Response {
    val request = chain.request().newBuilder()
      .header("Authorization", "Bearer token")
      .build()
    return chain.proceed(request)
  }
}
```

## When to use which
- Use an application interceptor for app-level concerns.
- Use a network interceptor when you need lower-level network visibility.

## Best practices
- Keep interceptor logic focused and predictable.
- Avoid putting UI concerns in networking interceptors.
- Be careful with retries to avoid loops or duplicate work.
- Know whether redirects or intermediate responses matter for your case.

## Common mistakes
- Confusing application and network interceptors.
- Logging or mutating requests in the wrong layer.
- Adding complex business logic inside networking code.

## References
- OkHttp interceptors: https://square.github.io/okhttp/features/interceptors/
