import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/language_selector.dart';
import 'package:tesseratjs_dart/tesseractjs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Language language;
  PlatformFile? image;
  String? imageText;

  late final StreamController<String?> controller;
  late final Stream<String?> stream;

  @override
  void initState() {
    super.initState();
    language = Language.ru;

    controller = StreamController<String>();
    stream = controller.stream;
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LanguageSelector(
          selectedLanguage: language,
          onSelect: (newLanguage) => language = newLanguage,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          child: const Text('Select image with text'),
          onPressed: () async {
            var result = await FilePicker.platform.pickFiles();
            if (result == null) return;
            final file = result.files.first;
            image = file;
            final lang = getLanguage(language);
            recognizeImageText(language: lang, image: image)
                .then(controller.add);
          },
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StreamBuilder<String?>(
              stream: stream,
              builder: (context, snapshot) {
                final text = snapshot.data;
                return Text(text ?? "");
              }),
        ),
      ],
    );
  }

  String getLanguage(Language language) {
    return switch (language) {
      Language.ru => "rus",
      Language.en => "eng",
    };
  }

  Future<String?> recognizeImageText({
    required String language,
    required PlatformFile? image,
  }) async {
    if (image == null) return null;

    final bytes = image.bytes;
    if (bytes == null) return null;

    final encodedImage = base64.encode(bytes);
    final uriData = "data:image/png;base64, $encodedImage";

    final imagePath = uriData;
    final text = await recognize(imagePath, language);

    return text;
  }
}
