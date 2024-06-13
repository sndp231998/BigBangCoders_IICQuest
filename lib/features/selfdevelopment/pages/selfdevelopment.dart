import 'package:flutter/material.dart';

class SelfDevelopment extends StatefulWidget {
  const SelfDevelopment({super.key});

  @override
  State<SelfDevelopment> createState() => _SelfDevelopmentState();
}

void _buildAntiLoneliness(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Peer Support Groups'),
              subtitle: Text(
                  'Virtual spaces where students can connect with peers facing similar challenges.'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Mentorship Programs'),
              subtitle: Text(
                  'Connecting students with mentors who can offer guidance and support.'),
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Community Events'),
              subtitle: Text(
                  'Organizing virtual or in-person events to foster a sense of community.'),
            ),
            ListTile(
              leading: Icon(Icons.self_improvement),
              title: Text('Mindfulness and Meditation'),
              subtitle: Text(
                  'Guided sessions to help students manage feelings of loneliness.'),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Social Skill Workshops'),
              subtitle: Text(
                  'Training on how to build and maintain meaningful relationships.'),
            ),
          ],
        ),
      );
    },
  );
}

void _buildSecondLife(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.explore),
              title: Text('Virtual Reality Experiences'),
              subtitle: Text(
                  'Safe and controlled environments where students can explore new worlds and scenarios.'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Role-Playing Scenarios'),
              subtitle: Text(
                  'Interactive exercises where students can practice social interactions and problem-solving.'),
            ),
            ListTile(
              leading: Icon(Icons.palette),
              title: Text('Creative Expression Platforms'),
              subtitle: Text(
                  'Tools for students to express themselves through art, writing, or other creative outlets.'),
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text('Goal Setting and Achievement Tracking'),
              subtitle: Text(
                  'Features to help students set personal goals and track their progress.'),
            ),
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text('Life Simulation Games'),
              subtitle: Text(
                  'Engaging games that simulate real-life decisions and consequences.'),
            ),
          ],
        ),
      );
    },
  );
}

void _buildSelfImage(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.sentiment_satisfied),
              title: Text('Positive Affirmations'),
              subtitle: Text(
                  'Daily affirmations to boost self-esteem and confidence.'),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Body Positivity Resources'),
              subtitle: Text(
                  'Information and support on embracing and loving one’s body.'),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Personal Growth Journals'),
              subtitle: Text(
                  'Digital journals for students to reflect on their thoughts, feelings, and progress.'),
            ),
            ListTile(
              leading: Icon(Icons.self_improvement),
              title: Text('Self-Compassion Exercises'),
              subtitle: Text(
                  'Activities and practices to cultivate self-compassion and reduce self-criticism.'),
            ),
            ListTile(
              leading: Icon(Icons.thumb_up),
              title: Text('Feedback and Encouragement'),
              subtitle: Text(
                  'Systems for receiving positive feedback from peers and mentors.'),
            ),
          ],
        ),
      );
    },
  );
}

class _SelfDevelopmentState extends State<SelfDevelopment> {
  final List<Map<String, dynamic>> _list = [
    {
      'title': 'Anti Loneliness',
      'thumbnail': 'assets/images/antiloneliness.jpg',
      'id': 1,
    },
    {
      'title': 'Second Life',
      'thumbnail': 'assets/images/secondlife.jpeg',
      'id': 2,
    },
    {
      'title': 'Self Image',
      'thumbnail': 'assets/images/selfimage.jpg',
      'id': 3,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Self Development'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: _list.map((item) => _buildCard(item)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        if (item['id'] == 1) {
          _buildAntiLoneliness(context);
        }
        if (item['id'] == 2) {
          _buildSecondLife(context);
        }
        if (item['id'] == 3) {
          _buildSelfImage(context);
        }
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  item['thumbnail']!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Chapters: 24'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
