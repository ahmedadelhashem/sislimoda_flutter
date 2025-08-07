import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

@RoutePage()
class DashBoardLayout extends StatefulWidget {
  const DashBoardLayout({super.key});

  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout> {
  @override
  Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  debugPrint('📱 Screen Width: $width');
  debugPrint('📏 Screen Height: $height');

    return Scaffold(
      drawer: context.isMobile
          ? SizedBox(width: .7.sw, child: SideBar())
          : SizedBox(),
      appBar: 1.sw < 1028
          ? AppBar(
              title: Text(
                '${LocaleKeys.hello.tr()} , ',
                style: AppFonts.apptextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.spMin,
                ),
              ),
            )
          : AppBar(
              toolbarHeight: 0,
            ),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Row(
          children: [
            if (1.sw > 1027) SizedBox(width: 300, child: SideBar()),
            Expanded(child: AutoRouter())
          ],
        ),
      ),
    );
  }
}
