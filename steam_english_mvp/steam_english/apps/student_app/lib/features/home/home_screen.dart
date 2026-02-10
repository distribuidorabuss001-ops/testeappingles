import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steam English'),
        actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Student!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildActionCard(
              context,
              title: 'Next Lesson',
              subtitle: 'Business English - Module 2: Emails',
              color: AppColors.primary,
              icon: Icons.play_lesson,
              onTap: () => Navigator.of(context).pushNamed('/lesson/123'),
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'My Tracks',
              subtitle: 'View all courses',
              color: Colors.blueGrey,
              icon: Icons.list_alt,
              onTap: () => Navigator.of(context).pushNamed('/tracks'),
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'Pronunciation Lab',
              subtitle: 'Practice your speaking skills',
              color: AppColors.secondary,
              icon: Icons.mic,
              onTap: () => Navigator.of(context).pushNamed('/pronunciation'),
            ),
            const SizedBox(height: 16),
             _buildActionCard(
              context,
              title: 'Projects',
              subtitle: '1 Assignment Due',
              color: Colors.orange,
              icon: Icons.assignment,
              onTap: () => Navigator.of(context).pushNamed('/projects'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
