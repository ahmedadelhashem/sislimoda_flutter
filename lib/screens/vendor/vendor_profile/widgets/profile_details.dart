import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislimoda_admin_dashboard/components/add_notification.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/user/user_moel.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key, required this.user});
  final UserModel user;
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GenericCubit<String> imageCubit = GenericCubit<String>();
  Loading loading = Loading();
  XFile? image;

  @override
  void initState() {
    // TODO: implement initState
    firstNameController.text = widget.user.firstName ?? '';
    middleNameController.text = widget.user.middleName ?? '';
    lastNameController.text = widget.user.lastName ?? '';
    emailController.text = widget.user.email ?? '';
    phoneController.text = widget.user.phoneNumer ?? '';
    addressController.text = widget.user.address ?? '';
    imageCubit.update(data: widget.user.photo?.fullLink ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
  final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return Screen(
      loadingCubit: loading,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     GenericBuilder(
              //         genericCubit: imageCubit,
              //         builder: (image) {
              //           return SizedBox(
              //             width: 150,
              //             height: 150,
              //             child: CustomNetworkImage(
              //                 link: image, height: 150, width: 150),
              //           );
              //         }),
              //     SizedBox(
              //       width: 30,
              //     ),
              //     SizedBox(
              //       width: 250,
              //       height: 48,
              //       child: AppButton(
              //         title: isArabic
              //             ? 'تغير الصورة الشخصية'
              //             : "Change Profile Photo",
              //         titleFontSize: 14.sp,
              //         onPress: () {
              //           UploadImageController.getFormDataImage().then((file) {
              //             if (file != null) {
              //               imageCubit.update(data: file.path ?? '');
              //               image = file;
              //             }
              //           });
              //         },
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      onTap: () {},
                      labelText: LocaleKeys.firstName.tr(),
                      controller: firstNameController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomTextField(
                      onTap: () {},
                      labelText: LocaleKeys.middleName.tr(),
                      controller: middleNameController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomTextField(
                      onTap: () {},
                      labelText: LocaleKeys.lastName.tr(),
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      onTap: () {},
                      labelText: LocaleKeys.email.tr(),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomTextField(
                      onTap: () {},
                      labelText: LocaleKeys.mobileNumber.tr(),
                      controller: phoneController,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                onTap: () {},
                maxlines: 3,
                labelText:  isArabic
  ? 'العنوان'
  : isTurkish
    ? 'Adres'
    : 'Address',
                controller: addressController,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    height: 48,
                    child: AppButton(
                      title: isArabic
  ? 'تحديث'
  : isTurkish
    ? 'Güncelle'
    : 'Update',
                      titleFontSize: 14.sp,
                      onPress: _updateProfile,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateProfile() async {
    if (image != null) {
      final bytes = await image!.readAsBytes();
      String img64 = base64Encode(bytes.toList());

      await context.uploadAttachment(
          img64: img64,
          imageName: image!.name,
          afterUpload: (selectedId) async {
            Future.delayed(
              Duration(seconds: 1),
              () {
                _sendUpdateData(imageId: selectedId ?? '');
              },
            );
          });
    } else {
      _sendUpdateData(imageId: widget.user.photoId ?? '');
    }
  }

  _sendUpdateData({required String imageId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Auth/updateUser',
          body: {
            "id": widget.user.id,
            "photoId": imageId,
            "firstName": firstNameController.text,
            "middleName": middleNameController.text,
            "lastName": lastNameController.text,
            "userName": widget.user.userName,
            "email": emailController.text,
            "isActive": widget.user.isActive,
            "address": addressController.text,
            "otherPhoneNumber": phoneController.text,
            "isVendor": widget.user.isVendor,
            "isAdmin": widget.user.isAdmin,
            "phoneNumer": phoneController.text,
            "gender": widget.user.gender,
            "birthDate": widget.user.birthDate,
            "enableNotification": widget.user.enableNotification,
            "pantsMeasurement": widget.user.pantsMeasurement,
            "coachMeasurement": widget.user.coachMeasurement,
            "tShirtmeasurement": widget.user.tShirtmeasurement,
            "isInfluencer": widget.user.isInfluencer,
            "socialLogin": widget.user.socialLogin,
            "isSocialLogin": widget.user.isSocialLogin
          });

      result.fold((success) {
        showSuccessMessage(
            message: isArabic
                ? 'تم تحديث الملف الشخصي بنجاح'
                : "Profile updated successfully");
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {
      showErrorMessage(
          message: isArabic
              ? 'حدث خطأ أثناء التحديث'
              : "Something went wrong while update");
    }
    loading.hide;
  }
}
