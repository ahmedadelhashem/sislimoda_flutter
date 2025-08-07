import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/coupons/coupon_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin CouponData {
  List<CouponModel> coupons = [];
  List<CouponModel> influencerCoupons = [];
  Loading loading = Loading();

  GenericCubit<List<CouponModel>> couponsCubit =
      GenericCubit<List<CouponModel>>();

  GenericCubit<List<CouponModel>> influencerCouponsCubit =
      GenericCubit<List<CouponModel>>();

  getCoupons() async {
    loading.show;
    // try {
    var result = await AppService.callService(
        actionType: ActionType.get, apiName: 'api/Coupon/GetAll', body: {});
    result.fold((success) {
      List<CouponModel> tempCoupons = couponModelFromJson(success);
      tempCoupons.forEach((element) {
        if (element.influencerId != null) {
          influencerCoupons.add(element);
        } else {
          coupons.add(element);
        }
      });
      couponsCubit.update(data: coupons);
      influencerCouponsCubit.update(data: influencerCoupons);
    }, (failure) {
      showErrorMessage(message: failure.message);
    });
    // } catch (error) {}
    loading.hide;
  }

  search(String text) {
    print('text $text');
    if (text.isEmpty) {
      influencerCouponsCubit.update(data: influencerCoupons);
      couponsCubit.update(data: coupons);

      return;
    }
    List<CouponModel> temp = [];
    influencerCoupons.forEach((element) {
      String searchText =
          '${element.code} ${element.influencer?.name} ${element.influencer?.whatsappNumber1} ';

      print('searchText');
      if (searchText.toLowerCase().contains(text.toLowerCase())) {
        temp.add(element);
      }
    });
    influencerCouponsCubit.update(data: temp);

    List<CouponModel> systemTemp = [];
    coupons.forEach((element) {
      String searchText =
          '${element.code} ${element.influencer?.name} ${element.influencer?.whatsappNumber1} ';

      print('searchText');
      if (searchText.toLowerCase().contains(text.toLowerCase())) {
        systemTemp.add(element);
      }
    });

    couponsCubit.update(data: systemTemp);
  }
}
