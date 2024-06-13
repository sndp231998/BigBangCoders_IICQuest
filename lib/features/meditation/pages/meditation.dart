import 'package:flutter/material.dart';

class MeditationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'When we meditate, we inject far-reaching and long-lasting benefits into our lives: We lower our stress levels, we get to know our pain, we connect better, we improve our focus, and we\'re kinder to ourselves. Let us walk you through the basics in our new mindful guide on how to meditate.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            const Text(
              'What is Meditation?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
                'https://www.mindful.org/content/uploads/how-to-meditate-1024x640.jpg'),
            const SizedBox(height: 8.0),

            const Text(
              'Meditation is a practice in which an individual uses a technique – such as mindfulness, or focusing the mind on a particular object, thought, or activity – to train attention and awareness, and achieve a mentally clear and emotionally calm and stable state.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Why Learn to Meditate?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'A selection of benefits that are associated with learning how to meditate.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Image.network(
                'https://cdn.shortpixel.ai/spai/q_lossy+w_768+to_avif+ret_img/www.mindful.org/content/uploads/how-to-meditate-1024x730.png'),
            const SizedBox(height: 16.0),
            const Text(
              'How to Meditate',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Meditation is something everyone can do, here’s how.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Meditation is simpler (and harder) than most people think. Read these steps, make sure you’re somewhere where you can relax into this process, set a timer, and give it a shot:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '1) Take a seat',
              style: TextStyle(fontSize: 16.0),
            ),
            const Text(
              'Find place to sit that feels calm and quiet to you.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Add more steps similarly
            const SizedBox(height: 16.0),
            Image.network(
                'https://cdn.shortpixel.ai/spai/q_lossy+w_768+to_avif+ret_img/www.mindful.org/content/uploads/why-learn-to-meditate-e1619731924318-1024x799.png'),
            const SizedBox(height: 16.0),
            const Text(
              'Explore our Mindful Meditation Guide',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Featuring various styles, benefits, and free audio practices to enrich your daily life through meditation.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Image.network(
                'https://cdn.shortpixel.ai/spai/q_lossy+w_768+to_avif+ret_img/www.mindful.org/content/uploads/some-basic-meditations-1024x692.png'),
            const SizedBox(height: 16.0),
            const Text(
              'Kickstart your journey with our free 5-day Meditation for Beginners guide, delivering essential insights and guided practices directly to your inbox. Enter your email to get started.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'More Styles of Mindfulness Meditation',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Once you have explored a basic seated meditation practice, you might want to consider other forms of meditation including walking and lying down. Whereas the previous meditations used the breath as a focal point for practice, these meditations below focus on different parts of the body.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Image.network(
                'https://cdn.shortpixel.ai/spai/q_lossy+w_768+to_avif+ret_img/www.mindful.org/content/uploads/beyond-the-beginning-1024x839.png'),
            const SizedBox(height: 16.0),
            const Text(
              'Additional Resources & Articles',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Mindful has many resources to help you live a more mindful life and tap into the best of who you are:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Image.network(
                  'https://www.mindful.org/content/uploads/Blue-circle.png'),
            ),
            const SizedBox(height: 16.0),

            const Text(
              'Get mindfulness meditation practices, research, and special offers from our Mindful community delivered to you.',
              style: TextStyle(fontSize: 16.0),
            ),

            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
