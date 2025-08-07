import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/option_set_item_details/widgets/option_set_item_operation.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin OptionSetItemDetailsData {
  Loading loading = Loading();

  OptionSetModel optionSetModel = OptionSetModel();
  GenericCubit<OptionSetModel> optionSetCubit = GenericCubit<OptionSetModel>();
  getOptionsSet({required String optionSetId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/OptionSet/GetById?Id=$optionSetId',
          body: {});

      result.fold((success) {
        optionSetCubit.update(
            data: OptionSetModel.fromJson(jsonDecode(success)));
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  addItem({required String optionSetId}) {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return OptionSetItemOperation(
            operationType: OperationType.add,
            optionSetId: optionSetId,
            reload: () {
              getOptionsSet(optionSetId: optionSetId);
            },
          );
        });
  }
}
