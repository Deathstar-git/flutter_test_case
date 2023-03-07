// import 'dart:async';
// import 'dart:convert';
//
// import 'package:aspirity_test_case/posts/retrofit/api_client.dart';
// import 'package:bloc/bloc.dart';
// import 'package:bloc_concurrency/bloc_concurrency.dart';
// import 'package:equatable/equatable.dart';
// import 'package:stream_transform/stream_transform.dart';
//
// import '../models/post.dart';
//
// part 'post_event.dart';
// part 'post_state.dart';
//
// const  _postLimit = 20;
// const throttleDuration = Duration(milliseconds: 100);
//
// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return droppable<E>().call(events.throttle(duration), mapper);
//   };
// }
//
// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc({required this.client}) : super(const PostState()) {
//     on<PostFetched>(
//       _onPostFetched,
//       transformer: throttleDroppable(throttleDuration),
//     );
//   }
//
//   final ApiClient client;
//
//   Future<void> _onPostFetched(
//       PostFetched event,
//       Emitter<PostState> emit,
//       ) async {
//     if (state.hasReachedMax) return;
//     try {
//       if (state.status == PostStatus.initial) {
//         final posts = await _fetchPosts();
//         return emit(
//           state.copyWith(
//             status: PostStatus.success,
//             posts: posts,
//             hasReachedMax: false,
//           ),
//         );
//       }
//       final posts = await _fetchPosts(state.posts.length);
//       posts.isEmpty
//           ? emit(state.copyWith(hasReachedMax: true))
//           : emit(
//         state.copyWith(
//           status: PostStatus.success,
//           posts: List.of(state.posts)..addAll(posts),
//           hasReachedMax: false,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: PostStatus.failure));
//     }
//   }
//   //реализовать через retrofit
//   Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
//     Map <String, dynamic> queries = {'_start': '$startIndex', '_limit': '$_postLimit'};
//     final response = await client.getPosts(_postLimit);
//     if (response.code == 200) {
//       final body = [];
//       return body.map((dynamic json) {
//         final map = json as Map<String, dynamic>;
//         return Post(
//           id: map['id'] as int,
//           title: map['title'] as String,
//           body: map['body'] as String,
//         );
//       }).toList();
//     }
//     throw Exception('ошибка загрузки постов');
//   }
// }