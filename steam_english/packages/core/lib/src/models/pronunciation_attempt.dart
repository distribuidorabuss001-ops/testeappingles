import 'package:freezed_annotation/freezed_annotation.dart';

part 'pronunciation_attempt.freezed.dart';
part 'pronunciation_attempt.g.dart';

@freezed
class PronunciationAttempt with _$PronunciationAttempt {
  const factory PronunciationAttempt({
    required String id,
    @JsonKey(name: 'student_id') required String studentId,
    @JsonKey(name: 'target_text') required String targetText,
    String? transcript,
    @JsonKey(name: 'accuracy_score') double? accuracyScore,
    @JsonKey(name: 'audio_path') String? audioPath,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _PronunciationAttempt;

  factory PronunciationAttempt.fromJson(Map<String, dynamic> json) =>
      _$PronunciationAttemptFromJson(json);
}
