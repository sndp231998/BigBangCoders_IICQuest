import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  final List<Map<String, String>> _blogPosts = [
    {
      'title': 'Healthy Eating Habits',
      'author': 'John Doe',
      'date': 'May 15, 2023',
      'image': 'assets/images/blog1.avif',
      'content':
          "In today's interconnected world, where technology permeates every aspect of our lives, it's essential to navigate the digital landscape with vigilance and purpose. From social media platforms shaping public discourse to artificial intelligence revolutionizing industries, the pace of technological advancement is relentless. Yet, amidst this whirlwind of innovation, fundamental questions of ethics, privacy, and human connection persist. How do we ensure technology serves humanity rather than dictates its course? As we embrace digital transformation, fostering a balance between innovation and ethical stewardship becomes paramount. It's a journey that demands continuous reflection, collaboration across disciplines, and a commitment to values that uphold the dignity and well-being of all individuals",
    },
    {
      'title': 'Navigate the digital landscape with vigilance and purpose',
      'author': 'Jane Smith',
      'date': 'June 2, 2023',
      'image': 'assets/images/digital.jpg',
      'content':
          'In today\'s interconnected world, where technology permeates every aspect of our lives, it\'s essential to navigate the digital landscape with vigilance and purpose. From social media platforms shaping public discourse to artificial intelligence revolutionizing industries, the pace of technological advancement is relentless. Yet, amidst this whirlwind of innovation, fundamental questions of ethics, privacy, and human connection persist. How do we ensure technology serves humanity rather than dictates its course? As we embrace digital transformation, fostering a balance between innovation and ethical stewardship becomes paramount. It\'s a journey that demands continuous reflection, collaboration across disciplines, and a commitment to values that uphold the dignity and well-being of all individuals',
    },
    // Add more blog posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _blogPosts.length,
        itemBuilder: (context, index) {
          final post = _blogPosts[index];
          return GestureDetector(
            onTap: () {
              // Navigate to BlogDetailPage with post details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailPage(post: post),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      post['image']!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post['title']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${post['date']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post['content']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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

class BlogDetailPage extends StatelessWidget {
  final Map<String, String> post;

  const BlogDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 35,
                top: 20,
              ),
              child: Text(
                post['title']!,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(children: [
              Text(
                'By ${post['author']} - ${post['date']}',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.left,
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                post['image']!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              post['content']!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
