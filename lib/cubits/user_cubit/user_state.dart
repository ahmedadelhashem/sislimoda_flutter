part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoaded extends UserState {
  const UserLoaded({required this.user, required this.current});

  @override
  List<Object> get props => [user, current];
  final UserModel user;
  final int current;
}

final class UserFailer extends UserState {
  @override
  List<Object> get props => [];
}
