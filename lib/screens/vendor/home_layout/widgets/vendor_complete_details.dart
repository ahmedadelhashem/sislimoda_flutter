import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/add_notification.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class VendorCompleteDetails extends StatefulWidget {
  const VendorCompleteDetails({super.key});

  @override
  State<VendorCompleteDetails> createState() => _VendorCompleteDetailsState();
}

class _VendorCompleteDetailsState extends State<VendorCompleteDetails> {
  GenericCubit<List<ProductModelProductImages?>> onlineImagesCubit =
      GenericCubit<List<ProductModelProductImages?>>();

  GenericCubit<List<XFile>> imagesCubit = GenericCubit<List<XFile>>();

  @override
  void initState() {
    // TODO: implement initState
    imagesCubit.update(data: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 107.w, right: 59.w, bottom: 100),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الرجاء ملئ البيانات التالية والتأكد من صحتها',
                  style: AppFonts.apptextStyle.copyWith(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              isArabic
                  ? 'هل انت متجر ام شركة مصنعة للمنتجات التي سوف تعرضها'
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
                width: 250,
                child: CustomMultiSelect(
                    isSingle: true,
                    hint: isArabic ? 'حدد نوع الشركة' : 'Select company type',
                    items: [
                      ValueItem(value: '1', label: isArabic ? 'متجر' : "Store"),
                      ValueItem(
                          value: '2', label: isArabic ? 'شركة' : "Company"),
                      ValueItem(
                          value: '3',
                          label:
                              isArabic ? 'وسيط / موزع' : "Broker/Distributor"),
                    ],
                    onChange: (value) {})),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              labelText: isArabic ? 'اسم الشركة ' : ' Company name',
              maxlines: 1,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              labelText: isArabic ? 'العنوان بالكامل' : 'Full address',
              maxlines: 3,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              labelText: isArabic
                  ? 'عدد المنتجات التي ترغب بعرضها'
                  : 'Number of products you wish to display',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              isArabic
                  ? 'ما هو قطاع الاعمال الذي تعمل به'
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
                    hint: isArabic ? 'حدد نوع العمل' : 'Select Business type',
                    items: [
                      ValueItem(
                          value: '1', label: isArabic ? 'ملابس' : "clothes"),
                      ValueItem(
                          value: '2', label: isArabic ? 'العاب' : "Games"),
                      ValueItem(
                          value: '3', label: isArabic ? 'اطفال' : "Children"),
                      ValueItem(
                          value: '4',
                          label: isArabic ? 'ادوات تجميل' : "makeup"),
                    ],
                    onChange: (value) {})),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              labelText: LocaleKeys.mobileNumber.tr(),
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textFieldValidType: TextFieldvalidatorType.phoneNumber,
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              labelText: isArabic ? 'الحساب البنكي' : "bank account",
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              labelText: 'Iban',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onTap: () {},
              labelText: isArabic ? 'اسم البنك' : "bank name",
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
                          imagesCubit.state.data?.add(value);
                          imagesCubit.update(data: imagesCubit.state.data!);
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
                    )),
                GenericBuilder<List<XFile>>(
                    genericCubit: imagesCubit,
                    builder: (images) {
                      return Expanded(
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: images
                              .map((e) => Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              e.path,
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 10,
                                        top: 10),
                                    width: 130,
                                    height: 160,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              images.remove(e);
                                              imagesCubit.update(data: images);
                                            },
                                            icon: CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.close,
                                                  size: 13,
                                                  color: Colors.red,
                                                )))
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    })
              ],
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
