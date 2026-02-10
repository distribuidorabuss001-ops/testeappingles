import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Project')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TextField(
                  decoration: InputDecoration(
                      labelText: 'Project Title',
                      border: OutlineInputBorder(),
                  ),
               ),
               const SizedBox(height: 16),
               const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                  ),
               ),
               const SizedBox(height: 16),
               DropdownButtonFormField<String>(
                   items: const [
                       DropdownMenuItem(value: 'g1', child: Text('Business English - Group A')),
                   ],
                   onChanged: (v) {},
                   decoration: const InputDecoration(labelText: 'Assign to Group', border: OutlineInputBorder()),
               ),
               const SizedBox(height: 16),
               // Date Picker
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'Due Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                  ),
               ),
               const SizedBox(height: 32),
               SizedBox(
                   width: double.infinity,
                   child: PrimaryButton(text: 'Create Project', onPressed: () => Navigator.pop(context)),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
