//  import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_dropdown/models/value_item.dart';
// import 'package:sislimoda_admin_dashboard/components/button/button.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
// import 'package:sislimoda_admin_dashboard/components/screen.dart';
// import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
// import 'package:sislimoda_admin_dashboard/helper/validation.dart';
// import 'package:sislimoda_admin_dashboard/models/user/update_influencer_model.dart';
// import 'package:sislimoda_admin_dashboard/models/users/InfluencerModel.dart';
// import 'package:sislimoda_admin_dashboard/services/app_services.dart';
// import 'package:sislimoda_admin_dashboard/translations/locale_keys.g.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
// import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

// class EditInfluencer extends StatefulWidget {
//   const EditInfluencer({
//     super.key,
//     required this.userModel,
//     required this.refresh, required Null Function(dynamic updatedInfluencer) onSave,
//   });

//   final InfluencerModel userModel;
//   final Function refresh;

//   @override
//   State<EditInfluencer> createState() => _EditInfluencerState();
// }

// class _EditInfluencerState extends State<EditInfluencer> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   Loading loading = Loading();

//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController middleNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController numberOfController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();

//   DateTime currentDate = DateTime.now();
//   String selectedGender = '';
//   List<ValueItem>? selectedGenders;

//   @override
//   void initState() {
//     final user = widget.userModel;

//     firstNameController.text = user.name?.split(' ')[0] ?? '';
//     middleNameController.text = user.name?.split(' ')[1] ?? '';
//     lastNameController.text = user.name?.split(' ')[2] ?? '';
//     emailController.text = user.user?.email ?? '';
//     phoneController.text = user.user?.phoneNumer ?? '';
//     numberOfController.text = user.numberOfProduct?.toString() ?? '';
//     addressController.text = user.user?.address ?? '';
//     dateController.text = user.user?.birthDate?.split(' ')[0] ?? '';
//       // productsCountController = TextEditingController(
//       //   text: widget.influencer.numberOfProduct?.toString() ?? '0',
//       // );
//     if (user.user?.gender == '1') {
//       selectedGenders = [ValueItem(value: '1', label: isArabic ? 'ذكر' : 'Male')];
//       selectedGender = '1';
//     } else {
//       selectedGenders = [ValueItem(value: '2', label: isArabic ? 'آنثي' : 'Female')];
//       selectedGender = '2';
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Screen(
//       loadingCubit: loading,
//       child: Dialog(
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
//         backgroundColor: Colors.white,
//         child: Container(
//           width: 792,
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         LocaleKeys.edit.tr(),
//                         style: AppFonts.apptextStyle.copyWith(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 20,
//                         ),
//                       ),
//                       const Spacer(),
//                       InkWell(
//                         onTap: () => Navigator.pop(context),
//                         child: const Icon(Icons.close),
//                       )
//                     ],
//                   ),
//                   const Divider(),
//                   const SizedBox(height: 16),
//                   // الاسم
//                   Row(
//                     children: [
//                       Expanded(child: CustomTextField(
//                         onTap: (){},
//                         labelText: LocaleKeys.firstName.tr(), controller: firstNameController)),
//                       const SizedBox(width: 10),
//                       Expanded(child: CustomTextField(
//                         onTap: (){},
//                         labelText: LocaleKeys.middleName.tr(), controller: middleNameController)),
//                       const SizedBox(width: 10),
//                       Expanded(child: CustomTextField(
//                         onTap: (){},
//                         labelText: LocaleKeys.lastName.tr(), controller: lastNameController)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // الإيميل - رقم الهاتف - عدد المنتجات
//                   Row(
//                     children: [
//                       Expanded(child: CustomTextField(
//                         onTap: (){},
//                         labelText: LocaleKeys.email.tr(), controller: emailController, textFieldValidType: TextFieldvalidatorType.email)),
//                       const SizedBox(width: 10),
//                       Expanded(child: CustomTextField(
//                         onTap: (){},
//                         labelText: LocaleKeys.mobileNumber.tr(), controller: phoneController)),
//                       const SizedBox(width: 10),
//                       Expanded(child: CustomTextField(
//                         onTap: (){},
//                         labelText: isArabic ? 'عدد المنتجات للحملة' : 'Number of product ',
//                          controller: numberOfController)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // الجنس + تاريخ الميلاد
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomMultiSelect(
//                           items: [
//                             ValueItem(value: '1', label: isArabic ? 'ذكر' : 'Male'),
//                             ValueItem(value: '2', label: isArabic ? 'آنثي' : 'Female'),
//                           ],
//                           selectedItems: selectedGenders ?? [],
//                           onChange: (values) {
//                             if (values.isNotEmpty) {
//                               selectedGender = values.first.value;
//                             }
//                           },
//                           isSingle: true,
//                           hint: isArabic ? 'الجنس' : 'Select gender',
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       // Expanded(
//                       //   child: GestureDetector(
//                       //     onTap: () async {
//                       //       final date = await showDatePicker(
//                       //         context: context,
//                       //         initialDate: currentDate,
//                       //         firstDate: DateTime(1950),
//                       //         lastDate: DateTime.now(),
//                       //       );
//                       //       if (date != null) {
//                       //         setState(() {
//                       //           currentDate = date;
//                       //           dateController.text = DateFormat('MM/dd/yyyy').format(date);
//                       //         });
//                       //       }
//                       //     },
//                       //     child: CustomTextField(
//                       //       controller: dateController,
//                       //       enabled: false,
//                       //       labelText: LocaleKeys.orderDate.tr(),
//                       //       iconData: AppImages.calendar, onTap: (){},
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextField(
//                     onTap: (){},
//                     labelText: isArabic ? 'العنوان' : 'Address',
//                     controller: addressController,
//                   ),
//                   const SizedBox(height: 32),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 205,
//                         height: 50,
//                         child: AppButton(
//                           title: LocaleKeys.edit.tr(),
//                           onPress: updateUser,
//                           borderRadius: 8,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void updateUser() async {
//     if (!formKey.currentState!.validate()) return;

//     loading.show;

//     final user = widget.userModel;

//     final model = UpdateInfluencerModel(
//       isActive: true,
//       userId: user.id,
//       id: user.id,
//       name: '${firstNameController.text} ${middleNameController.text} ${lastNameController.text}',
//       numberOfProduct: int.tryParse(numberOfController.text) ?? 0,
//       influencerStatusId: user.influencerStatusId,
//       bankAccountNumber: user.bankAccountNumber,
//       facebookLink: user.facebookLink,
//       idNumber: user.idNumber,
//       instagramLink: user.instagramLink,
//       linkedInLink: user.linkedInLink,
//       snapchatLink: user.snapchatLink,
//       telegramNumber1: user.telegramNumber1,
//       telegramNumber2: user.telegramNumber2,
//       tikTokLink: user.tikTokLink,
//       twitterLink: user.twitterLink,
//       whatsappNumber1: user.whatsappNumber1,
//       whatsappNumber2: user.whatsappNumber2,
//       youTubeLink: user.youTubeLink,
//     );

//     final result = await AppService.callService(
//       actionType: ActionType.post,
//       apiName: 'api/Influencer/Update',
//       body: model.toJson(),
//     );

//     result.fold((success) {
//       widget.refresh();
//       Navigator.pop(context);
//       showSuccessMessage(message: isArabic ? 'تم تحديث المستخدم بنجاح' : 'Influencer updated successfully');
//     }, (fail) {
//       showErrorMessage(message: fail.message);
//     });

//     loading.hide;
//   }
// }

 
 import 'package:flutter/material.dart';
  import 'package:sislimoda_admin_dashboard/models/users/InfluencerModel.dart';

  class InfluencerFormDialog extends StatefulWidget {
    final InfluencerModel influencer;
    final Function(InfluencerModel) onSave;

    const InfluencerFormDialog({
      super.key,
      required this.influencer,
      required this.onSave,
    });

    @override
    State<InfluencerFormDialog> createState() => _InfluencerFormDialogState();
  }

  class _InfluencerFormDialogState extends State<InfluencerFormDialog> {
    late TextEditingController nameController;
    late TextEditingController emailController;
    late TextEditingController phoneController;
    late TextEditingController productsCountController;

    @override
    void initState() {
      super.initState();
      nameController = TextEditingController(text: widget.influencer.name ?? '');
      emailController = TextEditingController(text: widget.influencer.user?.email ?? '');
      phoneController = TextEditingController(text: widget.influencer.user?.phoneNumer ?? '');
      productsCountController = TextEditingController(
        text: widget.influencer.numberOfProduct?.toString() ?? '0',
      );
    }

    @override
    void dispose() {
      nameController.dispose();
      emailController.dispose();
      phoneController.dispose();
      productsCountController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        title: const Text('تعديل بيانات المؤثر'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'الإيميل'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'رقم الموبايل'),
              ),
              TextField(
                controller: productsCountController,
                decoration: const InputDecoration(labelText: 'عدد منتجات الحملة'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
           onPressed: () {
  final updated = InfluencerModel(
    id: widget.influencer.id,
    isActive: widget.influencer.isActive ?? true, 

    // القيم المحدثة
    name: nameController.text,
    email: emailController.text,
    phone: phoneController.text,
    numberOfProduct: int.tryParse(productsCountController.text),

    // القيم المتبقية كما هي
    photoId: widget.influencer.photoId,
    photo: widget.influencer.photo,
    userId: widget.influencer.userId,
    user: widget.influencer.user,
    influencerStatusId: widget.influencer.influencerStatusId,
    influencerStatus: widget.influencer.influencerStatus,
    idNumber: widget.influencer.idNumber,
    bankAccountNumber: widget.influencer.bankAccountNumber,
    whatsappNumber1: widget.influencer.whatsappNumber1,
    whatsappNumber2: widget.influencer.whatsappNumber2,
    telegramNumber1: widget.influencer.telegramNumber1,
    telegramNumber2: widget.influencer.telegramNumber2,
    facebookLink: widget.influencer.facebookLink,
    twitterLink: widget.influencer.twitterLink,
    instagramLink: widget.influencer.instagramLink,
    linkedInLink: widget.influencer.linkedInLink,
    youTubeLink: widget.influencer.youTubeLink,
    snapchatLink: widget.influencer.snapchatLink,
    tikTokLink: widget.influencer.tikTokLink,
    password: widget.influencer.password,
  );

  widget.onSave(updated);
  Navigator.pop(context);
},

            child: const Text('حفظ'),
          ),
        ],
      );
    }
  }
