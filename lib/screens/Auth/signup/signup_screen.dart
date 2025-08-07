import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/screens/Auth/signup/widgets/signup_form.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/widgets/arch_plane.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
        child: SizedBox(
          width: 1.sw,
          child: 1.sw > 834
              ? Stack(
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
                                    child: SignupForm(),
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
                )
              : 1.sw > 834 && 1.sw < 834
                  ? tabletDesign()
                  : mobileDesign(),
        ),
      ),
    );
  }

  tabletDesign() {
    return Stack(
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
                  child: 1.sw > 834
                      ? Row(
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
                              child: SignupForm(),
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
                        )
                      : SizedBox(
                          width: screenWidth,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 45.w),
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.turkey,
                                          height: 107.h,
                                          width: 251.h,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        SvgPicture.asset(
                                          AppImages.flags,
                                          height: 296.h,
                                          width: 227.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 45.w),
                                  ],
                                ),

                                // Dynamic space based on screen width
                                SizedBox(
                                  width: screenWidth * 0.8,
                                  child: SignupForm(),
                                ),

                                SizedBox(width: 78),
                              ],
                            ),
                          ),
                        ),
                );
              },
            )),
        Positioned(top: 90, child: ArchPlane()),
        Positioned(
            top: 1.sw > 834 ? 251 : 75,
            child: Container(
              width: 1.sw > 834 ? 251 : 116,
              child: Image.asset(
                AppImages.sis,
                fit: BoxFit.fitWidth,
              ),
            )),
      ],
    );
  }

  mobileDesign() {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ArchPlane(),
                Positioned(
                  top: 10.h,
                  child: Container(
                    width: 1.sw > 834 ? 251 : 116,
                    child: Image.asset(
                      AppImages.sis,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            )),
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              SvgPicture.asset(
                                AppImages.turkey,
                                height: 51.h,
                                width: 122.h,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              SvgPicture.asset(
                                AppImages.flags,
                                height: 132.h,
                                width: 109.h,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),

                      // Dynamic space based on screen width
                      SizedBox(
                        width: screenWidth,
                        child: SignupForm(),
                      ),

                      SizedBox(width: 78),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
