import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/layout_data.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/pending.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/profile_not_completed.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/rejected.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/subscription_canceled.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/waitng_activation.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

@RoutePage()
class VendorHomeLayout extends StatefulWidget {
  const VendorHomeLayout({super.key});

  @override
  State<VendorHomeLayout> createState() => _VendorHomeLayoutState();
}

class _VendorHomeLayoutState extends State<VendorHomeLayout> with LayoutData {
  @override
  void initState() {
    // TODO: implement initState
    getVendorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenericBuilder(
        genericCubit: vendorCubit,
        builder: (vendor) {
          // if (checkIfProfileNotCompleted(vendor: vendor)) {
          //   return ProfileNotCompleted(
          //     vendorModel: vendor,
          //   );
          // } else
          //   if (vendor.vendorStatus?.value == '1') {
          //   return Scaffold(
          //     body: WaitingActivation(),
          //   );
          // } else
          if (vendor.vendorStatus?.value == '2') {
            return Scaffold(
              body: Pending(),
            );
          } else if (vendor.vendorStatus?.value == '3' ||
              vendor.vendorStatus?.value == '1') {
            return Scaffold(
              drawer: context.isMobile
                  ? SizedBox(width: .7.sw, child: const VendorSideBar())
                  : SizedBox(),
              appBar: 1.sw < 1026
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
                    if (1.sw > 1026)
                      SizedBox(width: 300, child: VendorSideBar()),
                    Expanded(child: AutoRouter())
                  ],
                ),
              ),
            );
          } else if (vendor.vendorStatus?.value == '4') {
            return Scaffold(
              body: Rejected(),
            );
          } else if (vendor.vendorStatus?.value == '5') {
            return Scaffold(
              body: SubscriptionCanceled(),
            );
          }
          return SizedBox();
        });
  }
}
