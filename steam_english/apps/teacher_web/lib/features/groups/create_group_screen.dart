import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _nameController = TextEditingController();
  String _selectedType = '1:1'; // '1:1' or 'Pair'
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Lesson Group')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Group Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  hintText: 'e.g., Business English - John Doe',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Group Type'), 
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildTypeOption('1:1 (Individual)', '1:1'),
                  const SizedBox(width: 16),
                  _buildTypeOption('Pair (Dupla)', 'Pair'),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Add Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {}, 
                icon: const Icon(Icons.person_add), 
                label: const Text('Select Student')
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                    text: 'Create Group', 
                    onPressed: () {
                        // TODO: Implement create logic
                        Navigator.pop(context);
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeOption(String label, String value) {
    final isSelected = _selectedType == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) setState(() => _selectedType = value);
      },
    );
  }
}
