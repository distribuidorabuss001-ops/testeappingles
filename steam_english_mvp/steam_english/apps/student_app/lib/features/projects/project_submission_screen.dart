import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class ProjectSubmissionScreen extends StatefulWidget {
  const ProjectSubmissionScreen({super.key});

  @override
  State<ProjectSubmissionScreen> createState() => _ProjectSubmissionScreenState();
}

class _ProjectSubmissionScreenState extends State<ProjectSubmissionScreen> {
  final _linkController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Project')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Text('Start-up Pitch', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Create a 2-minute pitch deck presentation for a fictional start-up. Focus on "Problem", "Solution", and "Market".'),
              const SizedBox(height: 32),
              
              const Text('Submission Type', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
               Row(
                   children: [
                       ChoiceChip(label: const Text('Link (Drive/Slides)'), selected: true, onSelected: (_){}),
                       const SizedBox(width: 16),
                       ChoiceChip(label: const Text('Upload File'), selected: false, onSelected: (_){}),
                   ],
               ),
               const SizedBox(height: 24),
               TextField(
                   controller: _linkController,
                   decoration: const InputDecoration(
                       labelText: 'Paste Link URL',
                       border: OutlineInputBorder(),
                       prefixIcon: Icon(Icons.link),
                   ),
               ),
               const SizedBox(height: 32),
               SizedBox(
                   width: double.infinity,
                   child: PrimaryButton(
                       text: 'Submit Assignment', 
                       onPressed: () {
                           // Submit logic
                           Navigator.pop(context);
                       }
                   ),
               ),
          ],
        ),
      ),
    );
  }
}
