import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/controllers/general.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/screens/support_tickets/support_ticket_dtails/models/add_reply_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin SupportTicketDetailsData {
  Loading loading = Loading();

  GenericCubit<TicketModel> ticketCubit = GenericCubit<TicketModel>();
  getTicket({required String ticketId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Ticket/GetById?UserId=$ticketId',
          body: {});

      result.fold((success) {
        ticketCubit.update(data: TicketModel.fromJson(jsonDecode(success)));
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  GenericCubit<bool> sendCubit = GenericCubit<bool>();

  TextEditingController messageController = TextEditingController();
  initData() {
    sendCubit.update(data: false);
  }

  List<ValueItem> itemStatus = [];
  GenericCubit<List<ValueItem>> statusCubit = GenericCubit<List<ValueItem>>();
  getAllStatus() async {
    var result = await GeneralController.getStatusByName(name: 'TicketStatus');
    result.fold((success) {
      optionSetModelFromJson(success).first.optionSetItems?.forEach((element) {
        itemStatus.add(ValueItem(
            label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
            value: element?.value));
        statusCubit.update(data: itemStatus);
      });
    }, (fail) {
      showErrorMessage(message: fail.message);
    });
  }

  changeTicketStatus(
      {required String selectedValue, required String ticketId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName:
              'api/Ticket/UpdateStatus?Id=$ticketId&Value=$selectedValue&Name=TicketStatus',
          body: null);

      result.fold((success) {
        getTicket(ticketId: ticketId);
        ticketCubit.update(data: ticketCubit.state.data!);
        showSuccessMessage(
            message: isArabic
                ? 'تم تغيير حاله الشكوي بنجاح'
                : 'Ticket status change successfully');
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  addReply({required String appUserId}) async {
    if (messageController.text.isEmpty) {
      return;
    }
    sendCubit.update(data: true);

    try {
      AddTicketReplyModel addTicketReplyModel = AddTicketReplyModel(
          isDeleted: false,
          isInternal: false,
          message: messageController.text,
          ticketId: ticketCubit.state.data?.id,
          appUserId: appUserId);

      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Ticket/AddTicketReply',
          body: addTicketReplyModel.toJson());

      result.fold((success) {
        TicketModel? supportTicketModel = ticketCubit.state.data;
        supportTicketModel!.ticketReply?.add(TicketModelTicketReply(
          appUserId: appUserId,
          ticketId: supportTicketModel.id,
          id: '',
          message: messageController.text,
          isInternal: false,
          isDeleted: false,
          created: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        ));
        ticketCubit.update(data: supportTicketModel);
        messageController.clear();
      }, (fail) {
        showErrorMessage(
            message: isArabic ? "حدث شي خاطئ" : "Something went wrong");
      });
    } catch (error) {}
    sendCubit.update(data: false);
  }
}
