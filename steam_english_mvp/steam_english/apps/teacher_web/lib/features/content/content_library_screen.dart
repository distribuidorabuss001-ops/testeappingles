import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class ContentLibraryScreen extends StatelessWidget {
  const ContentLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Content Library')),
      body: Row(
        children: [
          // Track List (Sidebar-ish)
          Container(
            width: 300,
            decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade300))),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Tracks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                _buildTrackItem('Business English', true),
                _buildTrackItem('Phonetics Basics', false),
                _buildTrackItem('Travel Vocabulary', false),
                const Divider(),
                ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('New Track'),
                    onTap: () {}, // Open Create Track Dialog
                ),
              ],
            ),
          ),
          // Lesson List (Main Area)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Business English - Lessons', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      PrimaryButton(text: 'New Lesson', onPressed: () {}), // Open Create Lesson Dialog
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                            _buildLessonCard(context, 'Module 1: Introductions', 'Beginner', true),
                            _buildLessonCard(context, 'Module 2: Emails', 'Intermediate', false),
                             _buildLessonCard(context, 'Module 3: Negotiations', 'Advanced', false),
                        ],
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackItem(String title, bool isSelected) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      onTap: () {},
    );
  }

  Widget _buildLessonCard(BuildContext context, String title, String level, bool assigned) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Level: $level'),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                OutlinedButton(
                    onPressed: () {
                         showDialog(context: context, builder: (_) => const AssignLessonDialog());
                    },
                    child: const Text('Assign'),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
            ],
        ),
      ),
    );
  }
}

class AssignLessonDialog extends StatelessWidget {
    const AssignLessonDialog({super.key});

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
            title: const Text('Assign Lesson'),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    const Text('Assign "Module 1: Introductions" to:'),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                        items: const [
                            DropdownMenuItem(value: 'g1', child: Text('John Doe (1:1)')),
                            DropdownMenuItem(value: 'g2', child: Text('Marketing Team (Pair)')),
                        ],
                        onChanged: (v) {},
                        decoration: const InputDecoration(labelText: 'Select Group', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    // Date Picker would go here
                ],
            ),
            actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                PrimaryButton(text: 'Assign', onPressed: () => Navigator.pop(context)),
            ],
        );
    }
}
