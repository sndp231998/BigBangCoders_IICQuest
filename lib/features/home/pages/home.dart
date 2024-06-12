import 'package:flutter/material.dart';
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

  final List<Map<String, String>> _posts = [
    {
      'userImage': 'https://via.placeholder.com/150',
      'userName': 'John Doe',
      'title': 'Sample Post Title',
      'postContent': 'This is a sample post content.',
      'postImage': 'https://via.placeholder.com/300'
    },
    {
      'userImage': 'https://via.placeholder.com/150',
      'userName': 'John Doe',
      'title': 'Sample Post Title',
      'postContent': 'This is a sample post content.',
      'postImage': 'https://via.placeholder.com/300'
    },
    {
      'userImage': 'https://via.placeholder.com/150',
      'userName': 'John Doe',
      'title': 'Sample Post Title',
      'postContent': 'This is a sample post content.',
      'postImage': 'https://via.placeholder.com/300'
    },
  ];

  final List _homeWidgets = [
    {
      'icon': Icons.healing,
      'title': 'Health services',
    },
    {
      'icon': Icons.group,
      'title': 'Peer support groups',
    },
    {
      'icon': Icons.library_books,
      'title': 'Online resources and articles',
    },
  ];

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
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
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
                                child: const Text('health',
                                    style: TextStyle(fontSize: 12)),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[300],
                                ),
                                child: const Text('fitness',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(post['userImage']!),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                post['userName']!,
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
