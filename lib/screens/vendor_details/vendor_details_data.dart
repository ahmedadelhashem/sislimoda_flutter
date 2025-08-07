import 'dart:convert';

import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/controllers/general.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin VendorDetailsData {
  Loading loading = Loading();

  GenericCubit<VendorModel> vendorCubit = GenericCubit<VendorModel>();
  GenericCubit<List<ProductModel>> vendorProductsCubit =
      GenericCubit<List<ProductModel>>();
  GenericCubit<List<OrderModel>> vendorOrdersCubit =
      GenericCubit<List<OrderModel>>();
  getVendor({required String vendorId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Vendor/GetById?Id=$vendorId',
          body: null);

      result.fold((success) {
        vendorCubit.update(data: VendorModel.fromJson(jsonDecode(success)));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getVendorsProducts({required String vendorId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAllByVendor?VendorId=$vendorId',
          body: null);

      result.fold((success) {
        vendorProductsCubit.update(data: productModelFromJson(success));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getVendorsOrders({required String vendorId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Orders/GetVendorOrderedProduct?VendorId=$vendorId',
          body: null);

      result.fold((success) {
        vendorOrdersCubit.update(data: orderModelModelFromJson(success));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<ValueItem> status = [];
  GenericCubit<List<ValueItem>> statusCubit=GenericCubit<List<ValueItem>>();
  getVendorStatus() async {
    var result = await GeneralController.getStatusByName(name: 'vendorstatus');
    result.fold((success) {
      optionSetModelFromJson(success).first.optionSetItems?.forEach((element) {
        status.add(ValueItem(
            label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
            value: element?.value));
      });
      statusCubit.update(data: status);
    }, (fail) {
      showErrorMessage(message: fail.message);
    });
  }

  changeVendorStatus(
      {required String selectedValue, required String vendorId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName:
              'api/Vendor/UpdateStatus?Id=$vendorId&Value=$selectedValue&Name=vendorstatus',
          body: null);

      result.fold((success) {
        showSuccessMessage(
            message: isArabic
                ? 'تم تغيير حاله البائع بنجاح'
                : 'Vendor status change successfully');
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
