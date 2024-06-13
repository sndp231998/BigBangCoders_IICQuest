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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChatModal(professional: professional);
                    },
                  );
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
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Leave a Feedback'),
                onTap: () {
                  _leaveFeedback(context);
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

void _leaveFeedback(BuildContext context){
  final TextEditingController _messageController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
    return AlertDialog(

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(labelText: 'Message'),
            keyboardType: TextInputType.multiline,
            onTap: () {
              // Implement logic to show date picker
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final message = _messageController.text;

            if (message.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill in all fields')),
              );
              return;
            }

            // final url = Uri.parse('YOUR_API_ENDPOINT');
            // final response = await http.post(
            //   url,
            //   headers: {'Content-Type': 'application/json'},
            //   body: jsonEncode({
            //     'professionalId': professional.id,
            //     'date': date,
            //     'time': time,
            //     'reason': reason,
            //   }),
            // );

            if (true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Feedback sent successfully!')),
              );
              Navigator.pop(context); // Close dialog
            }
            // else {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text('Failed to schedule appointment')),
            //   );
            // }
          },
          child: const Text('Send'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  },
  );
}

void _scheduleAppointment(BuildContext context, Professional professional) {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Schedule Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
              onTap: () {
                // Implement logic to show date picker
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Time'),
              keyboardType: TextInputType.datetime,
              onTap: () {
                // Implement logic to show time picker
              },
            ),
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(labelText: 'Reason'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final date = _dateController.text;
              final time = _timeController.text;
              final reason = _reasonController.text;

              if (date.isEmpty || time.isEmpty || reason.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }

              // final url = Uri.parse('YOUR_API_ENDPOINT');
              // final response = await http.post(
              //   url,
              //   headers: {'Content-Type': 'application/json'},
              //   body: jsonEncode({
              //     'professionalId': professional.id,
              //     'date': date,
              //     'time': time,
              //     'reason': reason,
              //   }),
              // );

              if (true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Appointment scheduled successfully!')),
                );
                Navigator.pop(context); // Close dialog
              }
              // else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Failed to schedule appointment')),
              //   );
              // }
            },
            child: const Text('Schedule'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

class ChatModal extends StatefulWidget {
  final Professional professional;

  const ChatModal({super.key, required this.professional});

  @override
  _ChatModalState createState() => _ChatModalState();
}

class _ChatModalState extends State<ChatModal> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages.addAll([
      {'text': 'Hi there!', 'sender': 'John Doe'},
      {'text': 'Hello! How can I help you?', 'sender': 'You'},
    ]);
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({'text': _controller.text, 'sender': 'You'});
        // Dummy AI response for now
        _messages.add({'text': 'Got it!', 'sender': widget.professional.name});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Chat with ${widget.professional.name}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Align(
                      alignment: message['sender'] == 'You'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message['sender'] == 'You'
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text']!,
                          style: TextStyle(
                            color: message['sender'] == 'You'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
