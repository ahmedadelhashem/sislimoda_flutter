
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sislimoda_admin_dashboard/models/notofications/notifications_request_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

part 'notofocations_state.dart';

class NotofocationsCubit extends Cubit<NotofocationsState> {
  NotofocationsCubit() : super(NotofocationsInitial());

  getNotifications() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Notifications/GetAll',
          body: null);

      result.fold((success) {
        List<NotificationModel> notifications =
            notificationModelFromJson(success);
        notifications =notifications.reversed.toList();
        emit(NotofocationsLoaded(
            unReadcount: notifications.length, notifications: notifications));
      }, (error) {
        emit(NotofocationsError());
      });
    } catch (error) {}
  }
}
