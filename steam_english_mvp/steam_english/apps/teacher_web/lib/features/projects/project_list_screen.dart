import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    const Text('Active Projects', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    PrimaryButton(text: 'New Project', onPressed: () => Navigator.pushNamed(context, '/projects/new')),
                ],
            ),
            const SizedBox(height: 24),
            _buildProjectCard(
                title: 'Start-up Pitch', 
                group: 'Business English - Group A', 
                dueDate: 'Due in 3 days', 
                status: '2/2 Submitted',
                color: Colors.blue
            ),
            _buildProjectCard(
                title: 'Travel Vlog', 
                group: 'Basic English - John Doe', 
                dueDate: 'Due tomorrow', 
                status: '0/1 Submitted',
                color: Colors.orange
            ),
        ],
      ),
    );
  }

  Widget _buildProjectCard({
      required String title,
      required String group,
      required String dueDate,
      required String status,
      required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(Icons.assignment, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$group • $dueDate'),
        trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: Text(status),
        ),
        onTap: () {
            // View details / submissions
        },
      ),
    );
  }
}
