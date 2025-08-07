import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/option_set_operation.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class OptionsSets extends StatefulWidget {
  const OptionsSets(
      {super.key, required this.optionSets, required this.reload});
  final List<OptionSetModel> optionSets;
  final Function reload;
  @override
  State<OptionsSets> createState() => _OptionsSetsState();
}

class _OptionsSetsState extends State<OptionsSets> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      dividerThickness: 0,
      columns: [
        DataColumn2(
          label: Text(
            LocaleKeys.title.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.nameArabic.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.nameEngish.tr(),
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
      rows: widget.optionSets.isNotEmpty
          ? widget.optionSets.map((element) {
              return DataRow2(cells: [
                DataCell(
                  Text(
                    (element.name ?? ''),
                    maxLines: 2,
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                ),
                DataCell(Text(
                  (element.displayNameAr ?? ''),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(Text(
                  (element.displayNameEN ?? ''),
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
                          context.router.push(OptionSetItemDetailsRoute(
                              optionSetId: element.id ?? ''));
                        },
                        icon: SvgPicture.asset(
                          AppImages.show,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () => updateItem(optionSetItem: element),
                        icon: SvgPicture.asset(
                          AppImages.edit,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () =>
                            deleteOptionSet(optionSetItem: element),
                        icon: SvgPicture.asset(AppImages.delete),
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList()
          : [],
    );
  }

  deleteOptionSet({required OptionSetModel optionSetItem}) {
    CustomAlert.showConfirmDialogue(
        confirmDone: () async {
          var result = await AppService.callService(
              actionType: ActionType.post,
              apiName: 'api/OptionSet/Delete?id=${optionSetItem.id}',
              body: {});
          result.fold((success) {
            widget.optionSets.remove(optionSetItem);
            setState(() {});
            showSuccessMessage(
                message: isArabic
                    ? 'تم حذف مجموعة الخيارات بنجاح'
                    : 'Option set deleted successfully');
          }, (error) {
            showErrorMessage(message: error.message);
          });
        },
        message: isArabic
            ? 'هل أنت متأكد من حذف مجموعة الخيارات هذه؟ \n إذا قمت بالحذف، فلن تتمكن من استعادة مجموعة الخيارات بعد الآن'
            : 'Are you sure to delete this option set ? \n if you delete can\'t recover option set any more',
        context: currentContext);
  }

  updateItem({required OptionSetModel optionSetItem}) {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return OptionSetOperations(
            operationType: OperationType.update,
            reload: widget.reload,
            optionSet: optionSetItem,
          );
        });
  }
}
