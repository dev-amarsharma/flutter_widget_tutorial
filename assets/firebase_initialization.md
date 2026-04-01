# Firebase Initialization

Sets up Firebase services so your Flutter app can use products like Auth, Firestore, and Storage.

---

## Description

Before using Firebase features in Flutter, you need to initialize Firebase in your app. This usually includes:

- adding Firebase packages
- configuring platform files
- calling `Firebase.initializeApp()`
- ensuring initialization happens before Firebase services are used

Without initialization, Firebase-dependent code will fail.

---

## Example

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

---

## Key Points

- Initialize Firebase before using any Firebase service.
- `WidgetsFlutterBinding.ensureInitialized()` is commonly needed before async setup in `main()`.
- Platform-specific Firebase configuration files must be added correctly.
- Initialization usually happens once at startup.

---

## Quick Tips

- Keep initialization code early and explicit.
- Confirm package setup and platform config before debugging service calls.
- Separate Firebase setup problems from app logic problems when troubleshooting.

---

## Things to Avoid

- Do not use Firebase services before initialization completes.
- Avoid assuming package install alone is enough without platform config.
- Do not hide initialization failures silently.

---

## See Also

- [`Firebase Authentication`](assets/firebase_authentication.md)
- [`Cloud Firestore`](assets/cloud_firestore.md)
