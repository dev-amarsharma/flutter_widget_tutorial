# Draggable

The `Draggable` widget allows a widget to be dragged from its original position to a `DragTarget`. It provides visual feedback during the drag operation.

## Key Properties

- **child**: The widget displayed when not dragging.
- **feedback**: The widget displayed under the pointer when dragging.
- **childWhenDragging**: The widget displayed in the original place when dragging (optional).
- **data**: The data that will be dropped into the `DragTarget`.

## Usage

```dart
Draggable<int>(
  data: 10,
  feedback: Container(
    color: Colors.deepOrange,
    height: 100,
    width: 100,
    child: const Icon(Icons.directions_run),
  ),
  child: Container(
    height: 100,
    width: 100,
    color: Colors.orange,
    child: const Center(child: Text('Drag me')),
  ),
)
```
