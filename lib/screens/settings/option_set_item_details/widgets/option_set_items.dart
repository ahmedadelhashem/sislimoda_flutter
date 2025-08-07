import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/option_set_item_details/widgets/option_set_item_operation.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class OptionSetItems extends StatefulWidget {
  const OptionSetItems(
      {super.key,
      required this.items,
      required this.optionSetId,
      required this.reload});
  final List<OptionSetModelOptionSetItems?> items;
  final String optionSetId;
  final Function reload;
  @override
  State<OptionSetItems> createState() => _OptionSetItemsState();
}

class _OptionSetItemsState extends State<OptionSetItems> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      dividerThickness: 0,
      columns: [
        DataColumn2(
          label: Text(
            LocaleKeys.name.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.value.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.color.tr(),
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
      rows: widget.items.isNotEmpty
          ? widget.items.map((element) {
              return DataRow2(cells: [
                DataCell(
                  Text(
                    isArabic
                        ? (element?.nameAr ?? '')
                        : (element?.nameEn ?? ''),
                    maxLines: 2,
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                ),
                DataCell(Text(
                  // 'getType(type: element.optionType ?? '')',
                  element?.value ?? '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(CircleAvatar(
                  radius: 6,
                  backgroundColor: Color(int.tryParse(
                          '0xff${element?.color?.replaceAll('#', '')}') ??
                      0xff000000),
                )),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateItem(item: element);
                        },
                        icon: SvgPicture.asset(
                          AppImages.edit,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          deleteOptionSet(item: element);
                        },
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

  deleteOptionSet({required OptionSetModelOptionSetItems? item}) {
    CustomAlert.showConfirmDialogue(
        confirmDone: () async {
          var result = await AppService.callService(
              actionType: ActionType.post,
              apiName: 'api/OptionSetItem/Delete?id=${item?.id}',
              body: {});
          result.fold((success) {
            widget.items.remove(item);
            setState(() {});
            showSuccessMessage(
                message: isArabic
                    ? 'تم حذف العنصر بنجاح'
                    : 'item deleted successfully');
          }, (error) {
            showErrorMessage(message: error.message);
          });
        },
        message: isArabic
            ? 'هل أنت متأكد من حذف خيار المنتج هذه؟ \n إذا قمت بالحذف، فلن تتمكن من استعادة خيار المنتج بعد الآن'
            : 'Are you sure to delete this item ? \n if you delete can\'t recover item any more',
        context: currentContext);
  }

  updateItem({required OptionSetModelOptionSetItems? item}) {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return OptionSetItemOperation(
            operationType: OperationType.update,
            reload: widget.reload,
            optionSetId: widget.optionSetId,
            items: item,
          );
        });
  }
}
