# Retrofit Setup

## Overview
Retrofit is a type-safe HTTP client for Android and Java, built by Square on top of OkHttp. You describe your REST API as a Kotlin interface, and Retrofit generates the networking code that turns method calls into HTTP requests and responses into objects.

It is the most common choice for consuming JSON REST APIs in modern Android apps.

## Adding the dependencies
```kotlin
dependencies {
  implementation("com.squareup.retrofit2:retrofit:2.11.0")
  implementation("com.squareup.retrofit2:converter-moshi:2.11.0")
  implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
}
```

A **converter** (Moshi, Gson, or kotlinx.serialization) handles turning JSON into Kotlin objects. The logging interceptor is optional but useful for debugging.

## Internet permission
Network calls require permission in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## Defining the API interface
Describe endpoints with annotations:

```kotlin
interface UserApi {
  @GET("users/{id}")
  suspend fun getUser(@Path("id") id: Int): User

  @GET("users")
  suspend fun search(@Query("q") term: String): List<User>
}
```

- `@GET`, `@POST`, `@PUT`, `@DELETE` map to HTTP methods.
- `@Path` substitutes a value into the URL.
- `@Query` adds a query parameter.
- `@Body` sends an object as the request body.

Marking functions `suspend` lets Retrofit run the call on a background thread and integrate cleanly with coroutines.

## Building the Retrofit instance
```kotlin
val retrofit = Retrofit.Builder()
  .baseUrl("https://api.example.com/")
  .addConverterFactory(MoshiConverterFactory.create())
  .build()

val api = retrofit.create(UserApi::class.java)
```

The `baseUrl` must end with a trailing slash. Create one Retrofit instance and reuse it.

## Making a call
```kotlin
viewModelScope.launch {
  try {
    val user = api.getUser(1)
    // update state with user
  } catch (e: Exception) {
    // handle network or parsing error
  }
}
```

Because the function is `suspend`, you call it from a coroutine and wrap it in error handling.

## Best practices
- Reuse a single Retrofit/OkHttp instance across the app.
- Use `suspend` functions and call them from a coroutine scope.
- Add a converter that matches your serialization library.
- Always handle exceptions for network and parsing failures.

## Common mistakes
- Forgetting the `INTERNET` permission.
- Omitting the trailing slash on `baseUrl`.
- Calling network functions on the main thread.
- Skipping error handling and crashing on a failed request.

## References
- Retrofit documentation: https://square.github.io/retrofit/
- Network operations overview: https://developer.android.com/training/basics/network-ops/connecting
