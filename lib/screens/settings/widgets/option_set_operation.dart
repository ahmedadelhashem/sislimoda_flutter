import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/general/option_set_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class OptionSetOperations extends StatefulWidget {
  const OptionSetOperations(
      {super.key,
      required this.operationType,
      required this.reload,
      this.optionSet});
  final OperationType operationType;
  final Function reload;
  final OptionSetModel? optionSet;

  @override
  State<OptionSetOperations> createState() => _OptionSetOperationsState();
}

class _OptionSetOperationsState extends State<OptionSetOperations> {
  Loading loading = Loading();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController arabicController = TextEditingController();
  TextEditingController englishController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.operationType == OperationType.update) {
      titleController.text = widget.optionSet?.name ?? '';
      arabicController.text = widget.optionSet?.displayNameAr ?? '';
      englishController.text = widget.optionSet?.displayNameEN ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                width: context.isMobile ? 0.9.sw : 792,
                padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 24, right: 24),
                margin: const EdgeInsets.only(top: 10),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              widget.operationType == OperationType.add
                                  ? LocaleKeys.add.tr()
                                  : LocaleKeys.edit.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: AppColors.dividerColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.title.tr(),
                                maxlines: 1,
                                controller: titleController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.nameArabic.tr(),
                                controller: arabicController,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                // hintText: 'مثال : العناية بالبشرة',
                                labelText: '${LocaleKeys.nameEngish.tr()}(EN)',
                                controller: englishController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 205,
                              height: 50,
                              child: AppButton(
                                onPress:
                                    widget.operationType == OperationType.add
                                        ? add
                                        : update,
                                title: widget.operationType == OperationType.add
                                    ? LocaleKeys.add.tr()
                                    : LocaleKeys.edit.tr(),
                                borderRadius: 8,
                                fontWeight: FontWeight.w700,
                                titleFontColor: Colors.white,
                                titleFontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  add() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/OptionSet/Add',
          body: {
            "name": titleController.text,
            "displayNameAr": arabicController.text,
            "displayNameEN": englishController.text
          });
      result.fold((success) {
        Navigator.pop(context);
        widget.reload();
        showSuccessMessage(
            message: isArabic
                ? 'تمت إضافة مجموعة الخيارات بنجاح'
                : 'Option set added successfully');
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  update() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/OptionSet/Update',
          body: {
            'id': widget.optionSet?.id ?? '',
            "name": titleController.text,
            "displayNameAr": arabicController.text,
            "displayNameEN": englishController.text
          });
      result.fold((success) {
        Navigator.pop(context);
        widget.reload();
        showSuccessMessage(
            message: isArabic
                ? 'تمت تعديل مجموعة الخيارات بنجاح'
                : 'Option set updated successfully');
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
