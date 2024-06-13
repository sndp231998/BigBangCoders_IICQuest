import 'dart:convert';
import 'package:hackathon/features/collaboration/pages/create_post.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hackathon/core/constants.dart';
import 'package:hackathon/features/collaboration/pages/post_detail.dart';

class Collaboration extends StatefulWidget {
  const Collaboration({super.key});

  @override
  State<Collaboration> createState() => _CollaborationState();
}

class _CollaborationState extends State<Collaboration> {
  List<Map<String, dynamic>> _tags = [];

  List<Map<String, dynamic>> _posts = [];

  final _formKey = GlobalKey<FormState>();

  void fetchPosts() async {
    final url = Uri.parse('${Constants.API_BASE}api/v1/posts');
    final response = await http.get(url);

    // Perform the API call

    // Check if the response is successful
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        _posts = List<Map<String, dynamic>>.from(result['content']);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Posts fetched successfully')),
      );
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

  void fetchFilteredPosts(String tagId) async {
    final url = Uri.parse('${Constants.API_BASE}api/v1/category/$tagId/posts');
    final response = await http.get(url);

    // Perform the API call

    // Check if the response is successful
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        _posts = List<Map<String, dynamic>>.from(result['content']);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Posts fetched successfully')),
      );
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

  void fetchTags() async {
    final url = Uri.parse('${Constants.API_BASE}api/v1/categories/');
    final response = await http.get(url);

    // Check if the response is successful
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        _tags = [
          {
            'categoryId': 99999,
            'categoryTitle': 'All',
            'categoryDescription': 'fetches everything'
          },
          ...List<Map<String, dynamic>>.from(result),
        ];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tags fetched successfully')),
      );
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

  @override
  void initState() {
    fetchPosts();
    fetchTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion'),
      ),
      body: Column(
        children: [
          // tags
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _tags.map((item) {
                return GestureDetector(
                  onTap: () {
                    fetchFilteredPosts(item['categoryId'].toString());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 5,
                      right: 5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                    child: Text(item['categoryTitle'],
                        style: const TextStyle(fontSize: 16)),
                  ),
                );
              }).toList(),
            ),
          ),
          // Add more widgets here for the posts

          Expanded(
            child: ListView.builder(
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(post[
                                        'userImage'] ??
                                    'https://randomuser.me/api/portraits/men/21.jpg'),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                post['user'] != null &&
                                        post['user']['name'] != null
                                    ? post['user']['name']
                                    : 'Unknown User', // Handle null user name
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post['title'] ?? 'No Title', // Handle null title
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreatePost(tags: _tags)));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
