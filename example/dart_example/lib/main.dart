import 'dart:convert';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:tesseratjs_dart/tesseractjs.dart';

Future<void> main() async {
  final inputElement = querySelector('#input');
  final outputElement = querySelector('#output');

  inputElement?.onClick.listen((_) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.first;
    final bytes = file.bytes;
    if (bytes == null) return;

    final encodedImage = base64.encode(file.bytes!);
    final uriData = "data:image/png;base64, $encodedImage";

    final imagePath = uriData;
    const language = "rus";
    final text = await recognize(imagePath, language);

    print("TEXT: ${text}");

    outputElement?.text = text;
  });
}
