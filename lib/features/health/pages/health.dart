import 'package:flutter/material.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Categories
              const Text(
                'Service Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryCard(
                      icon: Icons.local_hospital,
                      label: 'Hospitals',
                    ),
                    _buildCategoryCard(
                      icon: Icons.medical_services,
                      label: 'Clinics',
                    ),
                    _buildCategoryCard(
                      icon: Icons.local_pharmacy,
                      label: 'Pharmacies',
                    ),
                    _buildCategoryCard(
                      icon: Icons.fitness_center,
                      label: 'Fitness Centers',
                    ),
                    _buildCategoryCard(
                      icon: Icons.local_dining,
                      label: 'Nutritionists',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Featured Health Articles or Tips
              const Text(
                'Health Tips',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildHealthTipCard(
                title: 'Stay Hydrated',
                content:
                    'Drink at least 8 glasses of water a day to keep your body hydrated.',
              ),
              _buildHealthTipCard(
                title: 'Regular Exercise',
                content:
                    'Engage in physical activities for at least 30 minutes a day.',
              ),
              _buildHealthTipCard(
                title: 'Balanced Diet',
                content:
                    'Eat a balanced diet rich in fruits, vegetables, and lean proteins.',
              ),

              // List of Health Services
              const SizedBox(height: 20),
              const Text(
                'Available Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildServiceListTile(
                icon: Icons.local_hospital,
                title: 'City Hospital',
                subtitle: '24/7 Emergency Services',
              ),
              _buildServiceListTile(
                icon: Icons.medical_services,
                title: 'Family Clinic',
                subtitle: 'General Health Checkups',
              ),
              _buildServiceListTile(
                icon: Icons.local_pharmacy,
                title: 'HealthPlus Pharmacy',
                subtitle: 'All Medicines Available',
              ),
              _buildServiceListTile(
                icon: Icons.fitness_center,
                title: 'FitLife Gym',
                subtitle: 'Modern Fitness Equipment',
              ),
              _buildServiceListTile(
                icon: Icons.local_dining,
                title: 'NutriHealth',
                subtitle: 'Personalized Diet Plans',
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to appointment booking page
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Book an Appointment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({required IconData icon, required String label}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
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
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTipCard({required String title, required String content}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceListTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        // Handle tap on service item
      },
    );
  }
}
