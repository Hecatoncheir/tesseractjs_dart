@JS("Tesseract")
library tesseract;

// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

import 'package:js/js.dart';

@JS()
@anonymous
class RecognizeResult {
  external RecognizeResultText data;
}

@JS()
@anonymous
class RecognizeResultText {
  external String text;
}

@JS('recognize')
external Future<RecognizeResult> _recognize(String imagePath, String language);

Future<String> recognize(String imagePath, String language) async =>
    promiseToFuture(_recognize(imagePath, language))
        .then((result) => result.data.text);
