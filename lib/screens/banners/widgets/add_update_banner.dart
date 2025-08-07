import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class AddUpdateBanner extends StatefulWidget {
  const AddUpdateBanner(
      {super.key,
      required this.products,
      required this.operationType,
      required this.afterAdd});
  final List<ProductModel> products;
  final OperationType operationType;
  final Function afterAdd;

  @override
  State<AddUpdateBanner> createState() => _AddUpdateBannerState();
}

class _AddUpdateBannerState extends State<AddUpdateBanner> {
  GenericCubit<String> imageCubit = GenericCubit<String>();
  XFile? selectedImage;
  Loading loading = Loading();
  String selectedProductId = '';

  @override
  void initState() {
    // TODO: implement initState
    imageCubit.update(data: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 400.w,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.operationType == OperationType.add
                            ? LocaleKeys.add.tr()
                            : LocaleKeys.updateCategory.tr(),
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
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      UploadImageController.getFormDataImage().then((value) {
                        if (value != null) {
                          selectedImage = value;
                          imageCubit.update(data: value.path);
                        }
                      });
                    },
                    child: GenericBuilder<String>(
                        genericCubit: imageCubit,
                        builder: (image) {
                          return DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(24.r),
                            strokeWidth: 1,
                            strokeCap: StrokeCap.butt,
                            color: image.isNotEmpty
                                ? AppColors.mainColor
                                : AppColors.error,
                            padding: EdgeInsets.zero,
                            dashPattern: [10],
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 40, top: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: image == ''
                                  ? Column(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: AppColors.addColor,
                                          radius: 15,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            '${LocaleKeys.pleaseSelectImages.tr()} (jpg-png-jpeg)',
                                            textAlign: TextAlign.center,
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ],
                                    )
                                  : Image.network(
                                      image,
                                      height: 100,
                                    ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomMultiSelect(
                      hint: isArabic ? 'إختر المنتج' : "Select product",
                      isSingle: true,
                      items: widget.products.map((element) {
                        return ValueItem(
                            label: isArabic
                                ? element.name ?? ''
                                : element.nameEn ?? '',
                            value: element.id);
                      }).toList(),
                      onChange: (List<ValueItem> values) {
                        if (values.isNotEmpty) {
                          selectedProductId = values.first.value;
                        } else {
                          selectedProductId = '';
                        }
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 205,
                        height: 50,
                        child: AppButton(
                          onPress: () async {
                            if (selectedImage == null) {
                              showErrorMessage(
                                  message: isArabic
                                      ? 'الرجاء إختيار صورة'
                                      : 'Please select image');
                              return;
                            }
                            if (selectedProductId == '') {
                              showErrorMessage(
                                  message: isArabic
                                      ? 'الرجاء إختيار منتج'
                                      : 'Please select product');
                              return;
                            }

                            final bytes = await selectedImage?.readAsBytes();
                            String img64 = base64Encode(bytes!.toList());
                            await context.uploadAttachment(
                                img64: img64,
                                imageName: selectedImage?.name ?? '',
                                afterUpload: (selectedId) async {
                                  Navigator.pop(context);

                                  loading.show;
                                  try {
                                    var result = await AppService.callService(
                                        actionType: ActionType.post,
                                        apiName: 'api/Banar/Add',
                                        body: {
                                          "type": "home",
                                          "productId": selectedProductId,
                                          "imageId": selectedId
                                        });

                                    result.fold((success) {
                                      showSuccessMessage(
                                          message: isArabic
                                              ? 'تم إضافة الملصق بنجاح'
                                              : 'Banner added successfully');
                                      widget.afterAdd();
                                      loading.hide;
                                    }, (error) {
                                      showErrorMessage(message: error.message);
                                    });
                                  } catch (error) {
                                    loading.hide;
                                  }
                                });
                          },
                          title: LocaleKeys.add.tr(),
                          borderRadius: 8,
                          fontWeight: FontWeight.w700,
                          titleFontColor: AppColors.black,
                          titleFontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
