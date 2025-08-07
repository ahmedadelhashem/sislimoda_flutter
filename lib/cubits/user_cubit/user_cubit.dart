import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/user/user_moel.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Loading loading = Loading();
  UserModel? user;
  getUserData() async {
    loading.show;
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userId = ref.getString('userId');
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Auth/GetUserData?userID=$userId',
          body: null);
      result.fold((l) {
        user = UserModel.fromJson(jsonDecode(l));
        emit(UserLoaded(
            user: UserModel.fromJson(
              jsonDecode(l),
            ),
            current: DateTime.now().millisecond));
      }, (r) {
        emit(UserFailer());
      });
    } finally {
      loading.hide;
    }
  }
}
