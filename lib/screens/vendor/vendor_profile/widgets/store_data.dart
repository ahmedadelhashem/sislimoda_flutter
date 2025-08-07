import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/models/general/side_bar_model.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class StoreData extends StatefulWidget {
  const StoreData({super.key, required this.vendorModel});
  final VendorModel vendorModel;
  @override
  State<StoreData> createState() => _StoreDataState();
}

class _StoreDataState extends State<StoreData> {
  Loading loading = Loading();
  TextEditingController nameArabicController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController numOfProductController = TextEditingController();
  TextEditingController nameEnglishController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController descriptionArabicController = TextEditingController();
  TextEditingController descriptionEnglishController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otherPhoneController = TextEditingController();
  List<ValueItem> fieldOfWork = [
    ValueItem(value: '1', label:tr('field.clothes')),
    ValueItem(value: '2', label:tr('field.games') ),
    ValueItem(value: '3', label: tr('field.children')),
    ValueItem(value: '4', label: tr('field.makeup')),
  ];
  List<ValueItem> companyTypes = [
    ValueItem(value: '1', label: tr('company.store')),
    ValueItem(value: '2', label: tr('company.company')),
    ValueItem(
        value: '3', label: tr('company.broker')),
  ];
  List<ValueItem> selectedFieldOfWork = [];
  ValueItem? selectedCompanyType;
  GenericCubit<String> imageCubit = GenericCubit<String>();
  GenericCubit<List<Item>> attachmentsCubit = GenericCubit<List<Item>>();
  List<Item> attachments = [];
  String companyType = '';
  XFile? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState

    for (var element in fieldOfWork) {
      if (widget.vendorModel.workFields?.contains(element.value) == true) {
        selectedFieldOfWork.add(element);
      }
    }
    if (widget.vendorModel.companyType != null &&
        widget.vendorModel.companyType!.isNotEmpty) {
      selectedCompanyType = companyTypes.firstWhere(
          (element) => element.value == widget.vendorModel.companyType);
    }
    for (var element in widget.vendorModel.vendorCompanyAttachments!) {
      attachments.add(Item(
          key: element?.id ?? '', value: element?.attachment?.fullLink ?? ''));
    }
    print('attachments ${attachments.length}');
    attachmentsCubit.update(data: attachments);
    nameArabicController.text = widget.vendorModel.name ?? '';
    companyType = widget.vendorModel.companyType ?? '';
    nameEnglishController.text = widget.vendorModel.nameEn ?? '';
    descriptionArabicController.text = widget.vendorModel.description ?? '';
    descriptionEnglishController.text = widget.vendorModel.descriptionEn ?? '';
    phoneController.text = widget.vendorModel.ownerPhoneNumber ?? '';
    otherPhoneController.text = widget.vendorModel.ownerPhoneNumber2 ?? '';
    fullAddressController.text = widget.vendorModel.fullCompanyAddress ?? '';
    numOfProductController.text =
        widget.vendorModel.numberOfProductsToSell ?? '';
    bankNameController.text = widget.vendorModel.bankName ?? '';
    bankNumberController.text = widget.vendorModel.bankNumber ?? '';
    ibanController.text = widget.vendorModel.iban ?? '';

    imageCubit.update(data: widget.vendorModel.baner?.fullLink ?? '');
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic
                      ? 'اضف الشعار / يجب مراعاه حجم الشعار ليكون 300 طول * 500 عرض ومضاعفاتها' : isTurkish
                          ? 'Logoyu ekleyin / Logonun boyutunun 300 uzunluk * 500 genişlik ve katları olması gerekir'                          
                      : 'Add the logo / The logo size must be 300 length * 500 width and multiples thereof',
                  style: AppFonts.apptextStyle
                      .copyWith(color: Colors.black, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GenericBuilder(
                        genericCubit: imageCubit,
                        builder: (image) {
                          return SizedBox(
                            width: 150,
                            height: 150,
                            child: CustomNetworkImage(
                                link: image, height: 150, width: 150),
                          );
                        }),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: 250,
                  height: 48,
                  child: AppButton(
                    title: widget.vendorModel.baner?.fullLink != null
                        ? isArabic
                            ? 'تعديل الشعار' : isTurkish
                                ? 'Afişi Değiştir'
                                : "Change Banner"
                        : isArabic
                            ? 'إضافة الشعار': isTurkish
                                ? 'Afiş Ekle'
                            : "Add Banner",
                    titleFontSize: 14.sp,
                    onPress: () {
                      UploadImageController.getFormDataImage().then((file) {
                        if (file != null) {
                          imageCubit.update(data: file.path ?? '');
                          image = file;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  isArabic
                      ? 'هل انت متجر ام شركة مصنعة للمنتجات التي سوف تعرضها' : isTurkish
                          ? 'Ürünlerinizi sergileyeceğiniz bir mağaza mısınız yoksa üretici misiniz?'
                          : "Are you a store or a manufacturer of the products you will be displaying?",
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    width: 200,
                    child: CustomMultiSelect(
                        isSingle: true,
                        hint:
                            isArabic ? 'حدد نوع الشركة' : isTurkish?'Şirket türünü seçin': 'Select company type',
                        items: companyTypes,
                        selectedItems: selectedCompanyType != null
                            ? [
                                selectedCompanyType ??
                                    ValueItem(label: '', value: '')
                              ]
                            : [],
                        onChange: (List<ValueItem> value) {
                          if (value.isNotEmpty) {
                            companyType = value.first.value;
                          }
                        })),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onTap: () {},
                  labelText: isArabic ? 'العنوان بالكامل' : isTurkish?'Tam adres': 'Full address',
                  controller: fullAddressController,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        onTap: () {},
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: numOfProductController,
                        labelText: isArabic
                            ? 'عدد المنتجات التي ترغب بعرضها' : isTurkish
                                ? 'Göstermek istediğiniz ürün sayısı'
                                : "Number of products you wish to display",
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic
                                ? 'ما هو قطاع الاعمال الذي تعمل به' :isTurkish?'Hangi iş sektöründe çalışıyorsunuz?'
                                : "What business sector do you work in?",
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryFontColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: 50,
                              child: CustomMultiSelect(
                                  hint: isArabic
                                      ? 'حدد نوع العمل' :isTurkish? 'İş türünü seçin'
                                      : 'Select Business type',
                                  items: fieldOfWork,
                                  selectedItems: selectedFieldOfWork,
                                  onChange: (value) {
                                    selectedFieldOfWork = value;
                                  })),
                        ],
                      ),
                    )
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
                        labelText: isArabic
                            ? "اسم المتجر بالغة العربية" :isTurkish? 'Mağaza adı (Arapça)'
                            : "Store name in arabic",
                        controller: nameArabicController,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomTextField(
                        onTap: () {},
                        labelText: isArabic
                            ? "اسم المتجر بالغة الانجليزية": isTurkish?'Mağaza adı (İngilizce)'
                            : "Store name in english",
                        controller: nameEnglishController,
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
                        labelText: isArabic ? 'اسم البنك' : isTurkish?'Banka adı': "bank name",
                        controller: bankNameController,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomTextField(
                        onTap: () {},
                        labelText: isArabic ? 'الحساب البنكي' : isTurkish? "Banka hesabı": "bank account",
                        controller: bankNumberController,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomTextField(
                        onTap: () {},
                        labelText: 'Iban',
                        controller: ibanController,
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
                        labelText: LocaleKeys.descriptionArabic.tr(),
                        controller: descriptionArabicController,
                        maxlines: 4,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomTextField(
                        onTap: () {},
                        labelText: LocaleKeys.descriptionEnglish.tr(),
                        controller: descriptionEnglishController,
                        maxlines: 4,
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
                        labelText: LocaleKeys.mobileNumber.tr(),
                        controller: phoneController,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomTextField(
                        onTap: () {},
                        labelText: '${LocaleKeys.mobileNumber.tr()} 2',
                        controller: otherPhoneController,
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
                Text(
                  isArabic? 'اضف مرفقات الشركة كاملة': isTurkish?"Şirketin tüm belgelerini ekleyin": 'Add full company attachments',
                  style: AppFonts.apptextStyle
                      .copyWith(color: Colors.black, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          UploadImageController.getFormDataImage()
                              .then((value) async {
                            if (value != null) {
                              final bytes = await value.readAsBytes();
                              String img64 = base64Encode(bytes.toList());
                              await currentContext.uploadAttachment(
                                  img64: img64,
                                  imageName: value.name ?? '',
                                  afterUpload: (selectedId) async {
                                    loading.show;
                                    await AppService.callService(
                                        actionType: ActionType.post,
                                        apiName:
                                            'api/Vendor/AddVendorCompanyAttachments',
                                        body: {
                                          "vendorId": widget.vendorModel.id,
                                          "attachmentId": selectedId
                                        });
                                    await getVendorData();
                                    loading.hide;
                                  });
                            }
                          });
                        },
                        child: SizedBox(
                          width: 160,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(24.r),
                            strokeWidth: 1,
                            strokeCap: StrokeCap.butt,
                            color: AppColors.error,
                            padding: EdgeInsets.zero,
                            dashPattern: [10],
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 40, top: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
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
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                        )
                        ),
                    GenericBuilder(
                        genericCubit: attachmentsCubit,
                        builder: (attachments) {
                          return Row(
                            children: attachments
                                .map((element) => InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return Dialog(
                                                child: Container(
                                                  width: 500,
                                                  height: 500,
                                                  child: CustomNetworkImage(
                                                      link: element.value,
                                                      height: 500,
                                                      width: 500),
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 160,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Stack(
                                          children: [
                                            CustomNetworkImage(
                                                link: element.value,
                                                height: 160,
                                                width: 160),
                                            Positioned(
                                                right: 10,
                                                top: 10,
                                                child: InkWell(
                                                  onTap: () async {
                                                    loading.show;
                                                    await AppService.callService(
                                                        actionType:
                                                            ActionType.post,
                                                        apiName:
                                                            'api/Vendor/DeleteVendorCompanyAttachments?Id=${element.key}',
                                                        body: {});
                                                    await getVendorData();
                                                    loading.hide;
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        })
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( isArabic 
    ? 'لقد انتهينا، أنت على بُعد خطوات من عرض منتجاتك' : isTurkish
    ? 'Ürünlerinizi sergilemek için sadece birkaç adım kaldı'
    : "We're done, you're just a few steps away from showcasing your products",
                      style: AppFonts.apptextStyle
                          .copyWith(color: Colors.red, fontSize: 20.sp),
                    ),
                  ],
                ),
                Text(
isArabic
  ? '- بالضغط على "حفظ"، أنت توافق على عرض منتجاتك في تطبيق شيشلي مودا.\n'
    '- نحن وسطاء بيع، ولا نتحمل تكلفة المنتجات (التالفة، المسترجعة، العيوب، أو العيوب المصنعية الأخرى).\n'
    '- يُسمح ببيع المنتجات وفقًا لقوانين الجمهورية التركية فقط.' : isTurkish ? 
    '- "Kaydet" butonuna tıklayarak ürünlerinizi Şişli Moda uygulamasında sergilemeyi kabul edersiniz.\n'
    '- Biz satış aracısıyız ve hasarlı, iade edilen, kusurlu veya diğer üretim hatalı ürünlerden sorumlu değiliz.\n'
    '- Ürünler, Türkiye Cumhuriyeti yasalarına uygun olmalıdır.'
  : '- By clicking "Save", you agree to showcase your products on the Şişli Moda app.\n'
    '- We act as sales intermediaries and are not responsible for damaged, returned, defective, or faulty products.\n'
    '- Products must comply with the laws of the Republic of Türkiye.',
                      style: AppFonts.apptextStyle.copyWith(
                      color: Colors.black, fontSize: 14.sp, height: 2),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 48,
                      child: AppButton(
                        title: isArabic ? 'حفظ' : isTurkish ? 'Kaydet':  "Save",
                        titleFontSize: 14.sp,
                        onPress: _updateProfile,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateProfile() async {
            final isTurkish = Localizations.localeOf(context).languageCode == 'tr';

    if (widget.vendorModel.baner?.fullLink == null && image == null) {
      showErrorMessage(
          message: isArabic
              ? "الرجاء اضافة صوره الشعار" : isTurkish
                  ? "Lütfen bir logo resmi ekleyin"
              : "Please add a logo image.");
      return;
    } else if (attachments.isEmpty) {
      showErrorMessage(
          message: isArabic
              ? "الرجاء اضافة صوره مستندات الشركة" : isTurkish
                  ? "Lütfen şirket belgelerini ekleyin"
              : "Please add a company attachments images");
      return;
    } else if (attachments.isEmpty) {
      showErrorMessage(
          message: isArabic
              ? "الرجاء اضافة صوره مستندات الشركة" : isTurkish
                  ? "Lütfen şirket belgelerini ekleyin"
              : "Please add a company attachments images");
      return;
    } else if (selectedFieldOfWork.isEmpty) {
      showErrorMessage(
          message: isArabic
              ? "الرجاء اختيار مجال عمل الشركة" : isTurkish
                  ? "Lütfen şirket iş alanını seçin"
              : "Please add a company field of work");
      return;
    } else if (companyType.isEmpty) {
      showErrorMessage(
          message: isArabic
              ? "الرجاء اختيار نوع الشركة" : isTurkish
                  ? "Lütfen şirket türünü seçin"
              : "Please add a company Type");
      return;
    }
    if (formKey.currentState!.validate()) {
      if (image != null) {
        final bytes = await image!.readAsBytes();
        String img64 = base64Encode(bytes.toList());

        await context.uploadAttachment(
            img64: img64,
            imageName: image!.name,
            afterUpload: (selectedId) async {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  _sendUpdateData(imageId: selectedId ?? '');
                },
              );
            });
      } else {
        _sendUpdateData(imageId: widget.vendorModel.banerId ?? '');
      }
    }
  }

  _sendUpdateData({required String imageId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Vendor/Update',
          body: {
            "id": widget.vendorModel.id,
            "name": nameArabicController.text,
            "nameEn": nameEnglishController.text,
            "description": descriptionArabicController.text,
            "descriptionEn": descriptionEnglishController.text,
            "ownerName": widget.vendorModel.ownerName,
            "ownerPhoneNumber": phoneController.text,
            "ownerPhoneNumber2": otherPhoneController.text,
            "isActive": widget.vendorModel.isActive,
            "logoId": imageId,
            "isApproved": widget.vendorModel.isApproved,
            "banerId": imageId,
            "ownerId": widget.vendorModel.ownerId,
            "vendorStatusId": widget.vendorModel.vendorStatusId,
            "isStore": widget.vendorModel.isStore,
            "isPreferred": widget.vendorModel.isPreferred,
            "companyName": nameArabicController.text,
            "fullCompanyAddress": fullAddressController.text,
            "numberOfProductsToSell": numOfProductController.text,
            "companyType": companyType,
            "workFieldsList":
                selectedFieldOfWork.map((element) => element.value).toList(),
            "bankNumber": bankNumberController.text,
            "iban": ibanController.text,
            "bankName": bankNameController.text
          });

      result.fold((success) {
        BlocProvider.of<UserCubit>(context).getUserData();
        if (widget.vendorModel.vendorStatus?.value != '3') {
          currentContext.router.push(AddProductsNewRoute());
        }
        Future.delayed(
          Duration(milliseconds: 400),
          () {
            showSuccessMessage(
                message: isArabic
                    ? 'تم تحديث بيانات المتجر بنجاح'
                    : "Store updated successfully");
          },
        );
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

  getVendorData() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userId = ref.getString('vendorId');
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Vendor/GetById?Id=$userId',
          body: null);

      result.fold((success) {
        VendorModel vendor = VendorModel.fromJson(jsonDecode(success));
        attachments = [];
        for (var element in vendor.vendorCompanyAttachments!) {
          attachments.add(Item(
              key: element?.id ?? '',
              value: element?.attachment?.fullLink ?? ''));
        }
        attachmentsCubit.update(data: attachments);

        // vendorCubit.update(data: VendorModel.fromJson(jsonDecode(success)));
      }, (error) {
        showErrorMessage(message: error.message);
      });
    } catch (error) {}
  }
}
