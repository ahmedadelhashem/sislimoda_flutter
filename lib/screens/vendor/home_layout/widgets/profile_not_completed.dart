import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/models/vendor_models/vendor_model.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/arch_plane.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/vendor_complete_details.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class ProfileNotCompleted extends StatefulWidget {
  const ProfileNotCompleted({super.key, required this.vendorModel});
  final VendorModel vendorModel;
  @override
  State<ProfileNotCompleted> createState() => _ProfileNotCompletedState();
}

class _ProfileNotCompletedState extends State<ProfileNotCompleted> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF5F6),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
        child: SizedBox(
          width: 1.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 200,
                  width: 1.sw,
                  height: 1.sh - 150,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = constraints.maxWidth;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 66.w),

                            Column(
                              children: [
                                const SizedBox(height: 230),
                                SvgPicture.asset(
                                  AppImages.turkey,
                                  height: 140.w,
                                  width: 400.w,
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
                            ),

                            // Dynamic space based on screen width
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: VendorCompleteDetails(),
                            ),

                            Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                ),
                                SvgPicture.asset(
                                  AppImages.flags,
                                  height: 377.w,
                                  width: 490.w,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),

                            SizedBox(width: 78),
                          ],
                        ),
                      );
                    },
                  )),
              Positioned(top: 90, child: ArchPlane()),
              Positioned(
                  top: 55,
                  child: Container(
                    width: 251,
                    // height: 78,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: AppColors.mainColor),
                    //     color: Colors.white),
                    child: Image.asset(
                      AppImages.sis,
                      fit: BoxFit.fitWidth,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
