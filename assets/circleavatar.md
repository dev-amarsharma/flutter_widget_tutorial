# CircleAvatar

The `CircleAvatar` widget is a circle that represents a user. It typically contains an image (user profile picture) or initials.

## Key Properties

- **backgroundImage**: An `ImageProvider` for the background image.
- **radius**: The size of the avatar (half the diameter).
- **child**: A widget displayed inside the circle (often Text).
- **backgroundColor**: The color used if the image is missing or transparent.

## Usage

```dart
// With Image
CircleAvatar(
  radius: 30,
  backgroundImage: NetworkImage('https://example.com/user.jpg'),
)

// With Initials
CircleAvatar(
  backgroundColor: Colors.blue,
  child: Text('AS'),
)
```
