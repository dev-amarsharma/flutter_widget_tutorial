
# Image

The `Image` widget in Flutter displays images from various sources such as assets, network, or file. It is commonly used to show pictures and icons in your app.

## Class Definition

```dart
Image({
  Key? key,
  ImageProvider image,
  double? width,
  double? height,
  BoxFit? fit,
  AlignmentGeometry alignment = Alignment.center,
  ImageRepeat repeat = ImageRepeat.noRepeat,
  Color? color,
  BlendMode? colorBlendMode,
  FilterQuality filterQuality = FilterQuality.low,
  ... // more parameters for advanced usage
})
```

```dart
Image.network(
  'https://flutter.dev/images/flutter-logo-sharing.png',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)
```

The main parameters of the Flutter Image widget are:

- **image**: The image to display (required for advanced usage).
- **width**: The width of the image.
- **height**: The height of the image.
- **fit**: How to inscribe the image into the space allocated (e.g., `BoxFit.cover`).
- **color**: Color to blend with the image.
- **alignment**: How to align the image within its bounds.
- **repeat**: How to repeat the image if it doesn't fill its space.

### Quick Tips:
- Use `Image.asset` for local images and `Image.network` for web images.
- Use `fit` to control how the image scales and crops.

### Things to Avoid:
- Avoid loading large images without specifying width/height.
- Don’t use Image for icons—use the Icon widget for Material icons.
