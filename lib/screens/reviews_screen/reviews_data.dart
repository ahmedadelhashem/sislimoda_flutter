import 'dart:convert';

import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/review.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin ReviewsData {
  Loading loading = Loading();
List<Review> allReviews = []; // كل التقييمات من API
String _currentStatusId = '-1';
String _currentSearchText = '';

  List<Review> reviews = [];
  GenericCubit<List<Review>> reviewsCubit = GenericCubit<List<Review>>();
  GenericCubit<List<ValueItem>> status = GenericCubit<List<ValueItem>>();

getAllReviews() async {
  loading.show;
  await getOptions();

  try {
    var result = await AppService.callService(
      actionType: ActionType.get,
      apiName: 'api/ProductEvaluation/GetAllProductEvaluations',
      body: {},
    );

    result.fold(
      (success) {
        allReviews = reviewModelFromJson(success);
        reviews = allReviews;
        reviewsCubit.update(data: reviews);
      },
      (fail) {
        showErrorMessage(message: 'Something went wrong');
      },
    );
  } catch (error) {}

  loading.hide;
}
  getOptions() async {
    var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/OptionSet/GetAllByNames',
        body: ['reviewStatus']);

    result.fold((success) {
      List<OptionSetModel?> temp = [];
      temp = optionSetModelFromJson(success);
      if (temp.isNotEmpty) {
        List<ValueItem> states = [
          ValueItem(label: isArabic ? 'الكل' : "All", value: '-1')
        ];
        temp.first?.optionSetItems?.forEach((element) {
          states.add(ValueItem(
              label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
              value: element?.id));
        });
        status.update(data: states);
      }
    }, (fail) {});
  }

void filter({String? id}) {
  if (id != null) _currentStatusId = id;

  List<Review> filtered = allReviews;

  if (_currentStatusId != '-1') {
    filtered = filtered
        .where((element) => element.evaluationApproveStatusId == _currentStatusId)
        .toList();
  }

  if (_currentSearchText.isNotEmpty) {
    filtered = filtered
        .where((element) => (element.userFullName ?? '')
            .toLowerCase()
            .contains(_currentSearchText.toLowerCase()))
        .toList();
  }

  reviewsCubit.update(data: filtered);
}
void searchByName(String name) {
  _currentSearchText = name;
  filter(); // هتفلتر تلقائيًا حسب الاسم والحالة
}

}
