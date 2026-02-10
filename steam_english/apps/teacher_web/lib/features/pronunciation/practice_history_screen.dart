import 'package:flutter/material.dart';

class PracticeHistoryScreen extends StatelessWidget {
  const PracticeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practice History - John Doe')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
           _buildHistoryItem('The quick brown fox...', '95%', DateTime.now()),
           _buildHistoryItem('I would like to order a coffee.', '70%', DateTime.now().subtract(const Duration(days: 1))),
           _buildHistoryItem('Can you help me with this?', '85%', DateTime.now().subtract(const Duration(days: 2))),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String text, String score, DateTime date) {
    return Card(
      child: ListTile(
        title: Text(text),
        subtitle: Text('Date: ${date.toLocal().toString().split('.')[0]}'),
        trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: int.parse(score.replaceAll('%','')) > 80 ? Colors.green.shade100 : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
            ),
            child: Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
