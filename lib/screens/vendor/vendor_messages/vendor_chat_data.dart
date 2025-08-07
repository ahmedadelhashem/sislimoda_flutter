import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/chat/chat_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin VendorChatData {
  Loading loading = Loading();
  List<ChatModelUserMessages> messages = [];
  GenericCubit<List<ChatModelUserMessages>> messagesCubit =
      GenericCubit<List<ChatModelUserMessages>>();

  TextEditingController messageController = TextEditingController();
  String selectedUserId = '';
  getMessages() async { 
    loading.show;
    try {
      SharedPreferences ref = await SharedPreferences.getInstance();
      String? userId = ref.getString('userId');
      selectedUserId = userId ?? '';
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName:
              'api/Chat/GetAllByUserId?myAppUserId=$userId&page=1&pageSize=100000',
          body: {});

      result.fold((success) {
        messagesCubit.update(data: chatModelUserMessagesMessages(success));
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  reload() async {
    try {
      SharedPreferences ref = await SharedPreferences.getInstance();
      String? userId = ref.getString('userId');
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName:
              'api/Chat/GetAllByUserId?myAppUserId=$userId&page=1&pageSize=100000',
          body: {});

      result.fold((success) {
        messagesCubit.update(data: chatModelUserMessagesMessages(success));
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
  }

  sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }
    await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Chat/messageFromUser',
        body: {
          "myAppUserId": selectedUserId,
          "message": messageController.text
        });
    messageController.clear();
    reload();
  }
}
