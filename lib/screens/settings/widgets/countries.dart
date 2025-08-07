import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/add_notification.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/general/country_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class Countries extends StatefulWidget {
  const Countries({super.key, required this.countries});
  final List<CountryModel> countries;

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      dividerThickness: 0,
      columns: [
        DataColumn2(
          label: Text(
            isArabic ? "الصورة" : "image",
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
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
            LocaleKeys.code.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 15,
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
      rows: widget.countries.isNotEmpty
          ? widget.countries.map((element) {
              return DataRow2(cells: [
                DataCell(CustomNetworkImage(
                  height: 100,
                  width: 100,
                  link: element.photo?.fullLink ?? '',
                )),
                DataCell(
                  Text(
                    isArabic ? (element.name ?? '') : (element.nameEn ?? ''),
                    maxLines: 2,
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                ),
                DataCell(Text(
                  element.code ?? '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(Text(
                  element.isActive.toString(),
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
                          CustomAlert.showConfirmDialogue(
                              confirmDone: () async {
                                var result = await AppService.callService(
                                    actionType: ActionType.post,
                                    apiName:
                                        'api/Country/Delete?Id=${element.id}',
                                    body: {});
                                result.fold((success) {
                                  widget.countries.remove(element);
                                  setState(() {});
                                  showSuccessMessage(
                                      message: isArabic
                                          ? 'تم حذف الدولة بنجاح'
                                          : 'Country deleted successfully');
                                }, (failed) {
                                  showErrorMessage(message: failed.message);
                                });
                              },
                              message: isArabic
                                  ? 'هل أنت متأكد من حذف هذا البلد؟ \n إذا قمت بحذفه فلن تتمكن من استعادته بعد الآن'
                                  : 'Are you sure to delete this country ? \n if you deleted you can\'t recover it any more ',
                              context: context);
                        },
                        icon: SvgPicture.asset(AppImages.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          UploadImageController.getFormDataImage()
                              .then((value) async {
                            if (value != null) {
                              final bytes = await value.readAsBytes();
                              String img64 = base64Encode(bytes.toList());
                              await context.uploadAttachment(
                                  afterUpload: (id) async {
                                    var result = await AppService.callService(
                                        actionType: ActionType.post,
                                        apiName: 'api/Country/Update',
                                        body: {
                                          "id": element.id,
                                          "countryId": element.countryId,
                                          "name": element.name,
                                          "nameEn": element.nameEn,
                                          "code": element.code,
                                          "isoCode": element.isoCode,
                                          "isActive": true,
                                          "photoId": id
                                        });
                                    result.fold((success) {
                                      showSuccessMessage(
                                          message: isArabic ? "منتهي" : "Done");
                                    }, (error) {
                                      showErrorMessage(
                                          message: isArabic
                                              ? "حدث خطآ"
                                              : "An error occurred");
                                    });
                                  },
                                  imageName: value.name ?? '',
                                  img64: img64);
                            }
                          });
                        },
                        icon: SvgPicture.asset(AppImages.updateImage),
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList()
          : [],
    );
  }
}
