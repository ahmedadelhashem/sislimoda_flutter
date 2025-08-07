import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/no_result_found.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/pharmacies/pharmacies_data.dart';
import 'package:sislimoda_admin_dashboard/screens/pharmacies/widgets/pharmacy_item.dart';
import 'package:sislimoda_admin_dashboard/screens/pharmacies/widgets/pharmacy_request_item.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

@RoutePage()
class PharmaciesScreen extends StatefulWidget {
  const PharmaciesScreen({super.key});

  @override
  State<PharmaciesScreen> createState() => _PharmaciesScreenState();
}

class _PharmaciesScreenState extends State<PharmaciesScreen>
    with PharmaciesData {
      String? _selectedStatusId;

  String _searchTerm = '';
  void search(String value) {
    setState(() {
      _searchTerm = value.trim().toLowerCase();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getAllPharmacies();
// getAllVendorsStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
            search: search,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 34, right: 34),
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
                          LocaleKeys.clientManagement.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          LocaleKeys.clientManagementHint.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.isMobile ? 12.spMin : 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    // SizedBox(
                    //     height: 40,
                    //     width: isPharmacies ? 300 : 200,
                    //     child: AppButton(
                    //       title: isPharmacies
                    //           ? LocaleKeys.requestsThatNeedToReReviewed.tr()
                    //           : LocaleKeys.pharmacies.tr(),
                    //       titleFontSize: 16,
                    //       onPress: () {
                    //         isPharmacies = !isPharmacies;
                    //         setState(() {});
                    //       },
                    //     ))
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                     if (isPharmacies)
                GenericBuilder(
                  genericCubit: pharmaciesCubit,
                  builder: (pharmacies) {
 final filtered = pharmacies.where((pharmacy) {
  final name = (isArabic
          ? pharmacy.name?.toLowerCase()
          : pharmacy.nameEn?.toLowerCase()) ??
      '';
  final matchesSearch = name.contains(_searchTerm.toLowerCase());

  final statusId = pharmacy.vendorStatus?.id?.toString();
  final matchesStatus =
      _selectedStatusId == null || _selectedStatusId == statusId;

  return matchesSearch && matchesStatus;
}).toList();

filtered.sort((a, b) {
  final aStatus = isArabic
      ? a.vendorStatus?.nameAr?.toLowerCase()
      : a.vendorStatus?.nameEn?.toLowerCase();
  final bStatus = isArabic
      ? b.vendorStatus?.nameAr?.toLowerCase()
      : b.vendorStatus?.nameEn?.toLowerCase();

  final aIsNew = aStatus == "جديد" || aStatus == "new" ? 0 : 1;
  final bIsNew = bStatus == "جديد" || bStatus == "new" ? 0 : 1;

  return aIsNew.compareTo(bIsNew);
});

                    return   Expanded(
        child: ListView.separated(
          itemCount: filtered.length,
          separatorBuilder: (_,__) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            return PharmacyItem(
              pharmacy: filtered[index],
              approvePharmacy: () {
                approvePharmacy(
                  pharmacyId: filtered[index].id ?? '',
                );
              },
            );
          },
        ),
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


/*
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/no_result_found.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/pharmacies/pharmacies_data.dart';
import 'package:sislimoda_admin_dashboard/screens/pharmacies/widgets/pharmacy_item.dart';
import 'package:sislimoda_admin_dashboard/screens/pharmacies/widgets/pharmacy_request_item.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

@RoutePage()
class PharmaciesScreen extends StatefulWidget {
  const PharmaciesScreen({super.key});

  @override
  State<PharmaciesScreen> createState() => _PharmaciesScreenState();
}

class _PharmaciesScreenState extends State<PharmaciesScreen>
    with PharmaciesData {
  String _searchTerm = '';
  void search(String value) {
    setState(() {
      _searchTerm = value.trim().toLowerCase();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getAllPharmacies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
            search: search,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 34, right: 34),
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
                          LocaleKeys.clientManagement.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          LocaleKeys.clientManagementHint.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.isMobile ? 12.spMin : 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    // SizedBox(
                    //     height: 40,
                    //     width: isPharmacies ? 300 : 200,
                    //     child: AppButton(
                    //       title: isPharmacies
                    //           ? LocaleKeys.requestsThatNeedToReReviewed.tr()
                    //           : LocaleKeys.pharmacies.tr(),
                    //       titleFontSize: 16,
                    //       onPress: () {
                    //         isPharmacies = !isPharmacies;
                    //         setState(() {});
                    //       },
                    //     ))
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                     if (isPharmacies)
                GenericBuilder(
                  genericCubit: pharmaciesCubit,
                  builder: (pharmacies) {
                    final filtered = pharmacies.where((pharmacy) {
                      final name = pharmacy.name?.toLowerCase() ?? '';
                      return name.contains(_searchTerm);
                    }).toList();
                    return Expanded(
                      child: GridView.builder(
                        itemCount: filtered.length,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 336,
                          mainAxisExtent: 350,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          return PharmacyItem(
                            pharmacy: filtered[index],
                            approvePharmacy: () {
                              approvePharmacy(
                                pharmacyId: filtered[index].id ?? '',
                              );
                            },
                          );
                        },
                      ),
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
*/