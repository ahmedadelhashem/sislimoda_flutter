import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:flutter/material.dart';

///[Tap] to draw at tap
class Tap extends StatelessWidget {
  final List<Widget> pageChildren;
  final List<String> headers;
  final int tapNumber;
  final Color activeColor;
  final Color inactiveColor;
  final List<Function> onTap;

   Tap({
    required this.pageChildren,
    required this.headers,
    required this.tapNumber,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (pageChildren.length == tapNumber && headers.length == tapNumber) {
      return DefaultTabController(
        length: tapNumber,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  onTap: (index) {
                    if (onTap.length != 0 && index <= onTap.length) {
                      onTap[index]();
                    }
                  },
                  key: const PageStorageKey('key2'),
                  indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 3.5,
                        color: AppColors.mainColor,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 50.0)),
                  labelColor: AppColors.mainColor,
                  indicatorColor: AppColors.mainColor,
                  isScrollable: false,
                  labelStyle: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.mainfont,
                      height: 1),
                  unselectedLabelColor: AppColors.mainColor.withOpacity(.5),
                  tabs: [
                    for (var j = 0; j < tapNumber; j++)
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${headers[j]} ',
                          textAlign: TextAlign.center,
                        ),
                      ))
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(
            key: PageStorageKey('key2'),
            children: [
              for (var i = 0; i < tapNumber; i++) pageChildren[i],
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: Text(
          'Header.length must equal numer of page and number of header',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
  }
}
