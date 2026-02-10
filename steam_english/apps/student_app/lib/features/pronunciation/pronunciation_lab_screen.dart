import 'package:flutter/material.dart';
import 'package:steam_ui/ui.dart';

class PronunciationLabScreen extends StatefulWidget {
  const PronunciationLabScreen({super.key});

  @override
  State<PronunciationLabScreen> createState() => _PronunciationLabScreenState();
}

class _PronunciationLabScreenState extends State<PronunciationLabScreen> {
  bool _isRecording = false;
  bool _isProcessing = false;
  String? _resultText;
  double? _resultScore;

  Future<void> _toggleRecording() async {
      if (_isRecording) {
            // Stop recording and process
            setState(() {
                _isRecording = false;
                _isProcessing = true;
            });
            
            // Simulate processing
            await Future.delayed(const Duration(seconds: 2));
            
            setState(() {
                _isProcessing = false;
                _resultText = "The quick brown fox jumps over the lazy dog.";
                _resultScore = 85.0;
            });
      } else {
          // Start recording
          setState(() {
              _isRecording = true;
              _resultText = null;
              _resultScore = null;
          });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pronunciation Lab')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
                'Read the following sentence:',
                style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                ),
                child: const Text(
                    'The quick brown fox jumps over the lazy dog.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                ),
            ),
            const SizedBox(height: 48),
            
            // Microphone Button
            GestureDetector(
                onTap: _isProcessing ? null : _toggleRecording,
                child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: _isRecording ? Colors.red : AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                            BoxShadow(
                                color: (_isRecording ? Colors.red : AppColors.primary).withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                            )
                        ]
                    ),
                    child: Icon(
                        _isRecording ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 40,
                    ),
                ),
            ),
            const SizedBox(height: 16),
            Text(
                _isProcessing ? 'Analyzing...' : (_isRecording ? 'Tap to Stop' : 'Tap to Record'),
                style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 48),
            
            // Results
            if (_resultScore != null) ...[
                const Divider(),
                const SizedBox(height: 16),
                const Text('Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                            'Score: ${_resultScore!.toInt()}%',
                             style: TextStyle(
                                 fontSize: 32, 
                                 fontWeight: FontWeight.bold, 
                                 color: _resultScore! > 80 ? Colors.green : Colors.orange
                             ),
                        ),
                    ],
                ),
                const SizedBox(height: 8),
                Text('You said: "$_resultText"'),
            ]
          ],
        ),
      ),
    );
  }
}
