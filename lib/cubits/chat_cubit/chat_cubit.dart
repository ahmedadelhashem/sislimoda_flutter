import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/chat/chat_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  Loading loading = Loading();

  ChatModel selectedChat = ChatModel();

  GenericCubit<ChatModel> singleChatCubit = GenericCubit<ChatModel>();

  getAllChats() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Chat/GetAllChatWithMessage?page=1&pageSize=100000',
          body: {});

      result.fold((success) {
        int unreadMessages = 0;

        chatModelFromJson(success).forEach((element) {
          element.userMessages?.forEach((element) {
            if (element?.isRead ?? false) {
              unreadMessages = unreadMessages + 1;
            }
          });
        });
        singleChatCubit.update(data: selectedChat);
        emit(ChatLoaded(
            unreadMessages: unreadMessages,
            selectedChat: selectedChat,
            chats: chatModelFromJson(success).reversed.toList(),
            timeStamp: DateTime.now().millisecond));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
  }

  syncChat() {
    getAllChats();
    Timer.periodic(Duration(seconds: 10), (c) {
      getAllChats();
    });
  }

  // selectChat({required ChatModel selectedChat,required List<ChatModel> chats}){
  //   emit(ChatLoaded(
  //       unreadMessages: 0,
  //       selectedChat: selectedChat,
  //       chats: chats,
  //       timeStamp: DateTime.now().millisecond));
  // }
}

String getSinceTime({required String dateTime}) {
  DateTime date = DateFormat('dd-MM-yyy HH:mm:ss').parse(dateTime);
  date = date.add(Duration(hours: 1));
  DateTime serverTime = DateTime.now();
  String sinceTime = '';
  int min = serverTime.difference(date).inMinutes;
  if (min < 1) {
    sinceTime = isArabic ? 'الان' : 'just now';
  } else if (min >= 1 && min < 60) {
    sinceTime = isArabic ? 'منذ $min دقائق' : 'since $min miniutes';
  } else {
    int hours = serverTime.difference(date).inHours;
    if (hours >= 1 && hours < 24) {
      sinceTime = isArabic
          ? 'منذ $hours ساعات و ${min % 60} دقايق '
          : 'since $hours hours and ${min % 60} miniutes';
    } else {
      // sinceTime = DateFormat.Hms().format(date);
      sinceTime = DateFormat('MMMMEEEEd', isArabic ? 'ar' : 'en').format(date);
      sinceTime =
          '$sinceTime  ${isArabic ? "ساعه" : "hour"} ${DateFormat('jm', isArabic ? 'ar' : 'en').format(date)} ';
    }
  }
  return sinceTime;
}
