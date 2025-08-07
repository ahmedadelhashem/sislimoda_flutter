import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/models/user/create_user_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/update_user_model.dart';
import 'package:sislimoda_admin_dashboard/models/users/DashboardUserModel.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class AddDashboardUser extends StatefulWidget {
  const AddDashboardUser(
      {super.key,
      required this.operationType,
      required this.refresh,
      required this.userModel});
  final OperationType operationType;
  final Function refresh;
  final DashboardUserModel userModel;
  @override
  State<AddDashboardUser> createState() => _AddDashboardUserState();
}

class _AddDashboardUserState extends State<AddDashboardUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GenericCubit<String> imageCubit = GenericCubit<String>();
  XFile? selectedImage;
  Loading loading = Loading();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    imageCubit.update(data: '');

    if (widget.operationType == OperationType.update) {
      print(
          'widget.userModel.photo?.fullLink${widget.userModel.photo?.fullLink}');
      imageCubit.update(data: widget.userModel.photo?.fullLink ?? '');
      firstNameController.text = widget.userModel.name?.split(' ')[0] ?? '';
      middleNameController.text = widget.userModel.name?.split(' ')[1] ?? '';
      try {
        lastNameController.text = widget.userModel.name?.split(' ')[2] ?? '';
      } catch (e) {}
      emailController.text = widget.userModel.appUser?.email ?? '';
      phoneController.text = widget.userModel.phoneNumber ?? '';
      addressController.text = widget.userModel.appUser?.address ?? '';
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
                                  ? LocaleKeys.addUser.tr()
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
                        // Text(
                        //   LocaleKeys.categoryImage.tr(),
                        //   style: AppFonts.apptextStyle.copyWith(
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 15,
                        //       color: AppColors.secondaryFontColor),
                        // ),
                        // const SizedBox(
                        //   height: 12,
                        // ),
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
                                        : CustomNetworkImage(
                                            link: image,
                                            height: 100,
                                            width: 500,
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
                          height: 32,
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
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.middleName.tr(),
                                controller: middleNameController,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.lastName.tr(),
                                controller: lastNameController,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.email.tr(),
                                controller: emailController,
                                textFieldValidType:
                                    TextFieldvalidatorType.email,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.mobileNumber.tr(),
                                controller: phoneController,
                                textFieldValidType:
                                    TextFieldvalidatorType.required,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (widget.operationType == OperationType.add)
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  onTap: () {},
                                  labelText: LocaleKeys.password.tr(),
                                  controller: passwordController,
                                  textFieldValidType:
                                      TextFieldvalidatorType.password,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  onTap: () {},
                                  labelText: isArabic
                                      ? 'تأكيد كلمة المرور'
                                      : 'Confirm password',
                                  controller: confirmPasswordController,
                                  confirmPasswordController: passwordController,
                                  textFieldValidType:
                                      TextFieldvalidatorType.confirmPassword,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          onTap: () {},
                          labelText: isArabic ? 'العنوان' : 'Address',
                          controller: addressController,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        // CustomTextField(
                        //   onTap: () {},
                        //   hintText: 'Example : Skin care',
                        //   labelText: LocaleKeys.nameEngish.tr(),
                        //   controller: englishNameController,
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // CustomTextField(
                        //   onTap: () {},
                        //   labelText: LocaleKeys.descriptionArabic.tr(),
                        //   maxlines: 1,
                        //   controller: arabicDescriptionController,
                        // ),
                        // SizedBox(
                        //   width: 22,
                        // ),
                        // CustomTextField(
                        //   onTap: () {},
                        //   labelText: LocaleKeys.descriptionEnglish.tr(),
                        //   maxlines: 1,
                        //   controller: englishDescriptionController,
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // if (widget.operationType == OperationType.add)
                        //   CustomMultiSelect(
                        //     hint: LocaleKeys.selectBrands.tr(),
                        //     onChange: (List<ValueItem> items) {
                        //       selectedBrands = items;
                        //     },
                        //     items: widget.brands
                        //         .map((BrandModel brand) => ValueItem(
                        //         label: isArabic
                        //             ? (brand.name?.AR ?? '')
                        //             : (brand.name?.EN ?? ''),
                        //         value: brand.Id))
                        //         .toList(),
                        //   ),
                        // SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 205,
                              height: 50,
                              child: AppButton(
                                onPress:
                                    widget.operationType == OperationType.add
                                        ? addUser
                                        : updateUser,
                                title: widget.operationType == OperationType.add
                                    ? LocaleKeys.addUser.tr()
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

  addUser() async {
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
              CreateUserModel addUser = CreateUserModel(
                  appUser: CreateUserModelAppUser(
                      photoId: selectedId,
                      phoneNumber: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                      firstName: firstNameController.text,
                      middleName: middleNameController.text,
                      lastName: lastNameController.text,
                      password: passwordController.text,
                      userName: emailController.text),
                  user: CreateUserModelUser(
                      email: emailController.text,
                      isSupperAdmin: false,
                      name:
                          '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
                      phoneNumber: phoneController.text,
                      photoId: selectedId,
                      userTypes: '1'));
              Navigator.pop(context);

              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: '/api/Auth/RegisterUser',
                  body: addUser.toJson());

              result.fold((success) {
                widget.refresh();
                Navigator.pop(context);
                showSuccessMessage(
                    message: isArabic
                        ? 'تم إضافة المستخدم بنجاح'
                        : 'User added successfully');
              }, (error) {
                widget.refresh();
                Navigator.pop(context);
                showSuccessMessage(
                    message: isArabic
                        ? 'تم إضافة المستخدم بنجاح'
                        : 'User added successfully');
              });
            } catch (error) {}
            loading.hide;
          });
    }
  }

  updateUser() async {
    if (selectedImage == null) {
      loading.show;
      if (formKey.currentState!.validate()) {
        UpdateUserModel updateUserModel = UpdateUserModel(
            email: emailController.text,
            phoneNumber: phoneController.text,
            photoId: widget.userModel.photoId,
            userTypes: widget.userModel.userTypes,
            name:
                '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
            isSupperAdmin: false,
            id: widget.userModel.id,
            vendorId: widget.userModel.vendorId,
            appUserId: widget.userModel.appUserId);

        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/User/Update',
            body: updateUserModel.toJson());

        result.fold((success) {
          widget.refresh();
          Navigator.pop(context);
          showSuccessMessage(
              message: isArabic
                  ? 'تم تغيير بيانات المستخدم بنجاح'
                  : 'User edited successfully');
        }, (failure) {
          showErrorMessage(message: failure.message);
        });
      }
      loading.hide;
    }
    if (formKey.currentState!.validate() && selectedImage != null) {
      loading.show;
      final bytes = await selectedImage?.readAsBytes();
      String img64 = base64Encode(bytes!.toList());

      await context.uploadAttachment(
          img64: img64,
          imageName: selectedImage?.name ?? '',
          afterUpload: (selectedId) async {
            await Future.delayed(Duration(milliseconds: 200));
            try {
              UpdateUserModel updateUserModel = UpdateUserModel(
                  email: emailController.text,
                  phoneNumber: phoneController.text,
                  photoId: selectedId,
                  userTypes: widget.userModel.userTypes,
                  name:
                      '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
                  isSupperAdmin: false,
                  id: widget.userModel.id,
                  vendorId: widget.userModel.vendorId,
                  appUserId: widget.userModel.appUserId);

              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/User/Update',
                  body: updateUserModel.toJson());

              result.fold((success) {
                widget.refresh();
                Navigator.pop(context);
                showSuccessMessage(
                    message: isArabic
                        ? 'تم تغيير بيانات المستخدم بنجاح'
                        : 'User edited successfully');
              }, (failure) {
                showErrorMessage(message: failure.message);
              });
            } catch (error) {}
          });

      loading.hide;
    }
  }
}
