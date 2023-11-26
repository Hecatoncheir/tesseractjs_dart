import 'dart:html';

Future<void> main() async {
  querySelector('#input')?.text = 'Your Dart app is running.';

  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
  } else {
    // User canceled the picker
  }
  // querySelector('#output')?.text = 'Your Dart app is running.';
}

class FilePickerResult {
}
