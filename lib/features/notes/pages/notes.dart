import 'package:flutter/material.dart';
import 'package:hackathon/providers/note_provider.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final List<Map<String, String>> _notes = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();




  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteprovider = Provider.of<NoteProvider>(context,listen:false);
    List<Map<String, String>> notes = noteprovider.getNotes;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        note['title']!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(note['description']!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
  void _showAddNoteModal(BuildContext context) {
    final noteprovider = Provider.of<NoteProvider>(context,listen:false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty) {
                        noteprovider.setNotes = {
                          'title': _titleController.text,'description': _descriptionController.text,
                        };
                        // setState(() {
                        //   _notes.add({
                        //     'title': _titleController.text,
                        //     'description': _descriptionController.text,
                        //   });
                        //   _titleController.clear();
                        //   _descriptionController.clear();
                        // });
                        Navigator.of
                          (context).pop();
                      }
                    },
                    child: const Text('Add Note'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
