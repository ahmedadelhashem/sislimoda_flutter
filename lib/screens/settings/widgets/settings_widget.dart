  import 'package:data_table_2/data_table_2.dart';
  import 'package:easy_localization/easy_localization.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:sislimoda_admin_dashboard/components/add_notification.dart';
  import 'package:sislimoda_admin_dashboard/models/settings/settings.dart';
  import 'package:sislimoda_admin_dashboard/screens/settings/widgets/EditSettingDialog.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
  import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
  import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

  class SettingsWidget extends StatefulWidget {
    const SettingsWidget(
        {super.key, required this.settings, required this.reload});
    final List<SettingsModel> settings;
    final Function reload;
    @override
    State<SettingsWidget> createState() => _SettingsWidgetState();
  }

  class _SettingsWidgetState extends State<SettingsWidget> {
    @override
    Widget build(BuildContext context) {
      return DataTable2(
        dividerThickness: 0,
        columns: [
          
          DataColumn2(
            label: Text(
              LocaleKeys.value.tr(),
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
                maxLines: 1,
                style: AppFonts.apptextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryFontColor),
              ),
              // size: ColumnSize.L,
              fixedWidth: 600.w),
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
        rows: widget.settings.isNotEmpty
            ? widget.settings.map((element) {
                return DataRow2(cells: [
                  DataCell(
                    Text(
                      (element.value ?? ''),
                      maxLines: 2,
                      style: AppFonts.apptextStyle.copyWith(
                          fontSize: 14,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryFontColor),
                    ),
                  ),
                  DataCell(Text(
                    isArabic ? element.keyAr ?? '' : element.key ?? '',
                    maxLines: 1,
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  )),
                  DataCell(
                    Row(
                      children: [
                  IconButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => EditSettingDialog(
          setting: element,
          onUpdated: (updatedSetting) {
            final index = widget.settings.indexWhere((e) => e.id == updatedSetting.id);
            if (index != -1) {
              setState(() {
                widget.settings[index] = updatedSetting;
              });
            }
          },
        ),
      );
    },
    icon: SvgPicture.asset(
      AppImages.edit,
      color: Colors.green,
    ),
  ),

                        // SizedBox(
                        //   width: 20,
                        // ),
                        // IconButton(
                        //   onPressed: () {
                        //     // deleteOptionSet(productOption: element);
                        //   },
                        //   icon: SvgPicture.asset(AppImages.delete),
                        // ),
                      ],
                    ),
                  ),
                ]);
              }).toList()
            : [],
      );
    }
  }
