import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hackathon/core/constants.dart';
import 'package:hackathon/features/collaboration/pages/collaboration.dart';
import 'package:hackathon/features/consult/pages/consult.dart';
import 'package:hackathon/features/profile/pages/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onItemTapped(int value) {
    if (value == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
    if (value == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Collaboration()));
    }
    if (value == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Consult()));
    }
    if (value == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Profile()));
    }
  }

  List<Map<String, dynamic>> _posts = [];

  final List _homeWidgets = [
    {
      'icon': Icons.healing,
      'title': 'Health services',
    },
    {
      'icon': Icons.notes,
      'title': 'Our Blogs',
    },
    {
      'icon': Icons.library_books,
      'title': 'Online resources and articles',
    },
  ];

  void fetchPosts() async {
    final url = Uri.parse('${Constants.API_BASE}api/v1/posts');
    final response = await http.get(
      url,
    );

    // Perform the login API call

    // Check if the response is successful
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        _posts = [...result['content']];
      });
      // Login successful, do something (e.g., navigate to home page)
      // if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Posts fetched successful')),
      );
      // Navigate to the home page or any other destination
      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fetching failed: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String randomNumber() {
    return Random().nextInt(100).toString();
  }

  @override
  void initState() {
    fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getGreeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning!';
      } else if (hour < 18) {
        return 'Good Afternoon!';
      } else {
        return 'Good Evening!';
      }
    }

    IconData getIcon() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return Icons.wb_sunny; // Morning icon
      } else if (hour < 18) {
        return Icons.brightness_5; // Afternoon icon
      } else {
        return Icons.nights_stay; // Evening icon
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 350,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              // Additional content related to student mental health support
              const SizedBox(height: 20),
              GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _homeWidgets.length,
                itemBuilder: (context, index) {
                  return _buildScreenCard(
                    context,
                    _homeWidgets[index]['icon'],
                    _homeWidgets[index]['title'],
                  );
                },
              ),
              const SizedBox(height: 8),
              // const ListTile(
              //   leading: Icon(Icons.group),
              //   title: Text('Peer support groups'),
              // ),
              // const SizedBox(height: 8),
              // const ListTile(
              //   leading: Icon(Icons.library_books),
              //   title: Text('Online resources and articles'),
              // ),
              // const SizedBox(height: 8),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  print(post);
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[300],
                                ),
                                child: Text(post['category']['categoryTitle'],
                                    style: const TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    // 'https://randomuser.me/api/portraits/men/${randomNumber()}.jpg'),
                                    'https://randomuser.me/api/portraits/men/21.jpg'),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                post['user']['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.thumb_up_alt_outlined),
                              Text('134'),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.comment_outlined),
                              Text('14'),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.share_outlined),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Add more support options as needed
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Collaboration'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Consult'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add onPressed action
          showModalBottomSheet(
              context: context,
              // isScrollControlled: true,
              builder: (context) {
                return const ChatWithAISheet();
              });
        },
        child: const Icon(Icons.chat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildScreenCard(BuildContext context, IconData? icon, String? text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 4, right: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 45,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                text ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatWithAISheet extends StatefulWidget {
  const ChatWithAISheet({super.key});

  @override
  _ChatWithAISheetState createState() => _ChatWithAISheetState();
}

class _ChatWithAISheetState extends State<ChatWithAISheet> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({'text': _controller.text, 'sender': 'user'});
        _messages.add(
            {'text': _generateAIResponse(_controller.text), 'sender': 'ai'});
      });
      _controller.clear();
    }
  }

  String _generateAIResponse(String userMessage) {
    // In a real application, you would make a request to an AI service
    return 'AI response to "$userMessage"';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('Talk with AI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'user'
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                          color: message['sender'] == 'user'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
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
          ),
        ],
      ),
    );
  }
}

// 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
