import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class TabBarCustom extends StatelessWidget {
  final List<String> tabNames;
  final List<Widget> children;
  // final List<dynamic>? items;

  const TabBarCustom({
    required this.tabNames,
    required this.children,
    // required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // construct the profile details widget here
          SizedBox(
            height: 45.h,
            child: Container(
              padding: EdgeInsets.all(5.sm),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                color: const Color(0xffF7F7FA),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              child: Row(
                children: [
                  TabBar(
                    dividerColor: Colors.transparent,
                    // controller: tabController,
                    indicatorPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 0),

                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,

                    indicator: BoxDecoration(
                        color: const Color(0xffEBF4FF),
                        borderRadius: BorderRadius.circular(6)),
                    labelStyle: AppFonts.apptextStyle.copyWith(
                        color: Color(0xff003B7E),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    unselectedLabelStyle: AppFonts.apptextStyle.copyWith(
                        color: Color(0xff556377),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    tabs: [
                      for (var i = 0; i < tabNames.length; i++)
                        Tab(
                          text: tabNames[i],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // create widgets for each tab bar here
          Expanded(
            child: TabBarView(
              children: [
                for (var i = 0; i < tabNames.length; i++) children[i],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
