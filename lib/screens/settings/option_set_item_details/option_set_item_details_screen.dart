import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/option_set_item_details/option_set_item_details_data.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/option_set_item_details/widgets/option_set_items.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class OptionSetItemDetailsScreen extends StatefulWidget {
  const OptionSetItemDetailsScreen({
    super.key,
    @pathParam required this.optionSetId,
  });
  final String optionSetId;
  @override
  State<OptionSetItemDetailsScreen> createState() =>
      _OptionSetItemDetailsScreenState();
}

class _OptionSetItemDetailsScreenState extends State<OptionSetItemDetailsScreen>
    with OptionSetItemDetailsData {
  @override
  void initState() {
    // TODO: implement initState
    getOptionsSet(optionSetId: widget.optionSetId);
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
            padding: const EdgeInsets.only(left: 34, right: 34),
            width: double.infinity,
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.settings.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22),
                        ),
                        // SizedBox(
                        //   height: 8.h,
                        // ),
                        // Text(
                        //   LocaleKeys.setting.tr(),
                        //   style: AppFonts.apptextStyle.copyWith(
                        //       color: AppColors.black,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: context.isMobile ? 12.spMin : 16),
                        // ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          context.router.back();
                        },
                        icon: Icon(Icons.arrow_forward))
                  ],
                ),
                GenericBuilder(
                    genericCubit: optionSetCubit,
                    builder: (optionSet) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isArabic
                                          ? (optionSet.displayNameAr ?? '')
                                          : (optionSet.displayNameEN ?? ''),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: .65.sh,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            // padding: EdgeInsets.all(10),
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
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
                                Container(
                                  height: .48.sh,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: DefaultTabController(
                                      length: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              TabBar(
                                                dividerColor:
                                                    Colors.transparent,
                                                indicatorPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 0),
                                                tabAlignment:
                                                    TabAlignment.start,
                                                isScrollable: true,
                                                indicatorSize:
                                                    TabBarIndicatorSize.tab,
                                                indicator: BoxDecoration(
                                                    color:
                                                        const Color(0xffEBF4FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                labelStyle: AppFonts
                                                    .apptextStyle
                                                    .copyWith(
                                                        color:
                                                            Color(0xff003B7E),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                unselectedLabelStyle: AppFonts
                                                    .apptextStyle
                                                    .copyWith(
                                                        color:
                                                            Color(0xff556377),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                tabs: [
                                                  Tab(
                                                    text: isArabic
                                                        ? 'العناصر'
                                                        : 'items',
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: AppButton(
                                                  title: LocaleKeys.add.tr(),
                                                  onPress: () {
                                                    addItem(
                                                        optionSetId:
                                                            widget.optionSetId);
                                                  },
                                                  titleFontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                OptionSetItems(
                                                  items: optionSet
                                                          .optionSetItems ??
                                                      [],
                                                  optionSetId:
                                                      widget.optionSetId,
                                                  reload: () {
                                                    getOptionsSet(
                                                        optionSetId:
                                                            widget.optionSetId);
                                                  },
                                                )
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
