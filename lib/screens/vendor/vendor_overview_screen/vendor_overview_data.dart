import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin VendorOverviewData {
  Loading loading = Loading();
  GenericCubit<GetAnalysisModel> analysisCubit =
      GenericCubit<GetAnalysisModel>();

  getAnalysis() async {
    loading.show;
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userId = ref.getString('vendorId');
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Vendor/GetVendorStatistics?vendorId=$userId',
          body: null);

      result.fold((success) {
        analysisCubit.update(
            data: GetAnalysisModel.fromJson(jsonDecode(success)));
      }, (error) {
        showErrorMessage(message: error.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
