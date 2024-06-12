import 'package:flutter/material.dart';
import 'package:hackathon/features/consult/models/professional.dart';

class Consult extends StatefulWidget {
  const Consult({Key? key}) : super(key: key);

  @override
  State<Consult> createState() => _ConsultState();
}

class _ConsultState extends State<Consult> {
  // Dummy data for demonstration
  final List<Professional> professionals = [
    Professional(
      name: 'Dr. John Smith',
      profession: 'Psychologist',
      profilePicture: 'assets/images/consult1.jpeg',
      description: 'Specializes in anxiety and depression.',
      rating: 4.8,
    ),
    Professional(
      name: 'Dr. Emily Johnson',
      profession: 'Therapist',
      profilePicture: 'assets/images/consult2.jpeg',
      description: 'Experienced in family and relationship counseling.',
      rating: 4.9,
    ),
    // Add more professionals as needed
  ];

  List<Professional> filteredProfessionals = [];

  @override
  void initState() {
    super.initState();
    filteredProfessionals = professionals;
  }

  void _filterProfessionals(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProfessionals = professionals
            .where((professional) =>
                professional.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredProfessionals = professionals;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consult'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _CustomSearchDelegate(professionals),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredProfessionals.length,
        itemBuilder: (context, index) {
          final professional = filteredProfessionals[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(professional.profilePicture),
              radius: 30, // Increase the radius for larger CircleAvatar
            ),
            title: Text(professional.name),
            subtitle: Text(professional.profession),
            onTap: () {
              _showOptionsDialog(context, professional);
              // Implement logic to navigate to chat interface or appointment scheduling
            },
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  professional.rating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('Rating'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomSearchDelegate extends SearchDelegate<String> {
  final List<Professional> professionals;

  _CustomSearchDelegate(this.professionals);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Professional> searchResults = professionals
        .where((professional) =>
            professional.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final professional = searchResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(professional.profilePicture),
            radius: 30, // Increase the radius for larger CircleAvatar
          ),
          title: Text(professional.name),
          subtitle: Text(professional.profession),
          onTap: () {
            _showOptionsDialog(context, professional);
            // Implement logic to navigate to chat interface or appointment scheduling
          },
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                professional.rating.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('Rating'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Professional> suggestionList = query.isEmpty
        ? professionals // Display all professionals if query is empty
        : professionals
            .where((professional) =>
                professional.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final professional = suggestionList[index];
        return ListTile(
          title: Text(professional.name),
          onTap: () {
            _showOptionsDialog(context, professional);
            // query = professional
            //     .name;
          },
        );
      },
    );
  }
}

void _showOptionsDialog(BuildContext context, Professional professional) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Choose an option'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('Chat'),
                onTap: () {
                  // Implement logic to navigate to chat interface
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Schedule Appointment'),
                onTap: () {
                  _scheduleAppointment(context, professional);
                  // Implement logic to navigate to appointment scheduling interface
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _scheduleAppointment(BuildContext context, Professional professional) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Schedule Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
              onTap: () {
                // Implement logic to show date picker
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Time'),
              keyboardType: TextInputType.datetime,
              onTap: () {
                // Implement logic to show time picker
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Reason'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement logic to handle appointment scheduling
              Navigator.pop(context);
            },
            child: const Text('Schedule'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
