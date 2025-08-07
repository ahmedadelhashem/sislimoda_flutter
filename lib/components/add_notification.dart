import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/notifications_cubit/notofocations_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/notofications/notifications_request_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class AddNotification extends StatefulWidget {
  const AddNotification(
      {super.key, required this.operationType, required this.notification});
  final OperationType operationType;
  final NotificationModel notification;
  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GenericCubit<String> imageCubit = GenericCubit<String>();
  XFile? selectedImage;
  Loading loading = Loading();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController arabicDescController = TextEditingController();
  TextEditingController englishDescController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    imageCubit.update(data: '');
    if (widget.operationType == OperationType.update) {
      arabicNameController.text = widget.notification.title ?? '';
      englishNameController.text = widget.notification.titleEn ?? '';
      englishDescController.text = widget.notification.descriptionEn ?? '';
      arabicDescController.text = widget.notification.description ?? '';
      imageCubit.update(data: (widget.notification.photo?.fullLink ?? ''));
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
          backgroundColor: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                width: 792,
                padding: const EdgeInsets.only(
                    top: 32, bottom: 32, left: 24, right: 24),
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
                                  ? (isArabic
                                      ? 'إضافة اشعار'
                                      : "Add Notification")
                                  : (isArabic
                                      ? 'تعديل اشعار'
                                      : "update Notification"),
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
                          isArabic ? "الصوره" : "Image",
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
                                .then((value) {
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
                                        left: 20.w,
                                        right: 20.w,
                                        bottom: 40,
                                        top: 40),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: image == ''
                                        ? Column(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor:
                                                    AppColors.addColor,
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
                                        : Image.network(
                                            image,
                                            height: 100,
                                          ),
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
                            Text('${LocaleKeys.requiredSize.tr()} ( 235-569)',
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
                          // hintText: 'مثال : العناية بالبشرة',
                          labelText: LocaleKeys.nameArabic.tr(),
                          controller: arabicNameController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          onTap: () {},
                          // hintText: 'Example : Skin care',
                          labelText: LocaleKeys.nameEngish.tr(),
                          controller: englishNameController,
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          onTap: () {},
                          // hintText: 'مثال : العناية بالبشرة',
                          labelText: LocaleKeys.descriptionArabic.tr(),
                          controller: arabicDescController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          onTap: () {},
                          // hintText: 'Example : Skin care',
                          labelText: LocaleKeys.descriptionEnglish.tr(),
                          controller: englishDescController,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 205,
                              height: 50,
                              child: AppButton(
                                onPress:
                                    widget.operationType == OperationType.add
                                        ? addNotification
                                        : updateNotification,
                                title: widget.operationType == OperationType.add
                                    ? (isArabic
                                        ? 'إضافة اشعار'
                                        : "Add Notification")
                                    : (isArabic
                                        ? 'تعديل اشعار'
                                        : "update Notification"),
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
              ),
            ],
          )),
    );
  }

  addNotification() async {
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
            Navigator.pop(context);

            loading.show;
            try {
              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Notifications/Add',
                  body: {
                    "title": arabicNameController.text,
                    "titleEn": englishNameController.text,
                    "description": arabicDescController.text,
                    "descriptionEn": englishDescController.text,
                    "photoId": selectedId
                  });

              result.fold((success) {
                showSuccessMessage(
                    message: isArabic
                        ? 'تم إضافة العلامه الإشعار بنجاح'
                        : 'notification added successfully');
                BlocProvider.of<NotofocationsCubit>(context).getNotifications();
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

  updateNotification() async {
    if (selectedImage == null) {
      loading.show;
      if (formKey.currentState!.validate()) {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Notifications/Update',
            body: {
              "id": widget.notification.id,
              "title": arabicNameController.text,
              "titleEn": englishNameController.text,
              "description": arabicDescController.text,
              "descriptionEn": englishDescController.text,
              "photoId": widget.notification.photoId
            });

        result.fold((success) {
          Navigator.pop(context);
          showSuccessMessage(
              message: isArabic
                  ? 'تم تغيير بيانات الإشعار بنجاح'
                  : 'Notification edited successfully');

          BlocProvider.of<NotofocationsCubit>(context).getNotifications();
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
            Navigator.pop(context);
            try {
              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Notifications/Update',
                  body: {
                    "id": widget.notification.id,
                    "title": arabicNameController.text,
                    "titleEn": englishNameController.text,
                    "description": arabicDescController.text,
                    "descriptionEn": englishDescController.text,
                    "photoId": selectedId
                  });

              result.fold((success) {
                showSuccessMessage(
                    message: isArabic
                        ? 'تم تغيير بيانات الإشعار بنجاح'
                        : 'Notification edited successfully');

                BlocProvider.of<NotofocationsCubit>(context).getNotifications();

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
