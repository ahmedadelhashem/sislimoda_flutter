import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/controllers/general.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:audioplayers/audioplayers.dart';


mixin VendorOrderData {
  List<OrderModel?> orders = [];
  GenericCubit<List<OrderModel?>> ordersCubit =
      GenericCubit<List<OrderModel?>>();
  Loading loading = Loading();

  List<OrderModelOrderStatus> statusList = [];
  GenericCubit<List<OrderModelOrderStatus>> statusCubit =
      GenericCubit<List<OrderModelOrderStatus>>();
  List<String> statusListId = [];
  GenericCubit<bool> isOrderCubit = GenericCubit<bool>();
  int page = 1;
  int totalPages = 0;


  getAllOrders() async {
    loading.show;
    await getAllStatus();
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userId = ref.getString('vendorId');
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Orders/GetVendorOrderedProduct?VendorId=$userId',
          body: null);
      result.fold((success) async {
        orders = orderModelModelFromJson(success);
        
        int newOrdersCount = orders
    .where((element) => element?.orderStatus!.nameEn?.toLowerCase() == 'new')
    .length;
    

      
      VendorSideBarState.newOrdersCountCubit.update(data: newOrdersCount);

        statusList
            .add(OrderModelOrderStatus(id: '0', nameAr: 'الكل', nameEn: 'All'));
        orders.forEach((element) {
          if (!statusListId.contains(element?.orderStatus?.id)) {
            statusList.add(element?.orderStatus ?? OrderModelOrderStatus());
            statusListId.add(element?.orderStatus?.id ?? '');
          }
        });
        statusCubit.update(data: statusList);
        ordersCubit.update(data: orders);
      }, (faliure) {
        showErrorMessage(message: faliure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<ValueItem> itemStatus = [];

  getAllStatus() async {
    var result = await GeneralController.getStatusByName(name: 'orderStatus');
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

  // changeTicketStatus(
  //     {required String selectedValue, required String ticketId}) async {
  //   loading.show;
  //   try {
  //     var result = await AppService.callService(
  //         actionType: ActionType.post,
  //         apiName:
  //             'api/Orders/UpdateStatus?Id=$ticketId&Value=$selectedValue&Name=orderStatus',
  //         body: null);

  //     result.fold((success) {
  //       showSuccessMessage(
  //           message: isArabic
  //               ? 'تم تغيير حاله الطلب بنجاح'
  //               : 'Order status change successfully');
  //     }, (failure) {
  //       showErrorMessage(message: failure.message);
  //     });
  //   } catch (error) {}
  //   loading.hide;
  // }
}
