import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
import 'package:sislimoda_admin_dashboard/models/users/DashboardUserModel.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class DashboardUsersDatatable extends StatefulWidget {
  const DashboardUsersDatatable(
      {super.key,
      required this.dashboardUsersCubit,
      required this.updateUser,
      required this.deleteUser});
  final GenericCubit<List<DashboardUserModel>> dashboardUsersCubit;
  final Function(DashboardUserModel) updateUser;
  final Function(String) deleteUser;
  @override
  State<DashboardUsersDatatable> createState() =>
      _DashboardUsersDatatableState();
}

class _DashboardUsersDatatableState extends State<DashboardUsersDatatable> {
  @override
  Widget build(BuildContext context) {
    return GenericBuilder<List<DashboardUserModel>>(
        genericCubit: widget.dashboardUsersCubit,
        builder: (response) {
          return DataTable2(
            dividerThickness: 0,
            columns: [
              DataColumn2(
                label: Text(
                  LocaleKeys.id.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.clientName.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.mobileNumber.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.M,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.email.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.status.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(
                  '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.S,
              ),
            ],
            rows: response
                .map((element) => DataRow2(cells: [
                      DataCell(Text(
                        '#${response.indexOf(element) + 1}',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Text(
                        element.name ?? 'غير مكتمل',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Text(
                        element.phoneNumber ?? 'غير مكتمل',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Text(
                        element.email ?? '',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Center(
                              child: Text(
                                'نشط',
                                style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black),
                              ),
                            ),
                          ),
                        ],
                      )),
                      DataCell(PopupMenuButton(
                          position: PopupMenuPosition.under,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          constraints: BoxConstraints(minWidth: 110.w),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    // update();
                                    widget.updateUser(element);
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.update,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LocaleKeys.edit.tr(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                              PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    // delete();
                                    widget.deleteUser(element.id ?? '');
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.delete,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LocaleKeys.delete.tr(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: AppColors.error,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                            ];
                          },
                          child: Icon(Icons.more_horiz))),
                    ]))
                .toList(),
          );
        });
  }
}







/*
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class DashboardUsersDatatable extends StatefulWidget {
  const DashboardUsersDatatable(
      {super.key,
      required this.dashboardUsersCubit,
      required this.updateUser,
      required this.deleteUser});
  final GenericCubit<List<UserModel>> dashboardUsersCubit;
  final Function(UserModel) updateUser;
  final Function(String) deleteUser;
  @override
  State<DashboardUsersDatatable> createState() =>
      _DashboardUsersDatatableState();
}

class _DashboardUsersDatatableState extends State<DashboardUsersDatatable> {
  @override
  Widget build(BuildContext context) {
    return GenericBuilder<List<UserModel>>(
        genericCubit: widget.dashboardUsersCubit,
        builder: (response) {
          return DataTable2(
            dividerThickness: 0,
            columns: [
              DataColumn2(
                label: Text(
                  LocaleKeys.id.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.clientName.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.mobileNumber.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.M,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.email.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  LocaleKeys.status.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text(
                  '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                size: ColumnSize.S,
              ),
            ],
            rows: response
                .map((element) => DataRow2(cells: [
                      DataCell(Text(
                        '#${response.indexOf(element) + 1}',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Text(
                        element.name ?? 'غير مكتمل',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Text(
                        element.phoneNumber ?? 'غير مكتمل',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Text(
                        element.email ?? '',
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      )),
                      DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Center(
                              child: Text(
                                'نشط',
                                style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black),
                              ),
                            ),
                          ),
                        ],
                      )),
                      DataCell(PopupMenuButton(
                          position: PopupMenuPosition.under,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          constraints: BoxConstraints(minWidth: 110.w),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    // update();
                                    widget.updateUser(element);
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.update,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LocaleKeys.edit.tr(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                              PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    // delete();
                                    widget.deleteUser(element.id ?? '');
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.delete,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LocaleKeys.delete.tr(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: AppColors.error,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                            ];
                          },
                          child: Icon(Icons.more_horiz))),
                    ]))
                .toList(),
            // rows: products
            //     .map(
            //       (e) => DataRow2(
            //     cells: [
            //       DataCell(Text(
            //         e.slug ?? '',
            //         style: AppFonts
            //             .apptextStyle
            //             .copyWith(
            //             fontSize: 16,
            //             fontWeight:
            //             FontWeight
            //                 .w400,
            //             color: AppColors
            //                 .secondaryFontColor),
            //       )),
            //       DataCell(Text(
            //         isArabic
            //             ? (e.name?.AR ??
            //             '')
            //             : (e.name?.EN ??
            //             ''),
            //         style: AppFonts
            //             .apptextStyle
            //             .copyWith(
            //             fontSize: 16,
            //             fontWeight:
            //             FontWeight
            //                 .w400,
            //             color: AppColors
            //                 .secondaryFontColor),
            //       )),
            //       DataCell(Text(
            //         e.V ?? '',
            //         style: AppFonts
            //             .apptextStyle
            //             .copyWith(
            //             fontSize: 16,
            //             fontWeight:
            //             FontWeight
            //                 .w400,
            //             color: AppColors
            //                 .secondaryFontColor),
            //       )),
            //       DataCell(Text(
            //         e.mainPrice ?? '',
            //         style: AppFonts
            //             .apptextStyle
            //             .copyWith(
            //             fontSize: 16,
            //             fontWeight:
            //             FontWeight
            //                 .w400,
            //             color: AppColors
            //                 .secondaryFontColor),
            //       )),
            //       DataCell(Text(
            //         e.soldQuantity ?? '',
            //         style: AppFonts
            //             .apptextStyle
            //             .copyWith(
            //             fontSize: 16,
            //             fontWeight:
            //             FontWeight
            //                 .w400,
            //             color: AppColors
            //                 .secondaryFontColor),
            //       )),
            //       DataCell(
            //         Column(
            //           mainAxisAlignment:
            //           MainAxisAlignment
            //               .center,
            //           children: [
            //             InkWell(
            //               onTap: () {},
            //               child:
            //               Container(
            //                 padding: const EdgeInsets
            //                     .symmetric(
            //                     horizontal:
            //                     21,
            //                     vertical:
            //                     8),
            //                 decoration:
            //                 BoxDecoration(
            //                   borderRadius:
            //                   BorderRadius
            //                       .circular(8),
            //                   border: Border.all(
            //                       color: AppColors
            //                           .mainColor),
            //                 ),
            //                 child: Center(
            //                   child: Text(
            //                     LocaleKeys
            //                         .productsDetails
            //                         .tr(),
            //                     style: AppFonts.apptextStyle.copyWith(
            //                         fontSize:
            //                         14,
            //                         fontWeight: FontWeight
            //                             .w700,
            //                         color:
            //                         AppColors.mainColor),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
            //     .toList(),
          );
        });
  }
}
*/