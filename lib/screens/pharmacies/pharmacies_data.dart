import 'dart:convert';

import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_request_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin PharmaciesData {
  Loading loading = Loading();
  int totalPages = 1;
  int page = 1;
  GenericCubit<List<VendorModel>> pharmaciesCubit =
      GenericCubit<List<VendorModel>>();

  GenericCubit<GetPharmacyRequestModel> pharmaciesRequestsCubit =
      GenericCubit<GetPharmacyRequestModel>();

  bool isPharmacies = true;
  getAllPharmacies() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Vendor/GetAll', body: null);
      result.fold((success) {
        pharmaciesCubit.update(data: vendorModelFromJson(success));
      }, (faliure) {
        showErrorMessage(message: faliure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  approvePharmacy({required String pharmacyId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.put,
          apiName: 'admin/pharmacy/$pharmacyId/request/approve',
          body: null);
      result.fold((success) {
        getAllPharmacies();
        getAllPharmacyRequests();
      }, (faliure) {
        showErrorMessage(message: faliure.message);
        loading.hide;
      });
    } catch (error) {
      loading.hide;
    }
  }

  search(String text) async {
    if (text.isEmpty) {
      getAllPharmacies();
      return;
    }
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'pharmacy/search?keyword=$text',
          body: null);
      result.fold((success) {
        totalPages = 1;
        // GetPharmacyPaginationModel pharmaciesData =
        //     GetPharmacyPaginationModel.fromJson(jsonDecode(success));
        // pharmaciesCubit.update(
        //     data: GetPharmacyPaginationModel.fromJson(jsonDecode(success)));
      }, (faliure) {
        showErrorMessage(message: faliure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getAllPharmacyRequests() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'admin/pharmacy/request?recheck=false&status=false',
          body: null);
      result.fold((success) {
        pharmaciesRequestsCubit.update(
            data: GetPharmacyRequestModel.fromJson(jsonDecode(success)));
      }, (faliure) {
        showErrorMessage(message: faliure.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
