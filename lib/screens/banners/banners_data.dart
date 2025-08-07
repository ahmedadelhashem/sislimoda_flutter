import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/banner/banner_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/banners/widgets/add_update_banner.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin BannersData {
  Loading loading = Loading();
  GenericCubit<List<BannersModel>> bannersCubit =
      GenericCubit<List<BannersModel>>();

  getBannersByType() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Banar/GetAllByType?Type=home',
          body: {});

      result.fold((success) {
        bannersCubit.update(data: bannersModelFromJson(success));
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<ProductModel> products = [];
  getProducts() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAll',
          body: null);
      result.fold((l) {
        products = productModelFromJson(l);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
  }

  addBanner({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AddUpdateBanner(
            products: products,
            operationType: OperationType.add,
            afterAdd: getBannersByType,
          );
        });
  }

  delete({required String bannerId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Banar/Delete?Id=$bannerId',
          body: {});

      result.fold((success) async {
        await getBannersByType();
        showSuccessMessage(
            message: isArabic ? 'تم الحذف بنجاح' : "Deleted Successfully");
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
