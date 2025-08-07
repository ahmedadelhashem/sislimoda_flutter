import 'dart:convert';

import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/coupons/coupon_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/influencer_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin CouponDetailsData {
  Loading loading = Loading();
  GenericCubit<CouponModel> couponCubit = GenericCubit<CouponModel>();
  GenericCubit<InfluencerModel> influencerCubit =
      GenericCubit<InfluencerModel>();
  getCoupon({required String couponId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Coupon/GetById?Id=$couponId',
          body: {});
      result.fold((success) {
        CouponModel couponModel = CouponModel.fromJson(jsonDecode(success));
        getInfluencer(influencerId: couponModel.influencerId ?? '');
        couponCubit.update(data: couponModel);
      }, (fails) {
        showErrorMessage(message: fails.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getInfluencer({required String influencerId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Influencer/GetById?Id=$influencerId',
          body: {});
      result.fold((success) {
        InfluencerModel influencerModel =
            InfluencerModel.fromJson(jsonDecode(success));
        influencerCubit.update(data: influencerModel);
      }, (fails) {
        showErrorMessage(message: fails.message);
      });
    } catch (error) {}
    loading.hide;
  }

  activateCoupon({required String couponId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Coupon/ActiveCoupon?Id=$couponId',
          body: {});
      result.fold((success) {
        getCoupon(couponId: couponId);
        showSuccessMessage(
            message: isArabic ? "" : "Coupon Activate successfully");
      }, (fails) {
        showErrorMessage(message: fails.message);
      });
    } catch (error) {}
    loading.hide;
  }

  deActivateCoupon({required String couponId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Coupon/DeActiveCoupon?Id=$couponId',
          body: {});
      result.fold((success) {
        getCoupon(couponId: couponId);
        showSuccessMessage(
            message: isArabic ? "" : "Coupon deactivate successfully");
      }, (fails) {
        showErrorMessage(message: fails.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
