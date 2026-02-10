import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String id,
    @JsonKey(name: 'school_id') required String schoolId,
    required String title,
    required String type, // 'phonetics', 'vocab', 'structures', 'exercises'
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
