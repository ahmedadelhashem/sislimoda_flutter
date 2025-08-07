import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/controllers/general.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin SupportTicketData {
  List<TicketModel?> orders = [];
  GenericCubit<List<TicketModel?>> ordersCubit =
      GenericCubit<List<TicketModel?>>();
  Loading loading = Loading();

  List<TicketModelTicketStatus> statusList = [];
  List<ValueItem> itemStatus = [];
  List<String> statusListId = [];
  GenericCubit<bool> isOrderCubit = GenericCubit<bool>();
  int page = 1;
  int totalPages = 0;

  getAllTickets() async {
    await getAllStatus();
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Ticket/GetAll', body: null);
      result.fold((success) {
        orders = ticketModelFromJson(success);
        statusList.add(
            TicketModelTicketStatus(id: '0', nameAr: 'الكل', nameEn: 'All'));
        orders.forEach((element) {
          if (!statusListId.contains(element?.ticketStatus?.id)) {
            statusList.add(element?.ticketStatus ?? TicketModelTicketStatus());
            statusListId.add(element?.ticketStatus?.id ?? '');
          }
        });
        ordersCubit.update(data: orders);
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getAllStatus() async {
    var result = await GeneralController.getStatusByName(name: 'TicketStatus');
    result.fold((success) {
      optionSetModelFromJson(success).first.optionSetItems?.forEach((element) {
        itemStatus.add(ValueItem(
            label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
            value: element?.value));
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
}
