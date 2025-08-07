import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/no_result_found.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/categories_data.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/category_item.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

@RoutePage()
class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}
// ...existing imports...

class _CategoriesState extends State<Categories> with CategoriesData {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    getCategories();
    super.initState();
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 34, right: 34),
        width: double.infinity,
        height: 1.sh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            // مربع البحث في صف مستقل
          
            SizedBox(height: 16),
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
                          fontSize: context.isMobile ? 14.spMin : 22),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        LocaleKeys.categoryManagementHint.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: context.isMobile ? 12.spMin : 16),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 10,),
                  SizedBox(
              width: 250,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.search.tr(),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                ),
                onChanged: (val) {
                  setState(() {
                    searchText = val.trim();
                  });
                },
              ),
            ),
                Spacer(),
                SizedBox(
                  width: context.isMobile ? 80.spMin : 247,
                  height: context.isMobile ? 35.h : 40,
                  child: AppButton(
                    title: LocaleKeys.addCategory.tr(),
                    onPress: () {
                      addCategory();
                    },
                    titleFontColor: Colors.white,
                    titleFontSize: context.isMobile ? 11.spMin : 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: Screen(
                loadingCubit: BlocProvider.of<CategoriesCubit>(context).loading,
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoaded) {
                      final filteredCategories = state.categories.where((cat) {
                        final name = (cat.name ?? '').toLowerCase();
                        final nameEn = (cat.nameEn ?? '').toLowerCase();
                        return name.contains(searchText.toLowerCase()) ||
                            nameEn.contains(searchText.toLowerCase());
                      }).toList();

                      return filteredCategories.isNotEmpty
                          ? GridView.builder(
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  crossAxisSpacing: 24,
                                  mainAxisSpacing: 24,
                                  maxCrossAxisExtent: 350,
                                  mainAxisExtent: 230),
                              itemCount: filteredCategories.length,
                              itemBuilder: (context, index) {
                                return CategoryItem(
                                  categoryItem: filteredCategories[index],
                                  delete: () {
                                    CustomAlert.showConfirmDialogue(
                                        confirmDone: () async {
                                          BlocProvider.of<CategoriesCubit>(context).loading.show;
                                          await deleteCategory(
                                              category: filteredCategories[index],
                                              index: index);
                                          BlocProvider.of<CategoriesCubit>(context).getCategories();
                                          BlocProvider.of<CategoriesCubit>(context).loading.hide;
                                        },
                                        message: LocaleKeys.confirmDeleteCategory.tr(),
                                        context: context);
                                  },
                                  update: () {
                                    updateCategory(updateCategory: filteredCategories[index]);
                                  },
                                );
                              },
                            )
                          : SizedBox(
                              width: 1.sw,
                              child: Center(
                                  child: NoResultFound(
                                title: LocaleKeys.noCategoriesFound.tr(),
                              )));
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  @override
Widget build(BuildContext context) {
  // final isMobile = context.width < 600;

  return Scaffold(
    appBar: AppBarCustom(ctx: context),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 16 : 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            LocaleKeys.categoryManagement.tr(),
            style: AppFonts.apptextStyle.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: context.isMobile ? 18 : 22,
            ),
          ),
          SizedBox(height: 8),
          Text(
            LocaleKeys.categoryManagementHint.tr(),
            style: AppFonts.apptextStyle.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: context.isMobile ? 12.spMin : 16,
            ),
          ),
          SizedBox(height: 16),
          if (context.isMobile)
            Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.search.tr(),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchText = val.trim();
                    });
                  },
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    title: LocaleKeys.addCategory.tr(),
                    onPress: () {
                      addCategory();
                    },
                    titleFontColor: Colors.white,
                    titleFontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          else
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.search.tr(),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchText = val.trim();
                      });
                    },
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 247,
                  height: 40,
                  child: AppButton(
                    title: LocaleKeys.addCategory.tr(),
                    onPress: () {
                      addCategory();
                    },
                    titleFontColor: Colors.white,
                    titleFontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          SizedBox(height: 25.h),
          Expanded(
            child: Screen(
              loadingCubit: BlocProvider.of<CategoriesCubit>(context).loading,
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoaded) {
                    final filteredCategories = state.categories.where((cat) {
                      final name = (cat.name ?? '').toLowerCase();
                      final nameEn = (cat.nameEn ?? '').toLowerCase();
                      return name.contains(searchText.toLowerCase()) ||
                          nameEn.contains(searchText.toLowerCase());
                    }).toList();

                    return filteredCategories.isNotEmpty
                        ? GridView.builder(
                            padding: EdgeInsets.only(bottom: 24),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              maxCrossAxisExtent: context.isMobile ? 300 : 350,
                              mainAxisExtent: 230,
                            ),
                            itemCount: filteredCategories.length,
                            itemBuilder: (context, index) {
                              return CategoryItem(
                                categoryItem: filteredCategories[index],
                                delete: () {
                                  CustomAlert.showConfirmDialogue(
                                    confirmDone: () async {
                                      BlocProvider.of<CategoriesCubit>(context).loading.show;
                                      await deleteCategory(
                                          category: filteredCategories[index],
                                          index: index);
                                      BlocProvider.of<CategoriesCubit>(context).getCategories();
                                      BlocProvider.of<CategoriesCubit>(context).loading.hide;
                                    },
                                    message: LocaleKeys.confirmDeleteCategory.tr(),
                                    context: context,
                                  );
                                },
                                update: () {
                                  updateCategory(updateCategory: filteredCategories[index]);
                                },
                              );
                            },
                          )
                        : Center(
                            child: NoResultFound(
                              title: LocaleKeys.noCategoriesFound.tr(),
                            ),
                          );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}