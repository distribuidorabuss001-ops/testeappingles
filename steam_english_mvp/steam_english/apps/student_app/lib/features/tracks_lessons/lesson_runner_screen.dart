import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class LessonRunnerScreen extends StatefulWidget {
  final String lessonId;
  const LessonRunnerScreen({super.key, required this.lessonId});

  @override
  State<LessonRunnerScreen> createState() => _LessonRunnerScreenState();
}

class _LessonRunnerScreenState extends State<LessonRunnerScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Module 2: Emails')),
      body: Column(
        children: [
            LinearProgressIndicator(value: (_currentStep + 1) / 3, color: AppColors.primary),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildStepContent(),
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        if (_currentStep > 0)
                            OutlinedButton(onPressed: () => setState(() => _currentStep--), child: const Text('Back'))
                        else
                            const SizedBox(),
                            
                        PrimaryButton(
                            text: _currentStep == 2 ? 'Finish' : 'Next',
                            onPressed: () {
                                if (_currentStep < 2) {
                                    setState(() => _currentStep++);
                                } else {
                                    Navigator.pop(context); // Finish
                                }
                            },
                        ),
                    ],
                ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
      switch (_currentStep) {
          case 0:
            return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text('Reading', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    SizedBox(height: 16),
                    Text('Formal emails usually start with "Dear Mr./Ms. [Last Name]". Avoid using slang. Always include a clear subject line.'),
                    Divider(height: 32),
                    Text('Vocab:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('• Inquiry: A question\n• Regards: Closing salutation'),
                ],
            );
          case 1:
            return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text('Quiz', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    SizedBox(height: 16),
                    Text('Which starts a formal email?'),
                    SizedBox(height: 16),
                    ListTile(title: Text('A) Hey there!'), shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey))),
                    SizedBox(height: 8),
                    ListTile(title: Text('B) Dear Mr. Smith,'), shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey))),
                ],
            );
          case 2:
             return const Center(
                 child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                         Icon(Icons.check_circle, size: 64, color: Colors.green),
                         SizedBox(height: 16),
                         Text('Lesson Completed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                         Text('+50 XP'),
                     ],
                 ),
             );
          default:
            return const SizedBox();
      }
  }
}
