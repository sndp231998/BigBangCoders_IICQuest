import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final Map<String, String> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> comments = [
      {
        'userName': 'Alice Johnson',
        'comment': 'This is a great post!',
      },
      {
        'userName': 'Bob Smith',
        'comment': 'I found this information very useful.',
      },
      {
        'userName': 'Charlie Brown',
        'comment': 'Thanks for sharing this!',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(post['title'] ?? 'Post Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                post['postContent']!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              if (post['postImage'] != null) Image.network(post['postImage']!),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.thumb_up_alt_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  // Icon(Icons.comment_outlined),
                  Icon(Icons.share_outlined),
                ],
              ),
              const Divider(height: 30),
              const Text(
                'Comments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    title: Text(
                      comment['userName']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(comment['comment']!),
                  );
                },
              ),
              const Divider(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Logic to send a comment
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
