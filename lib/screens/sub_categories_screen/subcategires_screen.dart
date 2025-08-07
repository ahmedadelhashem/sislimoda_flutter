import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/category_details/category_data.dart';
import 'package:sislimoda_admin_dashboard/screens/category_details/widgets/category_datatable.dart';
import 'package:sislimoda_admin_dashboard/screens/category_details/widgets/category_products.dart';
import 'package:sislimoda_admin_dashboard/screens/category_details/widgets/offer_datatable.dart';
import 'package:sislimoda_admin_dashboard/screens/sub_categories_screen/sub_categories_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, @pathParam required this.categoryId});
  final String categoryId;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen>
    with SubCategoriesData {
  @override
  void initState() {
    // TODO: implement initState
    getCategoryDetails(categoryId: widget.categoryId);
    getCategoryOffer(categoryId: widget.categoryId);
    getCategoryProduct(categoryId: widget.categoryId);
    getSubCategories(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SubCategoriesScreen oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget.categoryId != widget.categoryId) {
      getCategoryDetails(categoryId: widget.categoryId);
      getCategoryOffer(categoryId: widget.categoryId);
      getCategoryProduct(categoryId: widget.categoryId);

      getSubCategories(categoryId: widget.categoryId);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 34, right: 34),
            width: double.infinity,
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('dataaaa'),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.categoryManagement.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22.sp),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          LocaleKeys.categoryManagementHint.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.isMobile ? 12.spMin : 16.sp),
                        ),
                      ],
                    ),
                    Spacer(),
                    GenericBuilder(
                        genericCubit: categoryCubit,
                        builder: (category) {
                          return SizedBox(
                            width: context.isMobile ? 80.spMin : 247.w,
                            height: context.isMobile ? 35.h : 40.sp,
                            child: AppButton(
                              title:
                                  '${LocaleKeys.addCategory.tr()} ${isArabic ? (category.name ?? '') : (category.nameEn ?? '')}',
                              onPress: () {
                                addSubCategory(categoryId: widget.categoryId);
                              },
                              titleFontColor: Colors.white,
                              titleFontSize: context.isMobile ? 11.spMin : 16,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        onPressed: () {
                          context.router.back();
                        },
                        icon: Icon(Icons.arrow_forward))
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                GenericBuilder(
                    genericCubit: categoryCubit,
                    builder: (category) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150.sp,
                                height: 150.sp,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                child: CustomNetworkImage(
                                    link:
                                        category.categoryPhoto?.fullLink ?? '',
                                    height: 250.sp,
                                    width: 250.sp),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 200.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isArabic
                                          ? (category.name ?? '')
                                          : (category.nameEn ?? ''),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.categories),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          category.description ?? '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              height: 1.8,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              GenericBuilder(
                                  genericCubit: subCategoryCubit,
                                  builder: (categories) {
                                    return Text(
                                      'Count : ${categories.length}',
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    );
                                  })
                            ],
                          ),
                          Container(
                            height: .5.sh,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            // padding: EdgeInsets.all(10),
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 0,
                                ),
                                Container(
                                  height: .45.sh,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: DefaultTabController(
                                      length: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TabBar(
                                            dividerColor: Colors.transparent,
                                            indicatorPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 6, horizontal: 0),
                                            tabAlignment: TabAlignment.start,
                                            isScrollable: true,
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            indicator: BoxDecoration(
                                                color: const Color(0xffEBF4FF),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            labelStyle: AppFonts.apptextStyle
                                                .copyWith(
                                                    color: Color(0xff003B7E),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            unselectedLabelStyle:
                                                AppFonts.apptextStyle.copyWith(
                                                    color: Color(0xff556377),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            tabs: [
                                              Tab(
                                                text: isArabic
                                                    ? 'الاقسام الفرعية'
                                                    : "Sub Sub Categories",
                                              ),
                                              // Tab(
                                              //   text: LocaleKeys.offers.tr(),
                                              // ),
                                              // Tab(
                                              //   text: LocaleKeys.products.tr(),
                                              // ),
                                              // Tab(
                                              //   text: isArabic
                                              //       ? 'الإحصائيات'
                                              //       : 'Statistics',
                                              // )
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                GenericBuilder(
                                                    genericCubit:
                                                        subCategoryCubit,
                                                    builder: (categories) {
                                                      return CategoriesDataTable(
                                                        navigate: (category) {
                                                          context.router.push(
                                                              SubSubCategoriesRoute(
                                                                  categoryId:
                                                                      category.id ??
                                                                          ''));
                                                        },
                                                        categories: categories,
                                                        updateCategory:
                                                            (category) {
                                                          updateCategory(
                                                              updateCategory:
                                                                  category,
                                                              mainCategoryId:
                                                                  widget.categoryId ??
                                                                      'a');
                                                        },
                                                      );
                                                    }),
                                                // GenericBuilder(
                                                //     genericCubit: offersCubit,
                                                //     builder: (offers) {
                                                //       return OfferDatatable(
                                                //         offers: offers,
                                                //       );
                                                //     }),
                                                // GenericBuilder(
                                                //     genericCubit: productsCubit,
                                                //     builder: (products) {
                                                //       return CategoryProducts(
                                                //         products: products,
                                                //       );
                                                //     }),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          )),
    );
  }
}
