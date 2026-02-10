import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Learning')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
            _buildTrackCard(context, 'Business English', '3/10 Lessons Completed', 0.3),
            _buildTrackCard(context, 'Travel Vocabulary', '0/5 Lessons Completed', 0.0),
        ],
      ),
    );
  }

  Widget _buildTrackCard(BuildContext context, String title, String subtitle, double progress) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], color: AppColors.secondary),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
        ),
        children: [
            ListTile(
                title: const Text('Module 1: Introductions'),
                leading: const Icon(Icons.check_circle, color: Colors.green),
                onTap: () {
                    // Re-visit lesson
                },
            ),
            ListTile(
                title: const Text('Module 2: Emails'),
                leading: const Icon(Icons.play_circle_fill, color: AppColors.primary),
                onTap: () {
                    Navigator.of(context).pushNamed('/lesson/123');
                },
            ),
            ListTile(
                title: const Text('Module 3: Negotiations'),
                leading: const Icon(Icons.lock, color: Colors.grey),
                enabled: false,
            ),
        ],
      ),
    );
  }
}
