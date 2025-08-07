import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/product/review.dart';
import 'package:sislimoda_admin_dashboard/screens/review_details_screen/review_details_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class ReviewDetailsScreen extends StatefulWidget {
  const ReviewDetailsScreen({
    super.key,
    @pathParam required this.reviewId,
  });
  final String reviewId;
  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen>
    with ReviewDetailsData {
  @override
  void initState() {
    // TODO: implement initState
    getOptions();
    getAllReviews(id: widget.reviewId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            width: double.infinity,
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.reviews.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: 200,
                      child: GenericBuilder(
                          genericCubit: status,
                          builder: (states) {
                            return SizedBox(
                              width: 200.w,
                              child: CustomMultiSelect(
                                onChange: (List<ValueItem> items) {
                                  if (items.isNotEmpty) {
                                    changeState(stateId: items.first.value);
                                  }
                                },
                                isSingle: true,
                                hint: 'All',
                                selectedItems: [states.first],
                                items: states ?? [],
                              ),
                            );
                          }),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: GenericBuilder(
                        builder: (review) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${isArabic ? 'العميل' : "Client name"} :',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          review.userFullName ?? '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Rate :',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating:
                                              double.parse(review.rate ?? '0'),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 30,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          LocaleKeys.description.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          review.description ?? '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: ListView(
                                children: review.productEvaluationImages!
                                    .map((element) => Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: CustomNetworkImage(
                                              link: element?.photo?.fullLink ??
                                                  '',
                                              height: 400,
                                              width: .4.sw),
                                        ))
                                    .toList(),
                              )),
                            ],
                          );
                        },
                        genericCubit: reviewCubit),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
