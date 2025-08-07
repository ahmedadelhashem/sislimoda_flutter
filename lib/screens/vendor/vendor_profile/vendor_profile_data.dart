import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin VendorProfileData {
  Loading loading = Loading();
  GenericCubit<VendorModel> vendorCubit = GenericCubit<VendorModel>();
  getVendorData() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userId = ref.getString('vendorId');
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Vendor/GetById?Id=$userId',
          body: null);

      result.fold((success) {
        vendorCubit.update(data: VendorModel.fromJson(jsonDecode(success)));
      }, (error) {
        showErrorMessage(message: error.message);
      });
    } catch (error) {}
  }
}
