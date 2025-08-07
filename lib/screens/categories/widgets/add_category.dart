import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/brands/brand_model.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class AddCategory extends StatefulWidget {
  const AddCategory(
      {super.key,
      required this.brands,
      required this.refresh,
      required this.category,
      required this.operationType,
      this.mainCategoryId = ''});
  final List<BrandModel> brands;
  final CategoryModel category;
  final OperationType operationType;
  final Function refresh;
  final String mainCategoryId;
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GenericCubit<String> imageCubit = GenericCubit<String>();
  XFile? selectedImage;
  Loading loading = Loading();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController englishDescriptionController = TextEditingController();
  List<ValueItem> selectedBrands = [];

  @override
  void initState() {
    // TODO: implement initState
    imageCubit.update(data: '');
    if (widget.operationType == OperationType.update) {
      arabicNameController.text = widget.category.name ?? '';
      englishNameController.text = widget.category.nameEn ?? '';
      arabicDescriptionController.text = widget.category.description ?? '';
      englishDescriptionController.text = widget.category.descriptionEn ?? '';
      imageCubit.update(data: (widget.category.categoryPhoto?.fullLink ?? ''));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        child: Container(
          width: 792,
          padding:
              const EdgeInsets.only(top: 32, bottom: 32, left: 24, right: 24),
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
                            ? LocaleKeys.add_category.tr()
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
                  Text(
                    LocaleKeys.categoryImage.tr(),
                    style: AppFonts.apptextStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: AppColors.secondaryFontColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      UploadImageController.getFormDataImage()
                          .then((value) async {
                        if (value != null) {
                          int fileSizeInBytes = await value.length();
                          double fileSizeInKB = fileSizeInBytes / 1024;
                          double fileSizeInMB = fileSizeInKB / 1024;
                          if (fileSizeInMB > 3) {
                            showErrorMessage(
                                message: isArabic
                                    ? 'حجم الصورة كبير \n الحد الأقصى للحجم المناسب 3 ميجا بايت'
                                    : "Image Size to big \n Max applicable size 3 Mb");
                          } else {
                            selectedImage = value;
                            imageCubit.update(data: value.path);
                          }
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
                                            '${LocaleKeys.addCategoryWithFormat.tr()} (jpg-png-jpeg)',
                                            textAlign: TextAlign.center,
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ],
                                    )
                                  : CustomNetworkImage(
                                      link: image, height: 100, width: 100),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Max size is 3 MB',
                          textAlign: TextAlign.center,
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.secondaryFontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    onTap: () {},
                    hintText: 'مثال : العناية بالبشرة',
                    labelText: LocaleKeys.nameArabic.tr(),
                    controller: arabicNameController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    onTap: () {},
                    hintText: 'Example : Skin care',
                    labelText: LocaleKeys.nameEngish.tr(),
                    controller: englishNameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    onTap: () {},
                    labelText: LocaleKeys.descriptionArabic.tr(),
                    maxlines: 1,
                    controller: arabicDescriptionController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    onTap: () {},
                    labelText: LocaleKeys.descriptionEnglish.tr(),
                    maxlines: 1,
                    controller: englishDescriptionController,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 205,
                        height: 50,
                        child: AppButton(
                          onPress: widget.operationType == OperationType.add
                              ? addCategory
                              : updateCategory,
                          title: widget.operationType == OperationType.add
                              ? LocaleKeys.add_category.tr()
                              : LocaleKeys.updateCategory.tr(),
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
            ),
          ),
        ));
  }

  addCategory() async {
    if (selectedImage == null) {
      showErrorMessage(
          message: isArabic ? 'الرجاء إختيار صورة' : 'Please select image');
      return;
    }
    if (formKey.currentState!.validate() && selectedImage != null) {
      final bytes = await selectedImage?.readAsBytes();
      String img64 = base64Encode(bytes!.toList());

      await context.uploadAttachment(
          img64: img64,
          imageName: selectedImage?.name ?? '',
          afterUpload: (selectedId) async {
            await Future.delayed(Duration(milliseconds: 200));
            loading.show;
            try {
              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Category/Add',
                  body: {
                    "mainCategoryId": widget.mainCategoryId,
                    "name": arabicNameController.text,
                    "nameEn": englishNameController.text,
                    "description": arabicDescriptionController.text,
                    "descriptionEn": englishNameController.text,
                    "categoryPhotoId": selectedId,
                    "order": 0
                  });

              result.fold((success) {
                Navigator.pop(context);
                showSuccessMessage(
                    message: isArabic
                        ? 'تم إضافة التصنيف بنجاح'
                        : 'Category added successfully');
                widget.refresh();
                BlocProvider.of<CategoriesCubit>(context).getCategories();
                loading.hide;
              }, (error) {
                showErrorMessage(message: error.message);
              });
            } catch (error) {
              loading.hide;
            }
          });
    }
  }

  updateCategory() async {
    if (selectedImage == null) {
      loading.show;
      if (formKey.currentState!.validate()) {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Category/Update',
            body: {
              "id": widget.category.id,
              "mainCategoryId": widget.category.mainCategoryId,
              "name": arabicNameController.text,
              "nameEn": englishNameController.text,
              "description": arabicDescriptionController.text,
              "descriptionEn": englishDescriptionController.text,
              "categoryPhotoId": widget.category.categoryPhotoId,
              "order": 0
            });

        result.fold((success) {
          Navigator.pop(context);
          showSuccessMessage(
              message: isArabic
                  ? 'تم تغيير بيانات القسم بنجاح'
                  : 'Category edited successfully');
          BlocProvider.of<CategoriesCubit>(context).getCategories();
          widget.refresh();
          loading.hide;
        }, (failure) {
          showErrorMessage(message: failure.message);
        });
      }
      loading.hide;
    } else if (formKey.currentState!.validate() && selectedImage != null) {
      loading.show;
      final bytes = await selectedImage?.readAsBytes();
      String img64 = base64Encode(bytes!.toList());

      await context.uploadAttachment(
          img64: img64,
          imageName: selectedImage?.name ?? '',
          afterUpload: (selectedId) async {
            await Future.delayed(Duration(milliseconds: 200));
            try {
              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Category/Update',
                  body: {
                    "id": widget.category.id,
                    "mainCategoryId": widget.category.mainCategoryId,
                    "name": arabicNameController.text,
                    "nameEn": englishNameController.text,
                    "description": arabicDescriptionController.text,
                    "descriptionEn": englishDescriptionController.text,
                    "categoryPhotoId": selectedId,
                    "order": 0
                  });

              result.fold((success) {
                Navigator.pop(context);
                showSuccessMessage(
                    message: isArabic
                        ? 'تم تغيير بيانات القسم بنجاح'
                        : 'Category edited successfully');
                BlocProvider.of<CategoriesCubit>(context).getCategories();
                widget.refresh();

                loading.hide;
              }, (failure) {
                showErrorMessage(message: failure.message);
              });
            } catch (error) {}
          });

      loading.hide;
    }
  }
}

enum OperationType { add, update }
