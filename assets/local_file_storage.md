# Local File Storage

Stores files directly on the device when data is larger or more file-like than simple preferences.

---

## Description

Local file storage is useful when your app needs to read or write files such as:

- exported notes
- cached documents
- logs
- downloaded content
- user-created text or JSON files

It is more flexible than shared preferences, but it also requires you to manage file paths, formats, and error cases carefully.

---

## Example

```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> localFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/notes.txt');
}

Future<void> writeNote(String text) async {
  final file = await localFile();
  await file.writeAsString(text);
}
```

---

## Key Points

- File storage is useful for structured local files and larger content.
- Use packages like `path_provider` to find safe directories.
- Always handle missing files, permission issues, and read/write errors.

---

## Quick Tips

- Keep file formats simple when possible, such as text or JSON.
- Separate file access logic from widgets.
- Decide whether files are temporary cache or long-term app data.

---

## Things to Avoid

- Do not store large file-based data in shared preferences.
- Avoid hard-coding unsafe directory paths.
- Do not ignore I/O failures.

---

## See Also

- [`SharedPreferences`](assets/shared_preferences.md)
- [`JSON Parsing`](assets/json_parsing.md)
