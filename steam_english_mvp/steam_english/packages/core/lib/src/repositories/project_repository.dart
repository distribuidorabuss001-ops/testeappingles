import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project.dart';
import '../models/project_submission.dart';

part 'project_repository.g.dart';

class ProjectRepository {
  final SupabaseClient _supabase;

  ProjectRepository(this._supabase);

  Future<List<Project>> getGroupProjects(String groupId) async {
    final response = await _supabase
        .from('projects')
        .select()
        .eq('lesson_group_id', groupId)
        .order('created_at', ascending: false);
    return (response as List).map((e) => Project.fromJson(e)).toList();
  }

  Future<List<Project>> getStudentProjects(String studentId) async {
      // In a real app we'd join with group_members but for MVP we assume we can fetch by RLS policies 
      // or we first fetch groups the student is in.
      // For simplicity/mock, let's just fetch all visible projects (RLS handles visibility)
       final response = await _supabase
        .from('projects')
        .select()
        .order('created_at', ascending: false);
     return (response as List).map((e) => Project.fromJson(e)).toList();
  }

  Future<void> createProject(Project project) async {
    await _supabase.from('projects').insert(project.toJson());
  }

  Future<void> submitProject(ProjectSubmission submission) async {
      await _supabase.from('project_submissions').insert(submission.toJson());
  }
}

@Riverpod(keepAlive: true)
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  return ProjectRepository(Supabase.instance.client);
}
