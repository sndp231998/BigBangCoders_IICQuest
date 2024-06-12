import 'package:flutter/material.dart';
import 'package:hackathon/features/auth/pages/login_page.dart';
import 'package:hackathon/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Consultant Dashboard'),
          actions: [
            IconButton(
                onPressed: () {
                  // logout
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  authProvider.setId = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                icon: const Icon(Icons.logout)),
            const SizedBox(
              width: 5,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Appointments', icon: Icon(Icons.calendar_today)),
              Tab(text: 'Chats', icon: Icon(Icons.chat)),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              // First tab content
              AppointmentsTab(),
              // Second tab content
              ChatsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy appointment data
    final List<Map<String, String>> appointments = [
      {
        'date': '2023-06-15',
        'time': '10:00 AM',
        'doctor': 'Dr. John Doe',
        'specialty': 'Cardiologist',
      },
      {
        'date': '2023-06-16',
        'time': '2:00 PM',
        'doctor': 'Dr. Jane Smith',
        'specialty': 'Dermatologist',
      },
      {
        'date': '2023-06-17',
        'time': '11:00 AM',
        'doctor': 'Dr. Sam Wilson',
        'specialty': 'Neurologist',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${appointment['date']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Time: ${appointment['time']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Name: ${appointment['doctor']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Specialty: ${appointment['specialty']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy chat data
    final List<Map<String, String>> chats = [
      {
        'name': 'John Doe',
        'lastMessage': 'See you tomorrow!',
        'time': '10:30 AM',
        'profileImage':
            'https://via.placeholder.com/150', // Replace with a real image URL
      },
      {
        'name': 'Jane Smith',
        'lastMessage': 'Let’s catch up later.',
        'time': '9:45 AM',
        'profileImage':
            'https://via.placeholder.com/150', // Replace with a real image URL
      },
      {
        'name': 'Sam Wilson',
        'lastMessage': 'Can you send me the files?',
        'time': 'Yesterday',
        'profileImage':
            'https://via.placeholder.com/150', // Replace with a real image URL
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['profileImage']!),
            ),
            title: Text(
              chat['name']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(chat['lastMessage']!),
            trailing: Text(chat['time']!),
            onTap: () {
              // Add action when chat is tapped
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ChatModal(chat: chat);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatModal extends StatefulWidget {
  final Map<String, String> chat;

  const ChatModal({super.key, required this.chat});

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
        _messages.add({'text': 'Got it!', 'sender': widget.chat['name']!});
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
                'Chat with ${widget.chat['name']}',
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
