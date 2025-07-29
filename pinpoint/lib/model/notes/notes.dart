import 'package:json_annotation/json_annotation.dart';

part 'notes.g.dart';

@JsonSerializable()
class Note {
  final String? id;
  final String content;
  final String? createdAt;

  Note({
    this.id,
    required this.content,
    this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
