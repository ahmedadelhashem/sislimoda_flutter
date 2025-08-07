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
import 'package:sislimoda_admin_dashboard/screens/category_details/widgets/category_products.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/product_options.dart';
import 'package:sislimoda_admin_dashboard/screens/sub_sub_categories_screen/sub_sub_categories_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class SubSubCategoriesScreen extends StatefulWidget {
  const SubSubCategoriesScreen({super.key, @pathParam required this.categoryId});
  final String categoryId;

  @override
  State<SubSubCategoriesScreen> createState() => _SubSubCategoriesScreenState();
}

class _SubSubCategoriesScreenState extends State<SubSubCategoriesScreen>
    with SubSubCategoriesData {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    getCategoryDetails(categoryId: widget.categoryId);
    getOptions(categoryId: widget.categoryId);
    getCategoryProduct(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SubSubCategoriesScreen oldWidget) {
    if (oldWidget.categoryId != widget.categoryId) {
      getCategoryDetails(categoryId: widget.categoryId);
      getOptions(categoryId: widget.categoryId);
      getCategoryProduct(categoryId: widget.categoryId);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
        appBar: AppBarCustom(ctx: context),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          width: double.infinity,
          height: 1.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
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
                      SizedBox(height: 8.h),
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
                  IconButton(
                      onPressed: () => context.router.back(),
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(height: 25.h),
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
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CustomNetworkImage(
                              link: category.categoryPhoto?.fullLink ?? '',
                              height: 250.sp,
                              width: 250.sp,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      isArabic ? (category.name ?? '') : (category.nameEn ?? ''),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: SizedBox(
                                        height: 40,
                                        child: TextField(
                                          controller: searchController,
                                          onChanged: (val) {
                                            setState(() {
                                              searchText = val.trim();
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: isArabic ? 'بحث عن منتج' : 'Search product',
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.categories),
                                    SizedBox(width: 10),
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
                          SizedBox(width: 10),
                          SizedBox(
                            height: 48,
                            width: 180,
                            child: AppButton(
                              onPress: () => addProductOption(categoryId: widget.categoryId),
                              titleFontSize: 14.sp,
                              title: isArabic ? 'إضافه خصائص' : 'Add features',
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: .5.sh,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                isScrollable: true,
                                indicator: BoxDecoration(
                                  color: const Color(0xffEBF4FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                labelStyle: AppFonts.apptextStyle.copyWith(
                                  color: Color(0xff003B7E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                unselectedLabelStyle: AppFonts.apptextStyle.copyWith(
                                  color: Color(0xff556377),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                tabs: [
                                  Tab(text: LocaleKeys.products.tr()),
                                  Tab(text: isArabic ? ' خصائص' : 'features'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    GenericBuilder(
                                      genericCubit: productsCubit,
                                      builder: (products) {
                                        final filtered = products.where((p) {
                                          final name = (p.name ?? '').toLowerCase();
                                          final nameEn = (p.nameEn ?? '').toLowerCase();
                                          return name.contains(searchText.toLowerCase()) ||
                                              nameEn.contains(searchText.toLowerCase());
                                        }).toList();
                                        return CategoryProducts(products: filtered);
                                      },
                                    ),
                                    GenericBuilder(
                                      genericCubit: optionsCubit,
                                      builder: (options) {
                                        return ProductOptionsWidget(
                                          options: options,
                                          types: types,
                                          reload: () => getOptions(categoryId: widget.categoryId),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
