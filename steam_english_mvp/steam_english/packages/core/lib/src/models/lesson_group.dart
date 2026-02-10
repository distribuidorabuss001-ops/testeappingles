import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_group.freezed.dart';
part 'lesson_group.g.dart';

@freezed
class LessonGroup with _$LessonGroup {
  const factory LessonGroup({
    required String id,
    @JsonKey(name: 'school_id') required String schoolId,
    @JsonKey(name: 'teacher_id') required String teacherId,
    required String name,
    String? level,
    String? goal,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _LessonGroup;

  factory LessonGroup.fromJson(Map<String, dynamic> json) =>
      _$LessonGroupFromJson(json);
}
