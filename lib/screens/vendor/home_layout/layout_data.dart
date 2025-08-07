import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/vendor_models/vendor_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

GenericCubit<VendorModel> vendorCubit = GenericCubit<VendorModel>();

mixin LayoutData {
  Loading loading = Loading();
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

  bool checkIfProfileNotCompleted({required VendorModel vendor}) {
    if (vendor.companyName != null && vendor.companyName != '') {
      return false;
    } else if (vendor.bankName != null && vendor.bankName != '') {
      return false;
    } else if (vendor.bankNumber != null && vendor.bankNumber != '') {
      return false;
    } else if (vendor.iban != null && vendor.iban != '') {
      return false;
    } else if (vendor.fullCompanyAddress != null &&
        vendor.fullCompanyAddress != '') {
      return false;
    } else if (vendor.vendorCompanyAttachments != null &&
        vendor.vendorCompanyAttachments!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
