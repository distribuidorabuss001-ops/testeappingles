import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    @JsonKey(name: 'school_id') required String schoolId,
    @JsonKey(name: 'lesson_group_id') required String lessonGroupId,
    @JsonKey(name: 'teacher_id') required String teacherId,
    required String title,
    String? description,
    String? objectives,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
