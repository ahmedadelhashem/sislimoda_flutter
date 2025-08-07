import 'dart:convert';

import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin EditProductsData {
  Loading loading = Loading();
  GenericCubit<ProductModel> productCubit = GenericCubit<ProductModel>();

  getProduct({required String productId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetById?Id=$productId',
          body: {});

      result.fold((success) {
        productCubit.update(
          data: ProductModel.fromJson(
            jsonDecode(success),
          ),
        );
      }, (fails) {
        showErrorMessage(message: fails.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
