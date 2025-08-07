import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/country_model.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/general/product_option_model.dart';
import 'package:sislimoda_admin_dashboard/models/settings/settings.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/option_set_operation.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/product_options_operations.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin SettingsData {
  Loading loading = Loading();

  List<CountryModel> countries = [];
  GenericCubit<List<CountryModel>> countriesCubit =
      GenericCubit<List<CountryModel>>();
  getListCountries() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Country/GetAll', body: {});
      result.fold((success) {
        countries = countryModelFromJson(success);
        countriesCubit.update(data: countries);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<OptionSetModel> optionSets = [];
  GenericCubit<List<OptionSetModel>> optionSetsCubit =
      GenericCubit<List<OptionSetModel>>();
  getOptionsSets() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/OptionSet/GetAll',
          body: {});
      result.fold((success) {
        optionSets = optionSetModelFromJson(success);
        optionSetsCubit.update(data: optionSets);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
  }

  List<ProductOptionModel> productOptions = [];
  GenericCubit<List<ProductOptionModel>> productOptionsCubit =
      GenericCubit<List<ProductOptionModel>>();
  getProductOptions() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Option/GetAll', body: {});
      result.fold((success) {
        productOptions = productOptionModelFromJson(success);
        productOptionsCubit.update(data: productOptions);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
  }

  List<SettingsModel> settings = [];
  GenericCubit<List<SettingsModel>> settingsCubit =
      GenericCubit<List<SettingsModel>>();
  getSettings() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Settings/GetAll', body: {});
      result.fold((success) {
        settings = settingsModelFromJson(success);
        settingsCubit.update(data: settings);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
  }

  addCountry(Country country) async {
    var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Country/Add',
        body: {
          "countryId": country.hashCode,
          "isActive": true,
          "name": CountryLocalizations(const Locale('ar'))
              .countryName(countryCode: country.countryCode),
          "nameEn": country.name,
          "code": country.countryCode,
          "isoCode": country.countryCode
        });
    result.fold((success) async {
      await getListCountries();
      showSuccessMessage(
          message: isArabic
              ? "تمت إضافة الدولة بنجاح"
              : "Country Added Successfully");
    }, (fail) {
      showErrorMessage(message: fail.message);
    });
  }

  addOptionSet() {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return OptionSetOperations(
            operationType: OperationType.add,
            reload: getOptionsSets,
          );
        });
  }

  // addProductOption() {
  //   showDialog(
  //       context: currentContext,
  //       builder: (ctx) {
  //         return ProductOptionsOperations(
  //           operationType: OperationType.add,
  //           categoryId: ,
  //           reload: getProductOptions,
  //         );
  //       });
  // }
}
