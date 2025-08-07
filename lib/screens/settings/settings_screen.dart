import 'package:auto_route/annotations.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/settings_data.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/countries.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/options_sets.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/product_options.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/settings_widget.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SettingsData, SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    getListCountries();
    getOptionsSets();
    getProductOptions();
    getSettings();
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 34, right: 34),
                width: double.infinity,
                height: 1.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'الإعدادات' : "Settings",
                              style: AppFonts.apptextStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.isMobile ? 14.spMin : 22),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      height: .8.sh,
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: DefaultTabController(
                                  length: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          TabBar(
                                            dividerColor: Colors.transparent,
                                            controller: tabController,
                                            indicatorPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 6, horizontal: 0),
                                            tabAlignment: TabAlignment.start,
                                            isScrollable: true,
                                            indicatorSize: TabBarIndicatorSize.tab,
                                            onTap: (index) {
                                              setState(() {});
                                            },
                                            indicator: BoxDecoration(
                                                color: const Color(0xffEBF4FF),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            labelStyle: AppFonts.apptextStyle
                                                .copyWith(
                                                    color: Color(0xff003B7E),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                            unselectedLabelStyle:
                                                AppFonts.apptextStyle.copyWith(
                                                    color: Color(0xff556377),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400),
                                            tabs: [
                                              Tab(
                                                text: isArabic
                                                    ? 'الدول'
                                                    : 'Countries',
                                              ),
                                              Tab(
                                                text: isArabic
                                                    ? 'مجموعة الخيارات'
                                                    : 'Option set',
                                              ),
                                              // Tab(
                                              //   text: isArabic
                                              //       ? 'خيارات المنتجات'
                                              //       : 'Products options',
                                              // ),
                                              Tab(
                                                text: isArabic
                                                    ? 'المحتوي الثابت'
                                                    : 'Static Content',
                                              ),
                                              // Tab(
                                              //   text: isArabic
                                              //       ? 'الإحصائيات'
                                              //       : 'Statistics',
                                              // )
                                            ],
                                          ),
                                          Spacer(),
                                          if (tabController.index < 2)
                                            SizedBox(
                                                height: 35,
                                                width: 100,
                                                child: AppButton(
                                                  title: LocaleKeys.add.tr(),
                                                  onPress: () async {
                                                    if (tabController.index == 0) {
                                                      showCountryPicker(
                                                          context: context,
                                                          showPhoneCode: false,
                                                          onSelect: addCountry);
                                                    } else if (tabController
                                                            .index ==
                                                        1) {
                                                      addOptionSet();
                                                    }
                                                  },
                                                ))
                                        ],
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            GenericBuilder(
                                                genericCubit: countriesCubit,
                                                builder: (countries) {
                                                  return Countries(
                                                    countries: countries,
                                                  );
                                                }),
                                            GenericBuilder(
                                                genericCubit: optionSetsCubit,
                                                builder: (optionsSets) {
                                                  return OptionsSets(
                                                    optionSets: optionsSets,
                                                    reload: getOptionsSets,
                                                  );
                                                }),
                                            // GenericBuilder(
                                            //     genericCubit: productOptionsCubit,
                                            //     builder: (productOptions) {
                                            //       return ProductOptionsWidget(
                                            //         options: productOptions,
                                            //         reload: getProductOptions,
                                            //       );
                                            //     }),
                                            GenericBuilder(
                                                genericCubit: settingsCubit,
                                                builder: (settings) {
                                                  return SettingsWidget(
                                                    settings: settings,
                                                    reload: () {},
                                                  );
                                                }),
                                            // Statistics(dataSource: [],)
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
