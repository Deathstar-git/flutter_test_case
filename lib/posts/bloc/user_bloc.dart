import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../models/models.dart';
import '../retrofit/api_client.dart';

part 'user_event.dart';
part 'user_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.apiClient, required this.userId}) : super(const UserState()) {
    on<UserFetched>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int userId;
  final ApiClient apiClient;

  Future<void> _onUserFetched(
      UserFetched event,
      Emitter<UserState> emit,
      ) async {
    try {
        final users = await apiClient.fetchUser(userId);
        return emit(
          state.copyWith(
            status: UserStatus.success,
            users: users,
          ),
        );
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }
}