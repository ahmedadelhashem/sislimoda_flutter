  import 'dart:convert';

  import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
  import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
  import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
  import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
  import 'package:sislimoda_admin_dashboard/services/app_services.dart';

  mixin OrderDetailsData {
    Loading loading = Loading();
    OrderModel? orderModel;
    GenericCubit<OrderModel?> orderCubit = GenericCubit<OrderModel>();
    getOrderDetails({required String orderId}) async {
      loading.show;
      try {
        var result = await AppService.callService(
            actionType: ActionType.get, apiName: 'api/Orders/GetById?Id=$orderId', body: null);

        result.fold((success) {
          orderModel = OrderModel.fromJson(jsonDecode(success));
          orderCubit.update(data: orderModel);
        }, (faliure) {
          showErrorMessage(message: faliure.message);
        });
      } catch (error) {}
      loading.hide;
    }
    List<Map<String, dynamic>> vendors = [];

  Future<void> fetchVendors() async {
    try {
      final result = await AppService.callService(
        actionType: ActionType.get,
        apiName: 'api/Vendor/GetAll',
        body: null,
      );

      result.fold((success) {
        final data = jsonDecode(success);
        if (data is List) {
          vendors = List<Map<String, dynamic>>.from(data);
        }
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (e) {
      showErrorMessage(message: 'خطأ في تحميل البائعين');
    }
  }

  String? getVendorNameById(String? vendorId) {
    if (vendorId == null) return null;
    final vendor = vendors.firstWhere(
      (v) => v['id'] == vendorId,
      orElse: () => {},
    );
    return vendor['name'];
  }

  }
