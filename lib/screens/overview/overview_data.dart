import 'dart:convert';

import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin OverviewData {
  Loading loading = Loading();
  GenericCubit<GetAnalysisModel> analysisCubit =
      GenericCubit<GetAnalysisModel>();

  getAnalysis() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Orders/GetAdminStatistics',
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
