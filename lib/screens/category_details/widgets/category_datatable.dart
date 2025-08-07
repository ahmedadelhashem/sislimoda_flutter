import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class CategoriesDataTable extends StatefulWidget {
  const CategoriesDataTable(
      {super.key,
      required this.categories,
      required this.updateCategory,
      required this.navigate});
  final List<CategoryModel> categories;
  final Function(CategoryModel) updateCategory;
  final Function(CategoryModel) navigate;
  @override
  State<CategoriesDataTable> createState() => _CategoriesDataTableState();
}

class _CategoriesDataTableState extends State<CategoriesDataTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      dividerThickness: 0,
      headingRowDecoration: BoxDecoration(
          color: Colors.indigo.withOpacity(.1),
          borderRadius: BorderRadius.circular(20)),
      columns: [
        DataColumn2(
          label: Text(
            LocaleKeys.categoryImage.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.categoryName.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.description.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            '',
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
      ],
      rows: widget.categories.isNotEmpty
          ? widget.categories.map((element) {
              return DataRow2(
                  color: widget.categories.indexOf(element).isEven
                      ? WidgetStatePropertyAll(
                          Colors.blueGrey.withOpacity(.025))
                      : WidgetStatePropertyAll(Colors.transparent),
                  onTap: () {
                    widget.navigate(element);
                  },
                  cells: [
                    DataCell(Column(
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomNetworkImage(
                              onTap: () {
                                widget.navigate(element);
                              },
                              link: element.categoryPhoto?.fullLink ?? '',
                              height: 50,
                              width: 100),
                        ),
                      ],
                    )),
                    DataCell(
                      Text(
                        isArabic
                            ? (element.name ?? '')
                            : (element.nameEn ?? ''),
                        maxLines: 2,
                        style: AppFonts.apptextStyle.copyWith(
                            fontSize: 14,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryFontColor),
                      ),
                    ),
                    DataCell(Text(
                      isArabic
                          ? (element.description ?? '')
                          : (element.descriptionEn ?? ''),
                      style: AppFonts.apptextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryFontColor),
                    )),
                    DataCell(
                      PopupMenuButton(
                          position: PopupMenuPosition.under,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          constraints: BoxConstraints(minWidth: 220.w),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    widget.updateCategory(element);
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
                                        LocaleKeys.updateCategory.tr(),
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
                                    CustomAlert.showConfirmDialogue(
                                        confirmDone: () async {
                                          await AppService.callService(
                                              actionType: ActionType.post,
                                              apiName:
                                                  'api/Category/Delete?Id=${element.id}',
                                              body: null);
                                          widget.categories.remove(element);
                                          setState(() {});
                                        },
                                        message: LocaleKeys.deleteCategory.tr(),
                                        context: context);
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
                          child: Icon(
                            Icons.more_horiz,
                          )),
                    ),
                  ]);
            }).toList()
          : [],
    );
  }
}
