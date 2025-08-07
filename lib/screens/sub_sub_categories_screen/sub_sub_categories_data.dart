import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/models/general/product_option_model.dart';
import 'package:sislimoda_admin_dashboard/models/offers/get_offers_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/product_options_operations.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';

mixin SubSubCategoriesData {
  Loading loading = Loading();

  GenericCubit<CategoryModel> categoryCubit = GenericCubit<CategoryModel>();

  getCategoryDetails({required String categoryId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Category/GetById?catId=$categoryId',
          body: null);
      result.fold((success) {
        categoryCubit.update(data: CategoryModel.fromJson(jsonDecode(success)));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  GenericCubit<List<CategoryModel>> subCategoryCubit =
      GenericCubit<List<CategoryModel>>();

  getSubCategories({required String categoryId}) async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Category/GetAllSubById?catId=$categoryId',
          body: null);

      result.fold((success) {
        subCategoryCubit.update(data: categoryModelFromJson(success));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  addSubCategory({required String categoryId}) async {
    showDialog(
        context: currentContext,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) {
          return AddCategory(
            mainCategoryId: categoryId,
            brands: [],
            refresh: () async {
              loading.show;

              try {
                var result = await AppService.callService(
                    actionType: ActionType.get,
                    apiName: 'api/Category/GetAllSubById?catId=$categoryId',
                    body: null);

                result.fold((success) {
                  subCategoryCubit.update(data: categoryModelFromJson(success));
                }, (failure) {
                  showErrorMessage(message: failure.message);
                });
              } catch (error) {}
              loading.hide;
            },
            operationType: OperationType.add,
            category: CategoryModel(),
          );
        });
  }

  updateCategory(
      {required CategoryModel updateCategory,
      required String mainCategoryId}) async {
    showDialog(
        context: currentContext,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) {
          return AddCategory(
            mainCategoryId: mainCategoryId,
            brands: [],
            refresh: () {
              getSubCategories(categoryId: mainCategoryId);
            },
            operationType: OperationType.update,
            category: updateCategory,
          );
        });
  }

  GenericCubit<List<OfferModel>> offersCubit = GenericCubit<List<OfferModel>>();
  getCategoryOffer({required String categoryId}) async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Offers/GetAll', body: null);

      result.fold((success) {
        List<OfferModel> offers = offerModelFromJson(success);
        offers.removeWhere(
          (element) => element.offerCategoryId != categoryId,
        );
        offersCubit.update(data: offerModelFromJson(success));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  GenericCubit<List<ProductModel>> productsCubit =
      GenericCubit<List<ProductModel>>();
  getCategoryProduct({required String categoryId}) async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAllByCategoryId?CategoryId=$categoryId',
          body: null);

      result.fold((success) {
        productsCubit.update(data: productModelFromJson(success));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<ProductOptionModel> options = [];
  GenericCubit<List<ProductOptionModel>> optionsCubit =
      GenericCubit<List<ProductOptionModel>>();
  getOptions({required String categoryId}) async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Option/GetAll', body: {});
      result.fold((success) {
        options = productOptionModelFromJson(success);
        options.forEach((element) {
          types.add(ValueItem(
              label: element.groupName ?? '', value: element.groupKey));
        });
        types = types.toSet().toList();
        types.add(ValueItem(label: 'Other', value: 'Other'));
        options.removeWhere((element) => element.categoryId != categoryId);
        optionsCubit.update(data: options);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
  }

  List<ValueItem> types = [];
  addProductOption({required String categoryId}) {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return ProductOptionsOperations(
            operationType: OperationType.add,
            reload: getOptions,
            types: types,
            categoryId: categoryId,
          );
        });
  }
}
