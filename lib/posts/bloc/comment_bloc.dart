import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../models/models.dart';
import '../retrofit/api_client.dart';

part 'comment_event.dart';
part 'comment_state.dart';

const _commentLimit = 5;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({required this.apiClient, required this.postId}) : super(const CommentState()) {
    on<CommentFetched>(
      _onCommentFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int postId;
  final ApiClient apiClient;

  Future<void> _onCommentFetched(
      CommentFetched event,
      Emitter<CommentState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CommentStatus.initial) {
        final comments = await apiClient.fetchComments(postId, _commentLimit, 0);
        return emit(
          state.copyWith(
            status: CommentStatus.success,
            comments: comments,
            hasReachedMax: false,
          ),
        );
      }
      final comments = await apiClient.fetchComments(postId, _commentLimit, state.comments.length);
      comments.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: CommentStatus.success,
          comments: List.of(state.comments)..addAll(comments),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CommentStatus.failure));
    }
  }
}