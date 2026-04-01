# Hive Basics

Provides lightweight local NoSQL storage for Flutter apps.

---

## Description

Hive is a local database package often used for simple, fast storage on device. It can store objects, lists, settings, and cached app data without needing a full SQL setup.

Common uses:

- offline cache
- small structured app data
- user preferences beyond simple key-value cases
- local collections of models

---

## Example

```dart
final box = await Hive.openBox('settings');

await box.put('username', 'amar');
final name = box.get('username');

print(name);
```

---

## Key Points

- Hive stores data in boxes.
- You open a box before reading or writing values.
- It is good for lightweight local structured storage.
- It is often simpler than SQL for many app use cases.

---

## Quick Tips

- Keep box names clear and consistent.
- Initialize Hive before opening boxes.
- Use adapters when storing custom model objects.

---

## Things to Avoid

- Do not use Hive blindly when you need relational SQL features.
- Avoid mixing unrelated data in one box without structure.
- Do not forget to initialize storage before access.

---

## See Also

- [`SharedPreferences`](assets/shared_preferences.md)
- [`Local File Storage`](assets/local_file_storage.md)
