# StreamBuilder

The `StreamBuilder` widget listens to events flowing from a `Stream` and rebuilds its descendants for every new event. It is crucial for reactive programming, handling real-time data updates like chat messages, stock prices, or authentication state changes.

## Key Properties

- **stream**: The `Stream` to listen to.
- **initialData**: Data used to create the initial snapshot.
- **builder**: Called every time the stream emits a new event. Takes a `BuildContext` and `AsyncSnapshot`.

## Usage

```dart
StreamBuilder<int>(
  stream: _counterStream, // a Stream<int>
  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Text('Awaiting bids...');
      default:
        return Text('Current bid: \$${snapshot.data}');
    }
  },
)
```

## Best Practices

- Always ensure you properly dispose of the stream controller if you created it.
- Use `snapshot.hasError` and `snapshot.hasData` to handle different states safely.
