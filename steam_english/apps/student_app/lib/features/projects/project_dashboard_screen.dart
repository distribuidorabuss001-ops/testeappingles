import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class ProjectDashboardScreen extends StatelessWidget {
  const ProjectDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
            _buildProjectItem(
                context, 
                'Start-up Pitch', 
                'Due in 3 days', 
                Colors.orange,
                isPending: true
            ),
            _buildProjectItem(
                context, 
                'Personal Intro Video', 
                'Submitted', 
                Colors.green,
                isPending: false
            ),
        ],
      ),
    );
  }

  Widget _buildProjectItem(BuildContext context, String title, String status, Color color, {required bool isPending}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const SizedBox(height: 8),
                Row(children: [
                    Icon(Icons.schedule, size: 16, color: color),
                    const SizedBox(width: 4),
                    Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 8),
                const Text('Create a 2-minute pitch deck presentation...'),
            ],
        ),
        trailing: isPending ? const Icon(Icons.arrow_forward_ios) : const Icon(Icons.check_circle, color: Colors.green),
        onTap: isPending ? () {
             Navigator.pushNamed(context, '/projects/submit');
        } : null,
      ),
    );
  }
}
