import 'package:flutter/material.dart';

enum Language { ru, en }

typedef OnSelect = Function(Language);

class LanguageSelector extends StatefulWidget {
  final Language? selectedLanguage;
  final OnSelect? onSelect;

  const LanguageSelector({
    super.key,
    this.selectedLanguage,
    this.onSelect,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  Language? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    Language? selectedLanguage = this.selectedLanguage;
    final callback = widget.onSelect;

    return SegmentedButton<Language>(
      segments: const <ButtonSegment<Language>>[
        ButtonSegment<Language>(
          value: Language.ru,
          label: Text('Русский'),
        ),
        ButtonSegment<Language>(
          value: Language.en,
          label: Text('English'),
        ),
      ],
      selected: selectedLanguage == null ? {} : <Language>{selectedLanguage},
      onSelectionChanged: callback == null
          ? null
          : (Set<Language> newSelection) {
              setState(() {
                this.selectedLanguage = newSelection.first;
              });
              callback(newSelection.first);
            },
    );
  }
}
