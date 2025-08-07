part of 'notofocations_cubit.dart';

sealed class NotofocationsState extends Equatable {
  const NotofocationsState();
}

final class NotofocationsInitial extends NotofocationsState {
  @override
  List<Object> get props => [];
}

final class NotofocationsLoaded extends NotofocationsState {
  final List<NotificationModel> notifications;
  final int unReadcount;

  const NotofocationsLoaded({
    required this.notifications,
    required this.unReadcount,
  });
  @override
  List<Object> get props => [unReadcount];
}

final class NotofocationsError extends NotofocationsState {
  @override
  List<Object> get props => [];
}
