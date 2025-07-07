# BLoC Pattern in Flutter

The BLoC (Business Logic Component) pattern is a popular state management approach in Flutter. It separates business logic from UI, making code more testable and maintainable.

## Step-by-Step BLoC Implementation

### 1. Add Dependencies
Add `flutter_bloc` and `bloc` to your `pubspec.yaml`:
```yaml
dependencies:
  flutter_bloc: ^8.1.0
  bloc: ^8.1.0
```

### 2. Define Events
Create an event class for your BLoC:
```dart
// counter_event.dart
abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}
```

### 3. Define State
Create a state class:
```dart
// counter_state.dart
class CounterState {
  final int counter;
  CounterState(this.counter);
}
```

### 4. Create the BLoC
Implement the BLoC class:
```dart
// counter_bloc.dart
import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) => emit(CounterState(state.counter + 1)));
    on<Decrement>((event, emit) => emit(CounterState(state.counter - 1)));
  }
}
```

### 5. Provide the BLoC
Wrap your widget tree with `BlocProvider`:
```dart
BlocProvider(
  create: (_) => CounterBloc(),
  child: MyHomePage(),
)
```

### 6. Use the BLoC in UI
Use `BlocBuilder` and dispatch events:
```dart
BlocBuilder<CounterBloc, CounterState>(
  builder: (context, state) {
    return Column(
      children: [
        Text('Counter: ${state.counter}'),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => context.read<CounterBloc>().add(Increment()),
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => context.read<CounterBloc>().add(Decrement()),
            ),
          ],
        ),
      ],
    );
  },
)
```

## Summary
- Define events and state
- Implement the BLoC
- Provide the BLoC to the widget tree
- Use BlocBuilder and BlocProvider in the UI

This approach keeps your business logic separate from your UI, making your Flutter app scalable and maintainable.
