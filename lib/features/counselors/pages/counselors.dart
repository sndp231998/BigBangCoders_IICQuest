import 'package:flutter/material.dart';

class Counselors extends StatefulWidget {
  const Counselors({super.key});

  @override
  State<Counselors> createState() => _CounselorsState();
}

class _CounselorsState extends State<Counselors> {
  final List<Map<String, dynamic>> _counselors = [
    {
      'name': 'Dr. John Doe',
      'specialization': 'Psychologist',
      'location': 'New York, USA',
      'image': 'assets/images/consult1.jpeg',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu risus in risus commodo malesuada.',
      'rating': 4.5,
      'reviews': 32,
    },
    {
      'name': 'Dr. Jane Smith',
      'specialization': 'Family Counselor',
      'location': 'Los Angeles, USA',
      'image': 'assets/images/consult2.jpeg',
      'description':
          'Praesent convallis, lectus quis sollicitudin volutpat, mauris lectus varius felis, et bibendum nisi arcu non libero.',
      'rating': 4.2,
      'reviews': 28,
    },
    // Add more counselors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Counselors'),
      ),
      body: ListView.builder(
        itemCount: _counselors.length,
        itemBuilder: (context, index) {
          final counselor = _counselors[index];
          return GestureDetector(
            onTap: () {
              // Navigate to CounselorDetailPage with counselor details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CounselorDetailPage(counselor: counselor),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        counselor['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            counselor['name'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            counselor['specialization'],
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            counselor['location'],
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            counselor['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Text(
                                counselor['rating'].toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '(${counselor['reviews']} reviews)',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CounselorDetailPage extends StatelessWidget {
  final Map<String, dynamic> counselor;

  const CounselorDetailPage({Key? key, required this.counselor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(counselor['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                counselor['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              counselor['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              counselor['specialization'],
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              counselor['location'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              counselor['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 5),
                Text(
                  counselor['rating'].toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  '(${counselor['reviews']} reviews)',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
