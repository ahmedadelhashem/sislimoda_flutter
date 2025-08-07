import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/count_item.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/products_data_table.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_overview_screen/vendor_overview_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class VendorOverviewScreen extends StatefulWidget {
  const VendorOverviewScreen({super.key});

  @override
  State<VendorOverviewScreen> createState() => _VendorOverviewScreenState();
}

class _VendorOverviewScreenState extends State<VendorOverviewScreen>
    with VendorOverviewData {
  @override
  void initState() {
    // TODO: implement initState
    getAnalysis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';  
  final isTurkish = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
        search: (text) {},
      ),
      body: Screen(
        loadingCubit: loading,
        child: GenericBuilder<GetAnalysisModel>(
            genericCubit: analysisCubit,
            builder: (data) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CountItem(
                                  title: LocaleKeys.soldNumber.tr(),
                                  count: data.totalSoldProducts ?? '0',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CountItem(
                                  title: isArabic ? "الإرادات" : isTurkish ? "Gelir" :
                                   "revenue",
                                  count: data.totalRevenue ?? '0',
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CountItem(
                                  title: LocaleKeys.productsCount.tr(),
                                  count: data.totalProduct ?? '0',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   children: [
                            //     // CountItem(
                            //     //   title: LocaleKeys.ordersCount.tr(),
                            //     //   count: data.totalOrders ?? '0',
                            //     // ),
                            //     // SizedBox(
                            //     //   width: 10,
                            //     // ),
                            //
                            //   ],
                            // ),
                          ],
                        ),

                        // TopCategories(
                        //   products: data.data?.frequentSoldCategories,
                        // )
                      ],
                    ),
                    ProductsDataTable(
                      products: data.topSellingProducts,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
