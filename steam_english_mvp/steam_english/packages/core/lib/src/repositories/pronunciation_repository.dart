import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pronunciation_attempt.dart';

part 'pronunciation_repository.g.dart';

class PronunciationRepository {
  final SupabaseClient _supabase;

  PronunciationRepository(this._supabase);

  Future<List<PronunciationAttempt>> getStudentAttempts(String studentId) async {
    final response = await _supabase
        .from('pronunciation_attempts')
        .select()
        .eq('student_id', studentId)
        .order('created_at', ascending: false);
    return (response as List).map((e) => PronunciationAttempt.fromJson(e)).toList();
  }

  Future<PronunciationAttempt> submitPronunciation({
    required String studentId,
    required String targetText,
    required File audioFile,
  }) async {
    // 1. Upload Audio
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.m4a';
    final path = 'pronunciation/$studentId/$fileName';
    await _supabase.storage.from('audio').upload(path, audioFile);

    // 2. Call Edge Function (Mocked for MVP, normally functions.invoke)
    // In a real scenario, this function would return the transcript and score immediately
    // or we poll for it. For this MVP, we will simulate the "Process" by inserting directly.
    
    // Simulate Edge Function processing result
    final mockScore = (70 + (DateTime.now().second % 30)).toDouble(); // Random score 70-99
    final mockTranscript = targetText; // Assume perfect for mock

    final response = await _supabase
        .from('pronunciation_attempts')
        .insert({
          'student_id': studentId,
          'target_text': targetText,
          'transcript': mockTranscript,
          'accuracy_score': mockScore,
          'audio_path': path,
        })
        .select()
        .single();

    return PronunciationAttempt.fromJson(response);
  }
}

@Riverpod(keepAlive: true)
PronunciationRepository pronunciationRepository(PronunciationRepositoryRef ref) {
  return PronunciationRepository(Supabase.instance.client);
}
