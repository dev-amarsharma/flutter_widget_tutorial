# FutureBuilder

The `FutureBuilder` widget lets you determine the current state of a `Future` and choose what to show while that future is loading, resolving, or erroring. It is essential for handling asynchronous operations like fetching data from an API or reading from a database.

## Key Properties

- **future**: The `Future` object to listen to.
- **initialData**: The data that will be used to create the snapshots until a non-null future has completed.
- **builder**: A builder strategy that is called every time the future interacts with the widget. It takes a `BuildContext` and an `AsyncSnapshot`.

## Usage

```dart
FutureBuilder<String>(
  future: _fetchData(), // a Future<String>
  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Text('Result: ${snapshot.data}');
    }
  },
)
```

## Connection States

- **none**: Not currently connected to any asynchronous computation.
- **waiting**: Connected to an asynchronous computation and awaiting interaction.
- **active**: Connected to an active asynchronous computation.
- **done**: Connected to a terminated asynchronous computation.
