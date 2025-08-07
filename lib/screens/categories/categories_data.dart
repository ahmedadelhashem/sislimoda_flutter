import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/brands/brand_model.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin CategoriesData {
  int totalPages = 1;
  int page = 1;
  GenericCubit<List<CategoryModel>> categoriesCubit =
      GenericCubit<List<CategoryModel>>();
  List<BrandModel> brands = [];
  Loading loading = Loading();
  getCategories() async {
    loading.show;
    // getBrands();
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Category/GetAllMainCategory',
          body: null);
      result.fold((l) {
        // ResponseModel<CategoryModel> responseModel = ResponseModel.fromJson(
        //     jsonDecode(l), CategoryModel.fromJson, 'categories');
              final jsonList = jsonDecode(l)['categories'] ?? [];
      final parsedList = List<CategoryModel>.from(
          jsonList.map((x) => CategoryModel.fromJson(x)));
                categoriesCubit.update(data: parsedList);

        totalPages =
            (double.parse(jsonDecode(l)['count'].toString() ?? '1') / 10)
                .ceil();
        // categoriesCubit.update(data: responseModel.data!);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }

  refreshCategories() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'category?useCursor=false&size=10&page=$page&prev=false',
          body: null);
      result.fold((l) {
        // ResponseModel<CategoryModel> responseModel = ResponseModel.fromJson(
        //     jsonDecode(l), CategoryModel.fromJson, 'categories');
        totalPages =
            (double.parse(jsonDecode(l)['count'].toString() ?? '1') / 10)
                .ceil();
        // categoriesCubit.update(data: responseModel.data!);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
  }

  deleteCategory({required CategoryModel category, required int index}) async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Category/Delete?Id=${category.id}',
          body: {});

      result.fold((l) {
        showSuccessMessage(
            message: isArabic
                ? 'تم مسح العنصر بنجاح'
                : 'Category deleted successfully');
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
  }

  addCategory() async {
    showGeneralDialog(
        context: currentContext,
        barrierColor: Colors.red,
        pageBuilder: (ctx, builder, secondaryAnimation) {
          return AddCategory(
            brands: brands,
            refresh: refreshCategories,
            operationType: OperationType.add,
            category: CategoryModel(),
          );
        });
  }

  updateCategory({required CategoryModel updateCategory}) async {
    showDialog(
        context: currentContext,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) {
          return AddCategory(
            brands: brands,
            refresh: refreshCategories,
            operationType: OperationType.update,
            category: updateCategory,
          );
        });
  }

  // getBrands() async {
  //   try {
  //     var result = await AppService.callService(
  //         actionType: ActionType.get, apiName: 'brand', body: null);
  //     result.fold((l) {
  //       ResponseModel<BrandModel> responseModel = ResponseModel.fromJson(
  //           jsonDecode(l), BrandModel.fromJson, 'brands');
  //       brands = responseModel.data!;
  //     }, (r) {
  //       showErrorMessage(message: r.message);
  //     });
  //   } catch (error) {}
  // }

 search(String text) async {
  if (text.isEmpty) {
    await getCategories();
    return;
  }

  loading.show;
  try {
    var result = await AppService.callService(
      actionType: ActionType.get,
      apiName: 'category/search?keyword=$text',
      body: null,
    );

    result.fold((l) {
      final jsonList = jsonDecode(l)['categories'] ?? [];
      final parsedList = List<CategoryModel>.from(
          jsonList.map((x) => CategoryModel.fromJson(x)));

      categoriesCubit.update(data: parsedList);
      totalPages = 1;
    }, (r) {
      showErrorMessage(message: r.message);
    });
  } catch (error) {
    showErrorMessage(message: 'Unexpected error occurred.');
  }
  loading.hide;
}

}
