import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  final List<Map<String, String>> _notes = [];

  List<Map<String, String>> get getNotes => _notes;

  set setNotes(Map<String, String> value) {
    _notes.add(
      value
    );
    notifyListeners();
  }
}
