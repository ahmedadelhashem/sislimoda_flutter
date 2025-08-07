import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/general/product_option_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class ProductOptionsOperations extends StatefulWidget {
  const ProductOptionsOperations(
      {super.key,
      required this.operationType,
      required this.reload,
      this.productOptions,
      required this.categoryId,
      required this.types});
  final OperationType operationType;
  final Function reload;
  final ProductOptionModel? productOptions;
  final String categoryId;
  final List<ValueItem> types;
  @override
  State<ProductOptionsOperations> createState() =>
      _ProductOptionsOperationsState();
}

class _ProductOptionsOperationsState extends State<ProductOptionsOperations> {
  TextEditingController arabicController = TextEditingController();
  TextEditingController englishController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedOptionType = '';
  String color = '';
  Loading loading = Loading();
  Color selectedColor = Colors.red;
  ValueItem selectedTypeValue =
      ValueItem(label: LocaleKeys.color.tr(), value: '1');

  GenericCubit<String> selectedTypeCubit = GenericCubit<String>();
  var types = [
    ValueItem(label: LocaleKeys.color.tr(), value: '1'),
    ValueItem(label: LocaleKeys.size.tr(), value: '2'),
    ValueItem(label: LocaleKeys.price.tr(), value: '3'),
    ValueItem(label: LocaleKeys.material.tr(), value: '4'),
    ValueItem(label: LocaleKeys.occasion.tr(), value: '5'),
    ValueItem(label: LocaleKeys.lastArrival.tr(), value: '6'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    color = selectedColor.hex.toString();
    selectedOptionType = widget.productOptions?.groupName ?? '';
    selectedTypeCubit.update(data: selectedOptionType);
    if (widget.operationType == OperationType.update) {
      arabicController.text = widget.productOptions?.name ?? '';
      englishController.text = widget.productOptions?.nameEn ?? '';
      selectedOptionType = widget.productOptions?.groupName ?? '';
      color = widget.productOptions?.other?.replaceAll('#', '') ?? '';
      selectedColor = Color(int.parse('0xff$color'));
      selectedTypeValue = widget.types.firstWhere((element) {
        return element.label.toLowerCase() == selectedOptionType.toLowerCase();
      });
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
                                labelText: '${LocaleKeys.nameEngish.tr()}(EN)',
                                controller: englishController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: AppButton(
                                  onPress: () async {
                                    selectedColor = await showColorPickerDialog(
                                      context,
                                      Colors.red,
                                    );
                                    color = selectedColor.hex.toString();
                                    setState(() {});
                                  },
                                  backgroundColor: selectedColor,
                                  title:
                                      isArabic ? 'إختار اللون' : "Select color",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomMultiSelect(
                                  hint:
                                      isArabic ? 'إختار النوع' : "Select Type",
                                  isSingle: true,
                                  selectedItems: [selectedTypeValue],
                                  items: widget.types,
                                  onChange: (values) {
                                    if (values.isNotEmpty) {
                                      selectedOptionType = values.first.value;
                                      selectedTypeCubit.update(
                                          data: values.first.label);
                                    } else {
                                      selectedOptionType = '';
                                      selectedTypeCubit.update(data: '');
                                    }
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GenericBuilder(
                                genericCubit: selectedTypeCubit,
                                builder: (selectedType) {
                                  return selectedType != 'Other'
                                      ? SizedBox()
                                      : Expanded(
                                          child: CustomTextField(
                                          onTap: () {},
                                          controller: otherController,
                                        ));
                                })
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
                                onPress: () {
                                  widget.operationType == OperationType.add
                                      ? add(
                                          categoryId: widget.categoryId,
                                        )
                                      : update();
                                },
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

  add({
    required String categoryId,
  }) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Option/Add',
          body: {
            // "optionType": selectedOptionType,
            "name": arabicController.text,
            "nameEn": englishController.text,
            "other": "#$color",
            "categoryId": widget.categoryId,
            "groupName": selectedTypeCubit.state.data == "Other"
                ? otherController.text
                : selectedTypeCubit.state.data,
            "groupKey": selectedTypeCubit.state.data == "Other"
                ? otherController.text
                : selectedTypeCubit.state.data,
          });
      result.fold((success) {
        Navigator.pop(context);
        widget.reload();
        showSuccessMessage(
            message: isArabic
                ? 'تمت إضافة خيارات المنتج بنجاح'
                : 'Product option added successfully');
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
          apiName: 'api/Option/Update',
          body: {
            // "optionType": selectedOptionType,
            'id': widget.productOptions?.id,
            "name": arabicController.text,
            "nameEn": englishController.text,
            "other": "#$color",
            "categoryId": widget.categoryId,
            "groupName": selectedTypeCubit.state.data == "Other"
                ? otherController.text
                : selectedTypeCubit.state.data,
            "groupKey": selectedTypeCubit.state.data == "Other"
                ? otherController.text
                : selectedTypeCubit.state.data,
          });
      result.fold((success) {
        Navigator.pop(context);
        widget.reload();
        showSuccessMessage(
            message: isArabic
                ? 'تمت تعديل خيارات المنتج بنجاح'
                : 'Product option updated successfully');
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
