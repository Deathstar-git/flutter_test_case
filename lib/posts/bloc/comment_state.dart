part of 'comment_bloc.dart';

enum CommentStatus { initial, success, failure }

class CommentState extends Equatable{
  const CommentState({
    this.status = CommentStatus.initial,
    this.comments = const <Comment>[],
    this.hasReachedMax = false,
  });

  final CommentStatus status;
  final List<Comment> comments;
  final bool hasReachedMax;

  CommentState copyWith({
    CommentStatus? status,
    List<Comment>? comments,
    bool? hasReachedMax,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CommentState { status: $status ,  hasReachedMax: $hasReachedMax,  comments: $comments}''';
  }

  @override
  List<Object> get props => [status, comments, hasReachedMax];
}