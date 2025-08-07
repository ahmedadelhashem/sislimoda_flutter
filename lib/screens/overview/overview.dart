import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/count_item.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/getVisitorCount.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/products_data_table.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/overview_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with OverviewData {
  TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  int _visitorCount = 0;


  @override
  void initState() {
    // TODO: implement initState
    getAnalysis();
   fetchVisitorCount(); 
    super.initState();
  }
  
void fetchVisitorCount() async {
  final count = await getVisitorCount();
  if (count != null) {
    setState(() {
      _visitorCount = count;
    });
  }
}


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';  

  return Scaffold(
    appBar: AppBarCustom(ctx: context),
    body: Screen(
      loadingCubit: loading,
      child: GenericBuilder<GetAnalysisModel>(
        genericCubit: analysisCubit,
        builder: (data) {
          final filteredProducts = data.topSellingProducts?.where((item) {
            final name = isArabic
                ? item?.product?.name ?? ''
                : item?.product?.nameEn ?? '';
            return name.toLowerCase().contains(_searchTerm.toLowerCase());
          }).toList();

          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        CountItem(
                          title: LocaleKeys.categories.tr(),
                          count: data.totalCategoryAndSubCategory ?? '0',
                        ),
                        CountItem(
                          title: LocaleKeys.clientsCounnt.tr(),
                          count: data.numberOfVendors ?? '0',
                        ),
                        CountItem(
                          title: LocaleKeys.ordersCount.tr(),
                          count: data.totalOrders ?? '0',
                        ),
                        CountItem(
                          title: LocaleKeys.productsCount.tr(),
                          count: data.totalProducts ?? '0',
                        ),
                        CountItem(
                          title: isArabic ? 'عدد الزائرين' : 'Visitor Count',
                          count: _visitorCount.toString(),
                          ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 250,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.shade300),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchTerm = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: LocaleKeys.search.tr(),
                                prefixIcon: const Icon(Icons.search, size: 20),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    ProductsDataTable(products: filteredProducts),

                    // SizedBox(height: 24.h),

                    // ProductsDataTable(products: data.topSellingProducts),
                  ],
                ),
              );
            },
          );
        },
      ),
    ),
  );
}

}


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
      ),
      body: Screen(
        loadingCubit: loading,
        child: GenericBuilder<GetAnalysisModel>(
            genericCubit: analysisCubit,
            builder: (data) {
              final filteredProducts = data.topSellingProducts?.where((item) {
                final name = isArabic
                    ? item?.product?.name ?? ''
                    : item?.product?.nameEn ?? '';
                return name.toLowerCase().contains(_searchTerm.toLowerCase());
              }).toList();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                CountItem(
                                  title: LocaleKeys.categories.tr(),
                                  count:
                                      data.totalCategoryAndSubCategory ?? '0',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CountItem(
                                  title: LocaleKeys.clientsCounnt.tr(),
                                  count: data.numberOfVendors ?? '0',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CountItem(
                                  title: LocaleKeys.ordersCount.tr(),
                                  count: data.totalOrders ?? '0',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CountItem(
                                  title: LocaleKeys.productsCount.tr(),
                                  count: data.totalProducts ?? '0',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 250),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // لون الخلفية
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors
                                              .grey.shade300), // خط خفيف حوله
                                    ),
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (value) {
                                        setState(() {
                                          _searchTerm = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            LocaleKeys.search.tr(), // "بحث..."
                                        prefixIcon:
                                            Icon(Icons.search, size: 20),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Row(
                            //   children: [
                            //     CountItem(
                            //       title: LocaleKeys.ordersCount.tr(),
                            //       count: data.totalOrders ?? '0',
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     CountItem(
                            //       title: LocaleKeys.productsCount.tr(),
                            //       count: data.totalProducts ?? '0',
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // TopCategories(
                        //   products: data.data?.frequentSoldCategories,
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ProductsDataTable(products: filteredProducts),
                    ProductsDataTable(
                      products: data.topSellingProducts,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  } */