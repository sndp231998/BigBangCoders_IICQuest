import 'dart:convert';
import 'dart:math';
import 'package:app_usage/app_usage.dart';
import 'package:groq_sdk/models/chat_event.dart';
import 'package:groq_sdk/models/groq.dart';
import 'package:groq_sdk/models/groq_chat.dart';
import 'package:groq_sdk/models/groq_llm_model.dart';
import 'package:hackathon/core/utils.dart';
import 'package:hackathon/features/auth/pages/login_page.dart';
import 'package:hackathon/features/blogs/pages/blogs.dart';
import 'package:hackathon/features/collaboration/pages/post_detail.dart';
import 'package:hackathon/features/counselors/pages/counselors.dart';
import 'package:hackathon/features/health/pages/health.dart';
import 'package:hackathon/features/meditation/pages/meditation.dart';
import 'package:hackathon/features/selfdevelopment/pages/selfdevelopment.dart';
import 'package:hackathon/providers/auth_provider.dart';
import 'package:hackathon/providers/screen_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hackathon/core/constants.dart';
import 'package:hackathon/features/collaboration/pages/collaboration.dart';
import 'package:hackathon/features/consult/pages/consult.dart';
import 'package:hackathon/features/profile/pages/profile.dart';
import 'package:provider/provider.dart';

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
      'widget': const Health(),
    },
    {
      'icon': Icons.notes,
      'title': 'Our Blogs',
      'widget': const Blogs(),
    },
    {
      'icon': Icons.library_books,
      'title': 'Our Counselors',
      'widget': const Counselors(),
    },
    {
      'icon': Icons.health_and_safety_outlined,
      'title': 'Self Development',
      'widget': const SelfDevelopment(),
    },
    {
      'icon': Icons.sports,
      'title': 'Meditation',
      'widget': MeditationPage(),
    },
  ];

  List<AppUsageInfo> _infos = [];
  Duration totalDuration = const Duration();

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(hours: 24));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      if (!context.mounted) return;
      setState(() {
        _infos = infoList;
        // _isLoading = false;
      });
      for (AppUsageInfo info in infoList) {
        totalDuration += info.usage;
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

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
    super.initState();
    fetchPosts();
    getUsageStats();
  }

  @override
  Widget build(BuildContext context) {
    final screenProvider = Provider.of<ScreenProvider>(context, listen: false);
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
                  'assets/images/logo.png', // Your logo image path
                  width: 350,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                margin: const EdgeInsets.all(16.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/86.jpg'),
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sandip',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(height: 4.0),
                          Text(
                              'Screen Time: ${Utils.formatDuration(totalDuration)}')
                        ],
                      ),
                      // const Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _showNotifications(context),
                            icon: const Icon(Icons.notifications),
                            color: Colors.blueGrey,
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          IconButton(
                            onPressed: () {
                              // logout
                              final authProvider = Provider.of<AuthProvider>(
                                  context,
                                  listen: false);
                              authProvider.setId = 0;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: screenProvider.getHours == 0
                    ? const Text('')
                    : Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: screenProvider.getHours <=
                                  totalDuration.inHours.toInt()
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Text(
                          screenProvider.getHours <=
                                  totalDuration.inHours.toInt()
                              ? 'Good Job! You are under your screen time goal.'
                              : 'Oops! You exceeded your screen time goal',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
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
                    _homeWidgets[index]['widget'],
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Featured Discussions',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _posts.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostDetailPage(post: post),
                            ));
                          },
                          child: Container(
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
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      if (post['category'] != null &&
                                          post['category']['categoryTitle'] !=
                                              null)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey[300],
                                          ),
                                          child: Text(
                                            post['category']['categoryTitle'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://randomuser.me/api/portraits/men/21.jpg'),
                                      ),
                                      const SizedBox(width: 10),
                                      if (post['user'] != null &&
                                          post['user']['name'] != null)
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
                                    post['title'] ??
                                        'Title', // Handle null title case
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Empty Posts'),
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
              icon: Icon(Icons.menu_book), label: 'Discussion'),
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

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.notification_important),
                title: Text('Notification 1'),
                subtitle: Text('Details about notification 1'),
              ),
              ListTile(
                leading: Icon(Icons.notification_important),
                title: Text('Notification 2'),
                subtitle: Text('Details about notification 2'),
              ),
              ListTile(
                leading: Icon(Icons.notification_important),
                title: Text('Notification 3'),
                subtitle: Text('Details about notification 3'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScreenCard(
      BuildContext context, IconData? icon, String? text, Widget screen) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen))
      },
      child: Container(
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
  final List<ChatEvent> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late final GroqChat chat;

  void _sendMessage(BuildContext context) async {
    if (_controller.text.isNotEmpty) {
      final text = _controller.text;
      _controller.clear();
      FocusScope.of(context).unfocus();
      await chat.sendMessage(text);
    }
  }

  @override
  void initState() {
    super.initState();
    final groq =
        Groq("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");
    chat = groq.startNewChat(llama3_8b);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chat.stream.listen((event) {
        debugPrint('Received event: $event');
        setState(() {
          _messages.add(event);
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    chat.dispose();
    _controller.dispose();
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
          const Text('Instant Counselor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return message.when(
                  request: (requestEvent) {
                    return MessageItem(
                      isUserMessage: true,
                      message: requestEvent.message.content,
                    );
                  },
                  response: (responseEvent) {
                    return MessageItem(
                      isUserMessage: false,
                      message: responseEvent.response.choices.first.message,
                    );
                  },
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
                    onPressed: () => _sendMessage(context),
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

class MessageItem extends StatelessWidget {
  final bool isUserMessage;
  final String message;
  const MessageItem({
    required this.isUserMessage,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isUserMessage ? Colors.blueGrey[300] : Colors.grey[300],
        borderRadius: isUserMessage
            ? const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
      ),
      child: Text(
        message,
        textAlign: isUserMessage ? TextAlign.right : TextAlign.left,
      ),
    );
  }
}
