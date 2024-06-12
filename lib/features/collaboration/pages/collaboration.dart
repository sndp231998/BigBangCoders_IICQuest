import 'package:flutter/material.dart';

class Collaboration extends StatefulWidget {
  const Collaboration({super.key});

  @override
  State<Collaboration> createState() => _CollaborationState();
}

class _CollaborationState extends State<Collaboration> {
  final List<String> _tags = [
    'sports',
    'health',
    'religion',
    'nature',
    'beauty',
    'food',
    'recreation',
  ];

  final List<Map<String, String>> _posts = [
    {
      'userImage': 'https://via.placeholder.com/150',
      'userName': 'John Doe',
      'title': 'Sample Post Title',
      'postContent': 'This is a sample post content.',
      'postImage': 'https://via.placeholder.com/300'
    },
  ];

  String _title = '';
  String _imageUrl = '';
  String _description = '';

  final _formKey = GlobalKey<FormState>();

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
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: Text(item, style: const TextStyle(fontSize: 16)),
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
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(post['userImage']!),
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
                        const SizedBox(height: 10),
                        // Text(post['postContent']!),
                        // const SizedBox(height: 10),
                        // if (post['postImage'] != null)
                        //   Image.network(post['postImage']!),
                        // const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.thumb_up_alt_outlined),
                            Icon(Icons.comment_outlined),
                            Icon(Icons.share_outlined),
                          ],
                        ),
                      ],
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
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Tag'),
                            value: _tags[0],
                            onChanged: (String? newValue) {
                              setState(() {
                                // Handle dropdown value change here
                              });
                            },
                            items: _tags
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
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
