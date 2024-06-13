import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hackathon/core/constants.dart';
import 'package:http/http.dart' as http;

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, String>> _comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    final url =
        Uri.parse('${Constants.API_BASE}/comments?postId=${widget.post['id']}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      setState(() {
        // _comments = data;
      });
    } else {
      throw Exception('Failed to load comments');
    }
  }

  void _submitComment(BuildContext context) async {
    final comment = _commentController.text;

    if (comment.isEmpty) {
      return;
    }

    final url = Uri.parse(
        '${Constants.API_BASE}api/v1/post/${widget.post['postId']}/comments');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'content': comment,
      }),
    );

    if (response.statusCode == 201) {
      fetchComments();
      _commentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit comment')),
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // if (widget.post['userImage'] != null)
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(widget.post['userImage']),
                  // ),
                  // else
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/consult1.jpeg'), // Placeholder image
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.post['user']['name'] ?? 'Anonymous',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.post['title'] ?? 'Title',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.post['content'] ?? 'content available',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              if (widget.post['postImage'] != null) ...[
                const SizedBox(height: 10),
                Image.network(widget.post['postImage']),
              ],
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.thumb_up_alt_outlined),
                  SizedBox(width: 10),
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
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
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
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _submitComment(context),
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
