part of 'user_bloc.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable{
  const UserState({
    this.status = UserStatus.initial,
    this.users = const <User>[],
  });

  final UserStatus status;
  final List<User> users;

  UserState copyWith({
    UserStatus? status,
    List<User>? users,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }

  @override
  String toString() {
    return '''UserState { status: $status  user: $users}''';
  }

  @override
  List<Object> get props => [status, users];
}