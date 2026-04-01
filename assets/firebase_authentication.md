# Firebase Authentication

Lets your Flutter app identify users and manage sign-in flows with Firebase.

---

## Description

Firebase Authentication provides ready-made backend support for common sign-in methods such as:

- email and password
- Google sign-in
- phone authentication
- anonymous sign-in

It helps apps handle user identity without building a custom auth backend from scratch.

---

## Example

```dart
final auth = FirebaseAuth.instance;

Future<void> signIn(String email, String password) async {
  await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
```

---

## Key Points

- Firebase Auth manages user sessions for you.
- `FirebaseAuth.instance` gives access to auth operations.
- The current user can be checked to know whether someone is signed in.
- Auth flows should handle loading, success, and failure states clearly.

---

## Quick Tips

- Validate user input before sending auth requests.
- Show clear error messages for wrong credentials or missing fields.
- Keep auth logic separate from widget presentation when the app grows.

---

## Things to Avoid

- Do not assume sign-in always succeeds.
- Avoid putting all auth logic directly into UI widgets.
- Do not use Firebase auth before Firebase initialization is complete.

---

## See Also

- [`Firebase Initialization`](assets/firebase_initialization.md)
- [`Cloud Firestore`](assets/cloud_firestore.md)
- [`Form and Validation`](assets/form_validation.md)
