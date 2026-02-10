import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_submission.freezed.dart';
part 'project_submission.g.dart';

enum SubmissionStatus { submitted, reviewed, needsRevision, approved }

@freezed
class ProjectSubmission with _$ProjectSubmission {
  const factory ProjectSubmission({
    required String id,
    @JsonKey(name: 'project_id') required String projectId,
    @JsonKey(name: 'student_id') required String studentId,
    @JsonKey(name: 'submission_type') required String submissionType, // link, file
    @JsonKey(name: 'submission_url_or_path') required String submissionUrlOrPath,
    String? notes,
    @Default(SubmissionStatus.submitted) SubmissionStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ProjectSubmission;

  factory ProjectSubmission.fromJson(Map<String, dynamic> json) =>
      _$ProjectSubmissionFromJson(json);
}
