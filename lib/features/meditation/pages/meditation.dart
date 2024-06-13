import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MeditationPage extends StatelessWidget {
  // List of YouTube video URLs (for demonstration purposes)
  final List<Map<String, String>> _videos = [
    {
      'title': 'Meditation for Beginners',
      'url': 'https://www.youtube.com/embed/inpok4MKVLM',
    },
    {
      'title': 'Guided Sleep Meditation',
      'url': 'https://www.youtube.com/embed/VIDEO_ID_2',
    },
    {
      'title': 'Mindfulness Meditation',
      'url': 'https://www.youtube.com/embed/VIDEO_ID_3',
    },
    // Add more videos as needed
  ];

  // Function to play YouTube video in a WebView
  void _playVideo(BuildContext context, String videoUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Video Player'),
          ),
          body: Center(
            child: WebviewScaffold(
              url: videoUrl,
              withJavascript: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Videos'),
      ),
      body: ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return ListTile(
            title: Text(video['title'] ?? 'Video Title'),
            onTap: () => _playVideo(context, video['url'] ?? ''),
          );
        },
      ),
    );
  }
}
