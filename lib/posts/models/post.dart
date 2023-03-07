import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

part 'post.g.dart';

@unfreezed
class Post with _$Post {
  factory Post({
    required final int userId,
    required final int id,
    required String title,
    required String body,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json)
  => _$PostFromJson(json);
}