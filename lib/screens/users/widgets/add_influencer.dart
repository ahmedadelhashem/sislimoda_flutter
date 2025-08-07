
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/models/user/create_influencer_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/update_influencer_model.dart';
import 'package:sislimoda_admin_dashboard/models/users/InfluencerModel.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class AddInfluencer extends StatefulWidget {
  const AddInfluencer(
      {super.key,
      required this.operationType,
      required this.refresh,
      required this.userModel});
  final OperationType operationType;
  final Function refresh;
  final InfluencerModel userModel;
  @override
  State<AddInfluencer> createState() => _AddInfluencerState();
}

class _AddInfluencerState extends State<AddInfluencer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // GenericCubit<String> imageCubit = GenericCubit<String>();
  // XFile? selectedImage;
  Loading loading = Loading();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberOfController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime currentDate = DateTime.now();
  String selectedGender = '';
  List<ValueItem>? selectedGenders;

  @override
  void initState() {
    // TODO: implement initState
    // imageCubit.update(data: '');

    if (widget.operationType == OperationType.update) {
      print('widget.userModel.name ${widget.userModel.name}');
      // imageCubit.update(data: widget.userModel.photo?.fullLink ?? '');
      firstNameController.text = widget.userModel.name?.split(' ')[0] ?? '';
      middleNameController.text = widget.userModel.name?.split(' ')[1] ?? '';
      lastNameController.text = widget.userModel.name?.split(' ')[2] ?? '';
      emailController.text = widget.userModel.user?.email ?? '';
      phoneController.text = widget.userModel.user?.phoneNumer ?? '';
numberOfController.text = widget.userModel.numberOfProduct?.toString() ?? '';
      addressController.text = widget.userModel.user?.address ?? '';
      dateController.text =
          widget.userModel.user?.birthDate?.split(' ')[0] ?? '';
      if (widget.userModel.user?.gender == '1') {
        selectedGenders = [
          ValueItem(value: '1', label: isArabic ? 'ذكر' : 'Male')
        ];
      } else {
        selectedGenders = [
          ValueItem(value: '2', label: isArabic ? 'آنثي' : 'Female')
        ];
      }
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
                          height: 16,
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
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: isArabic
                                    ? "عدد المنتجات للحملة"
                                    : "Number of product for campaign",
                                controller: numberOfController,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomMultiSelect(
                                  items: [
                                    ValueItem(
                                        value: '1',
                                        label: isArabic ? 'ذكر' : 'Male'),
                                    ValueItem(
                                        value: '2',
                                        label: isArabic ? 'آنثي' : 'Female')
                                  ],
                                  selectedItems: selectedGenders ?? [],
                                  onChange: (List<ValueItem> value) {
                                    if (value.isNotEmpty) {
                                      selectedGender = value.first.value;
                                    } else {
                                      selectedGender = '';
                                    }
                                  },
                                  isSingle: true,
                                  hint: isArabic ? 'الجنس' : 'Select gender'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: context.isMobile ? 3 : 4,
                                child: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                        builder: (context, widget) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: .4.sw,
                                                child: Material(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Column(
                                                    children: [
                                                      CalendarDatePicker(
                                                          currentDate:
                                                              currentDate,
                                                          initialDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                                  .now()
                                                              .subtract(Duration(
                                                                  days: 20000)),
                                                          onDateChanged:
                                                              (date) {
                                                            currentDate = date;
                                                            dateController
                                                                .text = DateFormat(
                                                                    'MM/dd/yyyy')
                                                                .format(date);
                                                          }),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        height: 45,
                                                        child: AppButton(
                                                          borderRadius: 0,
                                                          titleFontSize: 16,
                                                          onPress: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          title: LocaleKeys
                                                              .selectDate
                                                              .tr(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        context: context,
                                        lastDate: DateTime.now(),
                                        firstDate: DateTime.now()
                                            .subtract(Duration(days: 20000)));
                                  },
                                  child: CustomTextField(
                                    controller: dateController,
                                    onTap: () {},
                                    enabled: false,
                                    hintText: LocaleKeys.selectDate.tr(),
                                    labelText: LocaleKeys.orderDate.tr(),
                                    iconData: AppImages.calendar,
                                  ),
                                )),
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
  if (formKey.currentState!.validate()) {
    loading.show;
    try {
      CreateInfluencerModel addUser = CreateInfluencerModel(
        appUser: CreateInfluencerModelAppUser(
          photoId: null,
          phoneNumer: phoneController.text,
          email: emailController.text,
          address: addressController.text,
          firstName: firstNameController.text,
          middleName: middleNameController.text,
          lastName: lastNameController.text,
          password: passwordController.text,
          isAdmin: false,
          enableNotification: false,
          socialLogin: '7',
          isActive: true,
          isVendor: false,
          coachMeasurement: '',
          isInfluencer: true,
          isSocialLogin: false,
          birthDate: dateController.text,
          gender: selectedGender,
          otherPhoneNumber: phoneController.text,
          pantsMeasurement: '',
          tShirtmeasurement: '',
          userName: emailController.text,
        ),
        
        influencer: CreateInfluencerModelInfluencer(
          name:
              '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
          isActive: true,
          photoId: null,
            numberOfProduct: int.tryParse(numberOfController.text) ?? 0, 
          
        ),
      );

      var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Auth/RegisterInfluencers',
        body: addUser.toJson(),
      );

      result.fold((success) {
        loading.hide; // ✅ أخفي التحميل بعد النجاح
        widget.refresh();
        Navigator.pop(context);
        showSuccessMessage(
          message: isArabic
              ? 'تم إضافة المستخدم بنجاح'
              : 'User added successfully',
        );
      }, (error) {
        loading.hide; // ✅ أخفي التحميل حتى عند الخطأ
        showErrorMessage(message: error.message);
      });
    } catch (error) {
      loading.hide;
      showErrorMessage(
        message: isArabic
            ? 'حدث خطأ أثناء إضافة المستخدم'
            : 'An error occurred while adding the user',
      );
    }
  }
}

updateUser() async {
  loading.show;
  if (formKey.currentState!.validate()) {
    UpdateInfluencerModel updateUserModel = UpdateInfluencerModel(
      isActive: true,
      bankAccountNumber: widget.userModel.bankAccountNumber,
      facebookLink: widget.userModel.facebookLink,
      idNumber: widget.userModel.idNumber,
      instagramLink: widget.userModel.instagramLink,
      linkedInLink: widget.userModel.linkedInLink,
      snapchatLink: widget.userModel.snapchatLink,
      telegramNumber1: widget.userModel.telegramNumber1,
      telegramNumber2: widget.userModel.telegramNumber2,
      tikTokLink: widget.userModel.tikTokLink,
      twitterLink: widget.userModel.twitterLink,
      whatsappNumber1: widget.userModel.whatsappNumber1,
      whatsappNumber2: widget.userModel.whatsappNumber2,
      youTubeLink: widget.userModel.youTubeLink,
      userId: widget.userModel.id,
numberOfProduct: int.tryParse(numberOfController.text) ?? 0,
      name:
          '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
      id: widget.userModel.id,
      influencerStatusId: widget.userModel.influencerStatusId,
    );

    var result = await AppService.callService(
      actionType: ActionType.post,
      apiName: 'api/Influencer/Update',
      body: updateUserModel.toJson(),
    );

    result.fold((success) {
      widget.refresh();
      Navigator.pop(context);
      showSuccessMessage(
        message: isArabic
            ? 'تم تغيير بيانات المستخدم بنجاح'
            : 'User edited successfully',
      );
    }, (failure) {
      showErrorMessage(message: failure.message);
    });
  }
  loading.hide;
}
}
//   updateUser() async {
//     if (selectedImage == null) {
//       loading.show;
//       if (formKey.currentState!.validate()) {
//         UpdateInfluencerModel updateUserModel = UpdateInfluencerModel(
//             isActive: true,
//             bankAccountNumber: widget.userModel.bankAccountNumber,
//             facebookLink: widget.userModel.facebookLink,
//             idNumber: widget.userModel.idNumber,
//             instagramLink: widget.userModel.instagramLink,
//             linkedInLink: widget.userModel.linkedInLink,
//             snapchatLink: widget.userModel.snapchatLink,
//             telegramNumber1: widget.userModel.telegramNumber1,
//             telegramNumber2: widget.userModel.telegramNumber2,
//             tikTokLink: widget.userModel.tikTokLink,
//             twitterLink: widget.userModel.twitterLink,
//             whatsappNumber1: widget.userModel.whatsappNumber1,
//             whatsappNumber2: widget.userModel.whatsappNumber2,
//             youTubeLink: widget.userModel.youTubeLink,
//             userId: widget.userModel.id,
//             // photoId: widget.userModel.photoId,
//             numberOfProduct: numberOfController.text,
//             name:
//                 '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
//             id: widget.userModel.id,
//             influencerStatusId: widget.userModel.influencerStatusId);

//         var result = await AppService.callService(
//             actionType: ActionType.post,
//             apiName: 'api/Influencer/Update',
//             body: updateUserModel.toJson());

//         result.fold((success) {
//           widget.refresh();
//           Navigator.pop(context);
//           showSuccessMessage(
//               message: isArabic
//                   ? 'تم تغيير بيانات المستخدم بنجاح'
//                   : 'User edited successfully');
//         }, (failure) {
//           showErrorMessage(message: failure.message);
//         });
//       }
//       loading.hide;
//     }
//     if (formKey.currentState!.validate() && selectedImage != null) {
//       loading.show;
//       final bytes = await selectedImage?.readAsBytes();
//       String img64 = base64Encode(bytes!.toList());

//       await context.uploadAttachment(
//           img64: img64,
//           imageName: selectedImage?.name ?? '',
//           afterUpload: (selectedId) async {
//             await Future.delayed(Duration(milliseconds: 200));
//             try {
//               UpdateInfluencerModel updateUserModel = UpdateInfluencerModel(
//                   isActive: true,
//                   userId: widget.userModel.id,
//                   photoId: selectedId,
//                   name:
//                       '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
//                   id: widget.userModel.id,
//                   influencerStatusId: widget.userModel.influencerStatusId);

//               var result = await AppService.callService(
//                   actionType: ActionType.post,
//                   apiName: 'api/Influencer/Update',
//                   body: updateUserModel.toJson());

//               result.fold((success) {
//                 widget.refresh();
//                 Navigator.pop(context);
//                 showSuccessMessage(
//                     message: isArabic
//                         ? 'تم تغيير بيانات المستخدم بنجاح'
//                         : 'User edited successfully');
//               }, (failure) {
//                 showErrorMessage(message: failure.message);
//               });
//             } catch (error) {}
//           });

//       loading.hide;
//     }
//   }
// }

/*
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart'; // لو فيها showSuccessMessage

class AddInfluencerPage extends StatefulWidget {
  const AddInfluencerPage({super.key});

  @override
  State<AddInfluencerPage> createState() => _AddInfluencerPageState();
}

class _AddInfluencerPageState extends State<AddInfluencerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController numberOfProductsController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final numberOfProduct = int.tryParse(numberOfProductsController.text.trim()) ?? 0;
    final password = passwordController.text.trim().isEmpty ? null : passwordController.text.trim();

    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "numberOfProduct": numberOfProduct,
      if (password != null) "password": password,
    };

    setState(() => isLoading = true);

    final response = await AppService.callService(
      actionType: ActionType.post,
      apiName: 'api/Influencer/Add',
      body: body,
    );

    setState(() => isLoading = false);

    response.fold((success) {
      showSuccessMessage(message: 'تم إضافة المؤثر بنجاح');
      Navigator.pop(context);
    }, (fail) {
      showErrorMessage(message: 'فشل في الإضافة: ${fail.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة مؤثر")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(controller: nameController, label: "الاسم", validator: _requiredValidator),
              _buildField(controller: emailController, label: "الإيميل", validator: _requiredValidator, keyboardType: TextInputType.emailAddress),
              _buildField(controller: phoneController, label: "رقم الهاتف", validator: _requiredValidator, keyboardType: TextInputType.phone),
              _buildField(controller: numberOfProductsController, label: "عدد المنتجات", validator: _requiredValidator, keyboardType: TextInputType.number),
              _buildField(controller: passwordController, label: "كلمة السر (اختياري)", obscure: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading ? CircularProgressIndicator() : Text("إضافة المؤثر"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }
}
*/
/*
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/models/user/create_influencer_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/influencer_model.dart';
import 'package:sislimoda_admin_dashboard/models/user/update_influencer_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class AddInfluencer extends StatefulWidget {
  const AddInfluencer(
      {super.key,
      required this.operationType,
      required this.refresh,
      required this.userModel});
  final OperationType operationType;
  final Function refresh;
  final InfluencerModel userModel;
  @override
  State<AddInfluencer> createState() => _AddInfluencerState();
}

class _AddInfluencerState extends State<AddInfluencer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GenericCubit<String> imageCubit = GenericCubit<String>();
  XFile? selectedImage;
  Loading loading = Loading();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberOfController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime currentDate = DateTime.now();
  String selectedGender = '';
  List<ValueItem>? selectedGenders;

  @override
  void initState() {
    // TODO: implement initState
    imageCubit.update(data: '');

    if (widget.operationType == OperationType.update) {
      print('widget.userModel.name ${widget.userModel.name}');
      imageCubit.update(data: widget.userModel.photo?.fullLink ?? '');
      firstNameController.text = widget.userModel.name?.split(' ')[0] ?? '';
      middleNameController.text = widget.userModel.name?.split(' ')[1] ?? '';
      lastNameController.text = widget.userModel.name?.split(' ')[2] ?? '';
      emailController.text = widget.userModel.user?.email ?? '';
      phoneController.text = widget.userModel.user?.phoneNumer ?? '';
      numberOfController.text = widget.userModel.numberOfProduct ?? '';
      addressController.text = widget.userModel.user?.address ?? '';
      dateController.text =
          widget.userModel.user?.birthDate?.split(' ')[0] ?? '';
      if (widget.userModel.user?.gender == '1') {
        selectedGenders = [
          ValueItem(value: '1', label: isArabic ? 'ذكر' : 'Male')
        ];
      } else {
        selectedGenders = [
          ValueItem(value: '2', label: isArabic ? 'آنثي' : 'Female')
        ];
      }
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
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: isArabic
                                    ? "عدد المنتجات للحملة"
                                    : "Number of product for campaign",
                                controller: numberOfController,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomMultiSelect(
                                  items: [
                                    ValueItem(
                                        value: '1',
                                        label: isArabic ? 'ذكر' : 'Male'),
                                    ValueItem(
                                        value: '2',
                                        label: isArabic ? 'آنثي' : 'Female')
                                  ],
                                  selectedItems: selectedGenders ?? [],
                                  onChange: (List<ValueItem> value) {
                                    if (value.isNotEmpty) {
                                      selectedGender = value.first.value;
                                    } else {
                                      selectedGender = '';
                                    }
                                  },
                                  isSingle: true,
                                  hint: isArabic ? 'الجنس' : 'Select gender'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: context.isMobile ? 3 : 4,
                                child: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                        builder: (context, widget) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: .4.sw,
                                                child: Material(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Column(
                                                    children: [
                                                      CalendarDatePicker(
                                                          currentDate:
                                                              currentDate,
                                                          initialDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                                  .now()
                                                              .subtract(Duration(
                                                                  days: 20000)),
                                                          onDateChanged:
                                                              (date) {
                                                            currentDate = date;
                                                            dateController
                                                                .text = DateFormat(
                                                                    'MM/dd/yyyy')
                                                                .format(date);
                                                          }),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        height: 45,
                                                        child: AppButton(
                                                          borderRadius: 0,
                                                          titleFontSize: 16,
                                                          onPress: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          title: LocaleKeys
                                                              .selectDate
                                                              .tr(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        context: context,
                                        lastDate: DateTime.now(),
                                        firstDate: DateTime.now()
                                            .subtract(Duration(days: 20000)));
                                  },
                                  child: CustomTextField(
                                    controller: dateController,
                                    onTap: () {},
                                    enabled: false,
                                    hintText: LocaleKeys.selectDate.tr(),
                                    labelText: LocaleKeys.orderDate.tr(),
                                    iconData: AppImages.calendar,
                                  ),
                                )),
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
              CreateInfluencerModel addUser = CreateInfluencerModel(
                  appUser: CreateInfluencerModelAppUser(
                      photoId: selectedId,
                      phoneNumer: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                      firstName: firstNameController.text,
                      middleName: middleNameController.text,
                      lastName: lastNameController.text,
                      password: passwordController.text,
                      isAdmin: false,
                      enableNotification: false,
                      socialLogin: '7',
                      isActive: true,
                      isVendor: false,
                      coachMeasurement: '',
                      isInfluencer: true,
                      isSocialLogin: false,
                      birthDate: dateController.text,
                      gender: selectedGender,
                      otherPhoneNumber: phoneController.text,
                      pantsMeasurement: '',
                      tShirtmeasurement: '',
                      userName: emailController.text),
                  influencer: CreateInfluencerModelInfluencer(
                    name:
                        '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
                    isActive: true,
                    photoId: selectedId,
                  ));

              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Auth/RegisterInfluencers',
                  body: addUser.toJson());

              result.fold((success) {
                widget.refresh();
                Navigator.pop(context);
                showSuccessMessage(
                    message: isArabic
                        ? 'تم إضافة المستخدم بنجاح'
                        : 'User added successfully');
              }, (error) {
                showErrorMessage(message: error.message);
              });
            } catch (error) {
              loading.hide;
            }
          });
    }
  }

  updateUser() async {
    if (selectedImage == null) {
      loading.show;
      if (formKey.currentState!.validate()) {
        UpdateInfluencerModel updateUserModel = UpdateInfluencerModel(
            isActive: true,
            bankAccountNumber: widget.userModel.bankAccountNumber,
            facebookLink: widget.userModel.facebookLink,
            idNumber: widget.userModel.idNumber,
            instagramLink: widget.userModel.instagramLink,
            linkedInLink: widget.userModel.linkedInLink,
            snapchatLink: widget.userModel.snapchatLink,
            telegramNumber1: widget.userModel.telegramNumber1,
            telegramNumber2: widget.userModel.telegramNumber2,
            tikTokLink: widget.userModel.tikTokLink,
            twitterLink: widget.userModel.twitterLink,
            whatsappNumber1: widget.userModel.whatsappNumber1,
            whatsappNumber2: widget.userModel.whatsappNumber2,
            youTubeLink: widget.userModel.youTubeLink,
            userId: widget.userModel.id,
            photoId: widget.userModel.photoId,
            numberOfProduct: numberOfController.text,
            name:
                '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
            id: widget.userModel.id,
            influencerStatusId: widget.userModel.influencerStatusId);

        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Influencer/Update',
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
              UpdateInfluencerModel updateUserModel = UpdateInfluencerModel(
                  isActive: true,
                  userId: widget.userModel.id,
                  photoId: selectedId,
                  name:
                      '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
                  id: widget.userModel.id,
                  influencerStatusId: widget.userModel.influencerStatusId);

              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Influencer/Update',
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
*/