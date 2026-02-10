import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/track.dart';
import '../models/lesson.dart';

part 'content_repository.g.dart';

class ContentRepository {
  final SupabaseClient _supabase;

  ContentRepository(this._supabase);

  Future<List<Track>> getTracks() async {
    final response = await _supabase.from('tracks').select().order('created_at');
    return (response as List).map((e) => Track.fromJson(e)).toList();
  }

  Future<List<Lesson>> getLessons(String trackId) async {
    final response = await _supabase
        .from('lessons')
        .select()
        .eq('track_id', trackId)
        .order('created_at');
    return (response as List).map((e) => Lesson.fromJson(e)).toList();
  }

  Future<void> createTrack(Track track) async {
    // Note: ID and CreatedAt are handled by DB usually, but for MVP we might pass them or exclude them.
    // Here we assume client generates ID or we exclude it. 
    // For simplicity in this mock, we send the whole object.
    await _supabase.from('tracks').insert(track.toJson());
  }

  Future<void> createLesson(Lesson lesson) async {
      await _supabase.from('lessons').insert(lesson.toJson());
  }
  
  Future<void> assignLesson(String lessonId, String groupId, DateTime? dueDate) async {
      await _supabase.from('lesson_assignments').insert({
          'lesson_id': lessonId,
          'lesson_group_id': groupId,
          'due_date': dueDate?.toIso8601String(),
      });
  }
}

@Riverpod(keepAlive: true)
ContentRepository contentRepository(ContentRepositoryRef ref) {
  return ContentRepository(Supabase.instance.client);
}
