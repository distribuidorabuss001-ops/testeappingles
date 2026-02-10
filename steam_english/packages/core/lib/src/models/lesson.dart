import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    @JsonKey(name: 'track_id') required String trackId,
    required String title,
    String? level,
    @JsonKey(name: 'content_json') required Map<String, dynamic> contentJson,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
