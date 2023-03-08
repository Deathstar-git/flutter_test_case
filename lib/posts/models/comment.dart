import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

part 'comment.g.dart';

@unfreezed
class Comment with _$Comment {
  factory Comment({
    required final int id,
    required String name,
    required String email,
    required String body,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json)
  => _$CommentFromJson(json);
}