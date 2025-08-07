import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/products_cubit/products_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/models/offers/add_offer_model.dart';
import 'package:sislimoda_admin_dashboard/models/offers/get_offers_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class AddOffer extends StatefulWidget {
  const AddOffer(
      {super.key,
      required this.operationType,
      required this.products,
      required this.reload,
      this.offer});
  final OperationType operationType;
  final List<ProductModel> products;
  final Function reload;
  final OfferModel? offer;
  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  Loading loading = Loading();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController descEnController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  List<ValueItem> selectedProducts = [];
  GenericCubit<String> imageCubit = GenericCubit<String>();
  XFile? selectedImage;
  List<Item> offerType = [
    Item(key: '1', value: 'Banner'),
    Item(key: '2', value: 'Products'),
    Item(key: '3', value: 'Products with bold header'),
    Item(key: '4', value: 'general'),
  ];
  String selectedOfferType = '';
  String selectedCategoryId = '';
  @override
  void initState() {
    // TODO: implement initState
    imageCubit.update(data: '');

    if (widget.operationType == OperationType.update) {
      nameController.text = widget.offer?.title ?? '';
      nameEnController.text = widget.offer?.titleEn ?? '';
      descController.text = widget.offer?.description ?? '';
      descEnController.text = widget.offer?.descriptionEn ?? '';
      dateController.text = DateFormat('dd/MM/yyyy')
          .format(DateFormat('dd-MM-yyyy').parse(widget.offer?.endDate ?? ''));
      // durationController.text =
      //     '${widget.offer?.duration ?? ''} ${LocaleKeys.day.tr()}';
      discountController.text = widget.offer?.percent ?? '';
      print(
          ' widget.offer!.offersProducts ${widget.offer!.offersProducts?.length}');
      for (var element in widget.offer!.offersProducts!) {
        selectedProducts.add(ValueItem(
            value: element?.id ?? '',
            label: isArabic
                ? (element?.product?.name ?? 'aaa')
                : (element?.product?.nameEn ?? 'aas')));
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
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                width: context.isMobile ? 0.10.sw : 800,
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 28, right: 28),
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
                                  ? LocaleKeys.addOffer.tr()
                                  : LocaleKeys.updateOffer.tr(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                // hintText: 'مثال : العناية بالبشرة',
                                labelText: LocaleKeys.name.tr(),
                                controller: nameController,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                // hintText: 'مثال : العناية بالبشرة',
                                labelText: '${LocaleKeys.name.tr()}(EN)',
                                controller: nameEnController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                labelText: LocaleKeys.description.tr(),
                                maxlines: 1,
                                controller: descController,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),Expanded(
  flex: context.isMobile ? 3 : 4,
  child: GestureDetector(
    onTap: () async {
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          // لو عندك تخصيص للتصميم
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Colors.white,
              // أضف تعديلات أخرى حسب الحاجة
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        final formatted =
            "${DateFormat('yyyy/MM/dd').format(picked.start)} - ${DateFormat('yyyy/MM/dd').format(picked.end)}";
        setState(() {
          dateController.text = formatted;
        });
      }
    },
    child: CustomTextField(
      controller: dateController,
      onTap: () {}, // فارغة لتمنع الفتح مرتين
      enabled: false,
      hintText: LocaleKeys.selectDate.tr(),
      labelText: LocaleKeys.orderDate.tr(),
      iconData: AppImages.calendar,
    ),
  ),
),

                        //     Expanded(
                        //       child: CustomTextField(
                        //         onTap: () {},
                        //         labelText: '${LocaleKeys.description.tr()}(EN)',
                        //         maxlines: 1,
                        //         controller: descEnController,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Expanded(
                        //         flex: context.isMobile ? 3 : 4,
                        //         child: GestureDetector(
                        //           onTap: () {
                        //             showDateRangePickerDialog(
                        //                 offset: context.isMobile
                        //                     ? Offset(30, 200)
                        //                     : Offset(.5.sw - 250, 200),
                        //                 context: context,
                        //                 builder: datePickerBuilder);
                        //           },
                        //           child: CustomTextField(
                        //             controller: dateController,
                        //             onTap: () {},
                        //             enabled: false,
                        //             hintText: LocaleKeys.selectDate.tr(),
                        //             labelText: LocaleKeys.orderDate.tr(),
                        //             iconData: AppImages.calendar,
                        //           ),
                        //         )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomTextField(
                                onTap: () {},
                                enabled: false,
                                controller: durationController,
                                hintText: '0  ${LocaleKeys.day.tr()}',
                                labelText: LocaleKeys.duration.tr(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomTextField(
                                onTap: () {},
                                enabled: true,
                                hintText: '0',
                                formatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  NumberRangeTextInputFormatter(
                                      min: 1, max: 100),
                                ],
                                controller: discountController,
                                labelText: LocaleKeys.discount.tr(),
                                iconData: AppImages.percentage,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  onTap: () {},
                                  enabled: true,
                                  controller: codeController,
                                  hintText: 'csdzxd',
                                  labelText: isArabic ? 'الكود' : 'Code'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomMultiSelect(
                                isSingle: true,
                                hint: isArabic
                                    ? 'الرجاو إختيار نوع العرض'
                                    : 'Select offer type',
                                onChange: (List<ValueItem> items) {
                                  if (items.isEmpty) {
                                    selectedOfferType = '';
                                    return;
                                  }
                                  selectedOfferType = items.first.value;
                                },
                                items: offerType
                                    .map((Item item) => ValueItem(
                                        label: (item.value ?? ''),
                                        value: item.key))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            BlocBuilder<CategoriesCubit, CategoriesState>(
                              builder: (context, state) {
                                if (state is CategoriesLoaded) {
                                  return Expanded(
                                    flex: 1,
                                    child: CustomMultiSelect(
                                      isSingle: true,
                                      hint: LocaleKeys.selectCategory.tr(),
                                      onChange: (List<ValueItem> items) {
                                        if (items.isNotEmpty) {
                                          selectedCategoryId =
                                              items.first.value;
                                        } else {
                                          selectedCategoryId = '';
                                        }
                                      },
                                      items: state.categories
                                          .map((CategoryModel product) =>
                                              ValueItem(
                                                  label: isArabic
                                                      ? (product.name ?? '')
                                                      : (product.nameEn ?? ''),
                                                  value: product.id))
                                          .toList(),
                                    ),
                                  );
                                }

                                return SizedBox();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            BlocBuilder<ProductsCubit, ProductsState>(
                              builder: (context, state) {
                                if (state is ProductsLoaded) {
                                  List<ValueItem> products = state.products
                                      .map((ProductModel product) => ValueItem(
                                          label: isArabic
                                              ? (product.name ?? '')
                                              : (product.nameEn ?? ''),
                                          value: product.id))
                                      .toList();

                                  print(
                                      'selected products ${selectedProducts}');

                                  return Expanded(
                                    flex: 3,
                                    child: CustomMultiSelect(
                                      selectedItems: selectedProducts,
                                      hint: LocaleKeys.selectProducts.tr(),
                                      onChange: (List<ValueItem> items) {
                                        selectedProducts = items;
                                      },
                                      items: products,
                                    ),
                                  );
                                }

                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 205,
                              height: 50,
                              child: AppButton(
                                onPress:
                                    widget.operationType == OperationType.add
                                        ? addOffer
                                        : updateOffer,
                                title: widget.operationType == OperationType.add
                                    ? LocaleKeys.addOffer.tr()
                                    : LocaleKeys.updateOffer.tr(),
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

  addOffer() async {
    if (selectedProducts.isEmpty) {
      showErrorMessage(message: LocaleKeys.mustAddProductsToOffer.tr());
    }
    if (formKey.currentState!.validate() && selectedProducts.isNotEmpty) {
      loading.show;
      String imageId = '';
      final bytes = await selectedImage?.readAsBytes();
      String img64 = base64Encode(bytes!.toList());

      await context.uploadAttachment(
          img64: img64,
          imageName: selectedImage?.name ?? '',
          afterUpload: (selectedId) async {
            await Future.delayed(Duration(milliseconds: 200));
            try {
              AddOfferModel addOffer = AddOfferModel(
                  title: nameController.text,
                  titleEn: nameEnController.text,
                  description: descController.text,
                  descriptionEn: descEnController.text,
                  percent: discountController.text,
                  amount: discountController.text,
                  code: codeController.text,
                  offerType: selectedOfferType,
                  photoId: selectedId,
                  offerCategoryId: selectedCategoryId,
                  endDate: DateFormat('MM/dd/yyyy').format(endTime),
                  isActive: true,
                  isForVendor: false,
                  offersProducts: selectedProducts
                      .map((element) =>
                          AddOfferModelOffersProducts(productId: element.value))
                      .toList(),
                  mustExceed: '1');
              Navigator.pop(context);

              var result = await AppService.callService(
                  actionType: ActionType.post,
                  apiName: 'api/Offers/Add',
                  body: addOffer.toJson());

              result.fold((success) {
                widget.reload();
                Navigator.pop(context);
                showSuccessMessage(
                    message: LocaleKeys.offerAddedSuccessfully.tr());
              }, (error) {
                showErrorMessage(message: error.message);
              });
            } catch (error) {}
          });

      loading.hide;
    }
  }

  updateOffer() async {
    if (selectedProducts.isEmpty) {
      showErrorMessage(message: LocaleKeys.mustAddProductsToOffer.tr());
    }
    if (formKey.currentState!.validate() && selectedProducts.isNotEmpty) {
      loading.show;

      // try {
      //   AddOfferModel addOffer = AddOfferModel(
      //     name: nameController.text,
      //     description: descController.text,
      //     amount: discountController.text,
      //     duration: int.parse(durationController.text.split(' ').first),
      //     expire: DateFormat('MM/dd/yyyy').format(endTime),
      //   );
      //   var result = await AppService.callService(
      //       actionType: ActionType.put,
      //       apiName: 'offer/${widget.offer?.id}',
      //       body: addOffer.toJson());
      //
      //   result.fold((success) {
      //     widget.reload();
      //     Navigator.pop(context);
      //     showSuccessMessage(message: LocaleKeys.offerUpdatedSuccessfully.tr());
      //   }, (error) {
      //     showErrorMessage(message: error.message);
      //   });
      // } catch (error) {}
      loading.hide;
    }
  }

  Widget datePickerBuilder(BuildContext context,
          dynamic Function(DateRange) onDateRangeChanged) =>
      DateRangePickerWidget(
        doubleMonth: true,
        theme: CalendarTheme(
          selectedColor: AppColors.mainColor,
          dayNameTextStyle: TextStyle(color: Colors.black45, fontSize: 10),
          inRangeColor: AppColors.mainColor.withOpacity(.2),
          inRangeTextStyle: TextStyle(color: Colors.black),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
          defaultTextStyle: TextStyle(color: Colors.black, fontSize: 12),
          radius: 10,
          tileSize: context.isMobile ? 22.w : 40,
          disabledTextStyle: TextStyle(color: Colors.grey),
        ),
        initialDateRange:
            DateRange(DateTime.now(), DateTime.now().add(Duration(hours: 365))),
        onDateRangeChanged: (dateRange) {
          print(dateRange);
          startTime = dateRange?.start ?? DateTime.now();
          endTime = dateRange?.end ?? DateTime.now();
          dateController.text = dateRange.toString();
          durationController.text =
              '${endTime.difference(startTime).inDays.toString()} ${LocaleKeys.day.tr()}';
          setState(() {});
        },
      );
}

class NumberRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumberRangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}
