import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../models/post.dart';
import '../retrofit/api_client.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.apiClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final ApiClient apiClient;

  Future<void> _onPostFetched(
      PostFetched event,
      Emitter<PostState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await apiClient.fetchPosts(0, _postLimit);
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await apiClient.fetchPosts(state.posts.length, _postLimit);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}