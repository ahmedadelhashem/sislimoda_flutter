import 'dart:convert';

import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/generic/generic_response.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin OrdersData {
  List<OrderModel?> orders = [];
  GenericCubit<List<OrderModel?>> ordersCubit =
      GenericCubit<List<OrderModel?>>();
  Loading loading = Loading();

  List<OrderModelOrderStatus> statusList = [];
  List<String> statusListId = [];
  GenericCubit<bool> isOrderCubit = GenericCubit<bool>();
  int page = 1;
  int totalPages = 0;

  getAllOrders() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Orders/GetAll', body: null);
      result.fold((success) {
        orders = orderModelModelFromJson(success);
        statusList
            .add(OrderModelOrderStatus(id: '0', nameAr: 'الكل', nameEn: 'All'));
        orders.forEach((element) {
          if (!statusListId.contains(element?.orderStatus?.id)) {
            statusList.add(element?.orderStatus ?? OrderModelOrderStatus());
            statusListId.add(element?.orderStatus?.id ?? '');
          }
        });
        ordersCubit.update(data: orders);
      }, (faliure) {
        showErrorMessage(message: faliure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  ////////////////////tickets

  List<ProductModel> products = [];
  getAllProducts() async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'medicine?useCursor=false&size=200&page=1&isDeleted=false',
          body: null);
      result.fold((l) {
        products = productModelFromJson(l);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
  }
}
