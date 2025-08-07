import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/review.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin ReviewDetailsData {
  Loading loading = Loading();
  GenericCubit<List<ValueItem>> status = GenericCubit<List<ValueItem>>();
  GenericCubit<Review> reviewCubit = GenericCubit<Review>();

  getOptions() async {
    var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/OptionSet/GetAllByNames',
        body: ['reviewStatus']);

    result.fold((success) {
      List<OptionSetModel?> temp = [];
      temp = optionSetModelFromJson(success);
      if (temp.isNotEmpty) {
        List<ValueItem> states = [];
        temp.first?.optionSetItems?.forEach((element) {
          states.add(ValueItem(
              label: isArabic ? element?.nameAr ?? '' : element?.nameEn ?? '',
              value: element?.id));
        });
        status.update(data: states);
      }
    }, (fail) {});
  }

  getAllReviews({required String id}) async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/ProductEvaluation/GetAllProductEvaluations',
          body: {});

      result.fold(
        (success) {
          List<Review> reviews = reviewModelFromJson(success);
          reviewCubit.update(
              data: reviews.firstWhere((element) => element.id == id));
        },
        (fail) {
          showErrorMessage(message: 'Something went wrong');
        },
      );
    } catch (error) {}
    loading.hide;
  }

  changeState({required String stateId}) async {
    loading.show;
    try {
      Review review = reviewCubit.state.data ?? Review();
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/ProductEvaluation/Update',
          body: {
            "id": review.id,
            "description": review.description,
            "productId": review.productId,
            "rate": review.rate,
            "userFullName": review.userFullName,
            "imageId": review.imageId,
            "evaluationApproveStatusId": stateId
          });

      result.fold((success) {
        showSuccessMessage(
            message: isArabic
                ? 'تم تغيير الحالة بنجاح'
                : 'State Changed successfully');
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
