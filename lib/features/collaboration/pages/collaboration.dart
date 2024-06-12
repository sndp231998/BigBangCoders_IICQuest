import 'dart:convert';
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

  String _title = '';
  String _imageUrl = '';
  String _description = '';

  final _formKey = GlobalKey<FormState>();

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

  void fetchTags() async {
    final url = Uri.parse('${Constants.API_BASE}api/v1/categories/');
    final response = await http.get(
      url,
    );

    // Check if the response is successful
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        _tags = [
          {
            'id': 99999,
            'categoryTitle': 'All',
            'categoryDescription': 'fetches everything'
          },
          ...result
        ];
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
        title: const Text('Collaboration'),
      ),
      body: Column(
        children: [
          // tags
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _tags.map((item) {
                print(item);
                return Container(
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
                    // Navigator.of(context).push(MaterialPageRoute(
                    // builder: (context) => PostDetailPage(post: post)));
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
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
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
                          const SizedBox(height: 10),
                          // Text(post['postContent']!),
                          // const SizedBox(height: 10),
                          // if (post['postImage'] != null)
                          //   Image.network(post['postImage']!),
                          // const SizedBox(height: 10),
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
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Set isScrollControlled to true
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    // Wrap the content with SingleChildScrollView
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Create Post',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                            onChanged: (value) {
                              setState(() {
                                _title = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Image URL (Optional)'),
                            onChanged: (value) {
                              setState(() {
                                _imageUrl = value;
                              });
                            },
                          ),
                          // DropdownButtonFormField<String>(
                          //   decoration: const InputDecoration(labelText: 'Tag'),
                          //   value: _tags[0]['categoryTitle'],
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       // Handle dropdown value change here
                          //     });
                          //   },
                          //   items: _tags
                          //       .map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),
                          TextFormField(
                            minLines: 3,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            onChanged: (value) {
                              setState(() {
                                _description = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Add logic to save the post
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
