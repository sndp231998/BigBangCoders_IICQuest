import 'package:flutter/material.dart';

class Academic extends StatefulWidget {
  const Academic({Key? key}) : super(key: key);

  @override
  State<Academic> createState() => _AcademicState();
}

class _AcademicState extends State<Academic> {
  final _academicLists = [
    {
      'title': 'Class - 8 BLE',
    },
    {
      'title': 'Class - 9 PABSON',
    },
    {
      'title': 'Class - 10 SEE',
    },
    {
      'title': 'Class - 11 & 12 (+2)',
    },
    {
      'title': 'Bachelors',
      'lists': [
        'BSc',
        'BCA',
        'BBA',
      ]
    },
    {
      'title': 'Masters',
      'lists': [
        'MTech',
        'MCA',
        'MSc',
      ]
    },
  ];

  void _navigateToDetailPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academics'),
      ),
      body: ListView.builder(
        itemCount: _academicLists.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> academicItem = _academicLists[index];
          final String title = academicItem['title'] ?? '';

          if (academicItem['lists'] != null) {
            return ExpansionTile(
              title: Text(title),
              children: [
                ...List<Widget>.from(
                    (academicItem['lists'] as List<String>).map(
                  (listItem) => ListTile(
                    title: Text(listItem),
                  ),
                )),
              ],
            );
          } else {
            return ListTile(
              title: Text(title),
              onTap: () => _navigateToDetailPage(context, title),
            );
          }
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  DetailPage({super.key, required this.title});
  final List<Map<String, String>> sharedMaterials = [
    {'title': 'Material 1', 'description': 'Description of Material 1'},
    {'title': 'Material 2', 'description': 'Description of Material 2'},
    {'title': 'Material 3', 'description': 'Description of Material 3'},
    {'title': 'Material 4', 'description': 'Description of Material 4'},
    {'title': 'Material 5', 'description': 'Description of Material 5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shared Materials For $title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              ...sharedMaterials.map((material) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(material['title']!),
                    subtitle: Text(material['description']!),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
