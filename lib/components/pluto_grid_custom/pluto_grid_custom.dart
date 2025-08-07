// import 'package:flutter/material.dart';
// import 'package:pluto_grid/pluto_grid.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
//
// class PlutoGridCustom extends StatefulWidget {
//   const PlutoGridCustom(
//       {super.key,
//       required this.columns,
//       required this.rows,
//       this.createHeader,
//       this.createFooter,
//       this.onLoaded});
//   final List<PlutoColumn> columns;
//   final List<PlutoRow> rows;
//   final Widget Function(PlutoGridStateManager)? createHeader;
//   final Widget Function(PlutoGridStateManager)? createFooter;
//   final Function(PlutoGridOnLoadedEvent)? onLoaded;
//   @override
//   State<PlutoGridCustom> createState() => _PlutoGridCustomState();
// }
//
// class _PlutoGridCustomState extends State<PlutoGridCustom> {
//   @override
//   Widget build(BuildContext context) {
//     return PlutoGrid(
//         configuration: PlutoGridConfiguration(
//             style: PlutoGridStyleConfig(
//                 cellTextStyle: AppFonts.apptextStyle.copyWith(
//                     color: AppColors.secondaryFontColor,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 columnTextStyle: AppFonts.apptextStyle.copyWith(
//                     color: AppColors.secondaryFontColor,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 activatedBorderColor: Colors.transparent,
//                 activatedColor: Colors.transparent,
//                 borderColor: Colors.transparent,
//                 gridBorderColor: Colors.transparent)),
//         createHeader: widget.createHeader,
//         columns: widget.columns,
//         createFooter: widget.createFooter,
//         onLoaded: widget.onLoaded,
//         rows: widget.rows);
//   }
// }
