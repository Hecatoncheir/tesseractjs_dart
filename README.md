# Dart wrapper for [tesseratjs](https://github.com/naptha/tesseract.js) library

### HTML
<br>Add CDN to `HEAD`:
```HTML
<!-- v5 -->
<script src='https://cdn.jsdelivr.net/npm/tesseract.js@5/dist/tesseract.min.js'></script>
```

or:
```html
 <script src='worker.min.js'></script>
 <script src='tesseract-core-simd-lstm.wasm.js'></script>
 <script src='tesseract.min.js'></script>
```

### Dart
```dart
import 'dart:convert';
import "package:tesseratjs_dart/tesseractjs.dart";

void main(){
  var result = await FilePicker.platform.pickFiles();
  if (result == null) return;

  final image = result.files.first;
  if (image == null) return null;

  final bytes = image.bytes;
  if (bytes == null) return null;

  final encodedImage = base64.encode(bytes);
  final uriData = "data:image/png;base64, $encodedImage";

  final imagePath = uriData;
  final text = await recognize(imagePath, language);
  print(text);
}
```