// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_zoom_drawer/config.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class DrawerCustomScreen extends StatelessWidget {
//   const DrawerCustomScreen(
//       {Key? key,
//       required this.zoomDrawerController,
//       required this.menu,
//       required this.screen})
//       : super(key: key);
//   final ZoomDrawerController zoomDrawerController;
//   final Widget menu, screen;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: ZoomDrawer(
//         controller: zoomDrawerController,
//         menuScreen: menu,
//         mainScreen: screen,
//         openCurve: Curves.fastOutSlowIn,
//         showShadow: true,
//         slideWidth: MediaQuery.of(context).size.width * (isArabic ? .75 : 0.75),
//         isRtl: isArabic,
//         // mainScreenScale: .2,
//         // menuScreenOverlayColor:AppColors.unselectedColor,
//         closeCurve: Curves.easeInOutCirc,
//         clipMainScreen: false,
//         menuScreenTapClose: true,
//         mainScreenTapClose: true,
//         // androidCloseOnBackTap: true,
//
//         style: DrawerStyle.defaultStyle,
//         mainScreenOverlayColor: Colors.brown.withOpacity(0.05),
//         borderRadius: 20.r,
//         shadowLayer1Color: Colors.transparent,
//         angle: 0,
//         menuScreenWidth: double.infinity,
//         moveMenuScreen: false,
//       ),
//     );
//   }
// }
