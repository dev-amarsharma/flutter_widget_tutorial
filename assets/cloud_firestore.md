# Cloud Firestore

Provides a cloud-hosted NoSQL database for storing and syncing app data.

---

## Description

Cloud Firestore lets Flutter apps read and write structured data in collections and documents. It is commonly used for:

- user profiles
- chat messages
- app content
- live dashboards
- synced records across devices

Firestore can be read once or listened to in real time.

---

## Example

```dart
final firestore = FirebaseFirestore.instance;

Future<void> saveProfile(String uid, String name) async {
  await firestore.collection('users').doc(uid).set({
    'name': name,
  });
}
```

---

## Key Points

- Firestore stores data in collections and documents.
- `FirebaseFirestore.instance` gives access to the database.
- You can read data once or subscribe to live updates.
- Data models and security rules still matter even with a managed backend.

---

## Quick Tips

- Keep document structures consistent.
- Map Firestore data into Dart models when possible.
- Design reads and writes with your UI and query needs in mind.

---

## Things to Avoid

- Do not treat Firestore as if it were a relational SQL database.
- Avoid messy document structures without a clear schema plan.
- Do not skip error handling for reads and writes.

---

## See Also

- [`Firebase Initialization`](assets/firebase_initialization.md)
- [`Firebase Authentication`](assets/firebase_authentication.md)
- [`Streams`](assets/streams.md)
