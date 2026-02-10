import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lesson_group.dart';

part 'lesson_group_repository.g.dart';

class LessonGroupRepository {
  final SupabaseClient _supabase;

  LessonGroupRepository(this._supabase);

  Future<List<LessonGroup>> getTeacherGroups(String teacherId) async {
    final response = await _supabase
        .from('lesson_groups')
        .select()
        .eq('teacher_id', teacherId);
    return (response as List).map((e) => LessonGroup.fromJson(e)).toList();
  }

  Future<void> createGroup(LessonGroup group) async {
    await _supabase.from('lesson_groups').insert(group.toJson());
  }
}

@Riverpod(keepAlive: true)
LessonGroupRepository lessonGroupRepository(LessonGroupRepositoryRef ref) {
  return LessonGroupRepository(Supabase.instance.client);
}
