import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/product_option_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/option_set_operation.dart';
import 'package:sislimoda_admin_dashboard/screens/settings/widgets/product_options_operations.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class ProductOptionsWidget extends StatefulWidget {
  const ProductOptionsWidget(
      {super.key,
      required this.options,
      required this.reload,
      required this.types});
  final List<ProductOptionModel> options;
  final Function reload;
  final List<ValueItem> types;
  @override
  State<ProductOptionsWidget> createState() => _ProductOptionsWidgetState();
}

class _ProductOptionsWidgetState extends State<ProductOptionsWidget> {
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
            LocaleKeys.type.tr(),
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
      rows: widget.options.isNotEmpty
          ? widget.options.map((element) {
              return DataRow2(cells: [
                DataCell(
                  Text(
                    isArabic ? (element.nameEn ?? '') : (element.nameEn ?? ''),
                    maxLines: 2,
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                ),
                DataCell(Text(
                  element.groupName ?? '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(CircleAvatar(
                  radius: 6,
                  backgroundColor: Color(int.tryParse(
                          '0xff${element.other?.replaceAll('#', '')}') ??
                      0xff000000),
                )),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateItem(optionModel: element);
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
                          deleteOptionSet(productOption: element);
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

  deleteOptionSet({required ProductOptionModel productOption}) {
    CustomAlert.showConfirmDialogue(
        confirmDone: () async {
          var result = await AppService.callService(
              actionType: ActionType.post,
              apiName: 'api/Option/Delete?id=${productOption.id}',
              body: {});
          result.fold((success) {
            widget.options.remove(productOption);
            setState(() {});
            showSuccessMessage(
                message: isArabic
                    ? 'تم حذف خيار المنتج بنجاح'
                    : 'Product option deleted successfully');
          }, (error) {
            showErrorMessage(message: error.message);
          });
        },
        message: isArabic
            ? 'هل أنت متأكد من حذف خيار المنتج هذه؟ \n إذا قمت بالحذف، فلن تتمكن من استعادة خيار المنتج بعد الآن'
            : 'Are you sure to delete this Product option ? \n if you delete can\'t recover Product option any more',
        context: currentContext);
  }

  updateItem({required ProductOptionModel optionModel}) {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return ProductOptionsOperations(
            operationType: OperationType.update,
            types: widget.types,
            categoryId: optionModel.categoryId ?? '',
            reload: widget.reload,
            productOptions: optionModel,
          );
        });
  }

  getType({required String type}) {
    print('Type $type');
    if (type == '1') {
      return LocaleKeys.color.tr();
    } else if (type == '2') {
      return LocaleKeys.size.tr();
    } else if (type == '3') {
      return LocaleKeys.price.tr();
    } else if (type == '4') {
      return LocaleKeys.material.tr();
    } else if (type == '5') {
      return LocaleKeys.occasion.tr();
    } else if (type == '6') {
      return LocaleKeys.lastArrival.tr();
    } else {
      return '';
    }
  }
}
