import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/no_result_found.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/reviews_screen/reviews_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> with ReviewsData {
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    getAllReviews();
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
   SizedBox(
  width: 250.w, // ← حجم العرض اللي يناسبك (جرب 200.w أو أقل لو تحب)
  child: TextField(
    controller: searchController,
    onChanged: searchByName,
    style: TextStyle(fontSize: 13.sp), // ← حجم الخط
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      hintText: isArabic ? 'بحث بالاسم' : 'Search name',
      hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
      prefixIcon: Icon(Icons.search, size: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // ← حواف أصغر
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      isDense: true,
    ),
  ),
),

    SizedBox(width: 16),
    SizedBox(
      width: 200.w,
      child: GenericBuilder(
        genericCubit: status,
        builder: (states) {
          return CustomMultiSelect(
            onChange: (List<ValueItem> items) {
              if (items.isNotEmpty) {
                filter(id: items.first.value);
              }
            },
            isSingle: true,
            hint: 'All',
            selectedItems: [states.first],
            items: states ?? [],
          );
        },
      ),
    ),
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
                        builder: (reviews) {
                          return reviews.isNotEmpty
                              ? DataTable2(
                                  dividerThickness: 0,
                                  columns: [
                                    // DataColumn2(
                                    //   label: AppCheckbox(label: Text('')),
                                    //   fixedWidth: 60,
                                    // ),
                                    // DataColumn2(
                                    //   label: Text(
                                    //     LocaleKeys.offerImage.tr(),
                                    //     style: AppFonts.apptextStyle.copyWith(
                                    //         fontSize: 16,
                                    //         fontWeight: FontWeight.w400,
                                    //         color: AppColors.secondaryFontColor),
                                    //   ),
                                    //   size: ColumnSize.L,
                                    // ),
                                    // DataColumn2(
                                    //   label: Text(
                                    //     isArabic ? " الصورة" : "image",
                                    //     style: AppFonts.apptextStyle.copyWith(
                                    //         fontSize: 16,
                                    //         fontWeight: FontWeight.w400,
                                    //         color:
                                    //             AppColors.secondaryFontColor),
                                    //   ),
                                    //   size: ColumnSize.S,
                                    // ),
                                    DataColumn2(
                                        label: Text(
                                          LocaleKeys.name.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 250),

                                    DataColumn2(
                                        label: Text(
                                          LocaleKeys.description.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 200.w),
                                    DataColumn2(
                                        label: Text(
                                          isArabic ? "التقييم" : "Rate",
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 300),
                                    DataColumn2(
                                      label: Text(
                                        LocaleKeys.status.tr(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryFontColor),
                                      ),
                                      fixedWidth: 200,
                                    ),
                                  ],
                                  rows: reviews.map((element) {
                                    return DataRow2(
                                      onTap: () {
                                        context.router.push(ReviewDetailsRoute(
                                            reviewId: element.id ?? ''));
                                      },
                                      cells: [
                                        // DataCell(
                                        //   Container(
                                        //     clipBehavior: Clip.antiAlias,
                                        //     margin:
                                        //         EdgeInsets.symmetric(vertical: 5),
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(9)),
                                        //     child: CustomNetworkImage(
                                        //       link: element.image?.fullLink ?? '',
                                        //       height: 100,
                                        //       fit: BoxFit.fitHeight,
                                        //       width: 300,
                                        //     ),
                                        //   ),
                                        // ),
                                        DataCell(Text(
                                          element.userFullName ?? '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        )),
                                        DataCell(Text(
                                          element.description ?? '',
                                          maxLines: 1,
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        )),
                                        DataCell(RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating:
                                              double.parse(element.rate ?? '0'),
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
                                        )),
                                        DataCell(Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color(int.parse(
                                                  '0xff${element.evaluationApproveStatus?.color?.substring(1) ?? ''}'))),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            isArabic
                                                ? (element
                                                        .evaluationApproveStatus
                                                        ?.nameAr ??
                                                    'جديد')
                                                : (element
                                                        .evaluationApproveStatus
                                                        ?.nameEn ??
                                                    'New'),
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                          ),
                                        )),
                                      ],
                                    );
                                  }).toList(),
                                )
                              : SizedBox(
                                  width: 1.sw,
                                  child: Center(
                                      child: NoResultFound(
                                    title: isArabic
                                        ? "لم يتم العثور على تقيمات"
                                        : "No Reviews found",
                                  )));
                        },
                        genericCubit: reviewsCubit),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
