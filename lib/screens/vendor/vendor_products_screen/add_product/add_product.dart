import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/brands/brand_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/offers/widgets/add_offer.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/indication_for_use.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_products_screen/add_product/add_product_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class AddProduct extends StatefulWidget {
  const AddProduct(
      {super.key,
      required this.isAddProductsCubit,
      required this.isUpdate,
      required this.productModel});
  final GenericCubit<bool> isAddProductsCubit;
  final bool isUpdate;
  final ProductModel productModel;
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with AddProductData {
  final ScrollController _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  void _handleKeyEvent(KeyEvent event) {
    const scrollAmount = 50.0;

    if (event.logicalKey == LogicalKeyboardKey.keyW ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _controller.animateTo(
        _controller.offset - scrollAmount,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else if (event.logicalKey == LogicalKeyboardKey.keyS ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _controller.animateTo(
        _controller.offset + scrollAmount,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initData(isEdit: widget.isUpdate, product: widget.productModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Screen(
        loadingCubit: loading,
        child: Container(
          padding: const EdgeInsets.only(left: 34, right: 34, top: 20),
          width: double.infinity,
          height: 1.sh,
          child: SingleChildScrollView(
            controller: _controller,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.addProduct.tr(),
                            style: AppFonts.apptextStyle.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: AppButton(
                          onPress: () {
                            context.router.push(VendorMessagesRoute());
                          },
                          title: isArabic ? 'طلب المساعدة' : "need help",
                          titleFontColor: Colors.white,
                          titleFontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 43.h,
                  ),
                  Text(
                    LocaleKeys.categoryAndBrandDetails.tr(),
                    style: AppFonts.apptextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    // height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.categoryName.tr(),
                                style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 15,
                                    color: AppColors.borderColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              BlocBuilder<CategoriesCubit, CategoriesState>(
                                  builder: (context, state) {
                                if (state is CategoriesLoaded) {
                                  List<ValueItem> items = state.categories
                                      .map((e) => ValueItem(
                                          label: isArabic
                                              ? e.name ?? ""
                                              : e.nameEn ?? '',
                                          value: e.id))
                                      .toList();
                                  return CustomMultiSelect(
                                    isSingle: true,
                                    hint: LocaleKeys.selectCategory.tr(),
                                    onChange: (List<ValueItem> items) {
                                      if (items.isNotEmpty) {
                                        selectedCategory = items.first;
                                        getSubCategories(
                                            categoryId:
                                                selectedCategory?.value);
                                      } else {
                                        selectedCategory = null;
                                      }
                                    },
                                    selectedItems:
                                        selectedCategory?.value != null
                                            ? [
                                                items.firstWhere((element) =>
                                                    element.value ==
                                                    selectedCategory?.value)
                                              ]
                                            : [],
                                    items: items,
                                  );
                                }
                                return SizedBox();
                              }),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GenericBuilder(
                            genericCubit: subCategoryCubit,
                            builder: (subCategories) {
                              List<ValueItem> items = subCategories
                                  .map((e) => ValueItem(
                                      label: isArabic
                                          ? e.name ?? ""
                                          : e.nameEn ?? '',
                                      value: e.id))
                                  .toList();
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.subCategoryName.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 15,
                                          color: AppColors.borderColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomMultiSelect(
                                      key: GlobalKey(),
                                      isSingle: true,
                                      hint: LocaleKeys.selectCategory.tr(),
                                      onChange: (List<ValueItem> items) {
                                        if (items.isNotEmpty) {
                                          getSubSubCategories(
                                              categoryId: items.first.value);
                                          selectedSubCategory = items.first;
                                        } else {
                                          selectedSubCategory = null;
                                        }
                                      },
                                      items: items,
                                      selectedItems:
                                          selectedSubCategory?.value != null
                                              ? [
                                                  items.firstWhere((element) =>
                                                      element.value ==
                                                      selectedSubCategory
                                                          ?.value)
                                                ]
                                              : [],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        GenericBuilder(
                            genericCubit: subSubCategoryCubit,
                            builder: (subSubCategories) {
                              List<ValueItem> items = subSubCategories
                                  .map((e) => ValueItem(
                                      label: isArabic
                                          ? e.name ?? ""
                                          : e.nameEn ?? '',
                                      value: e.id))
                                  .toList();
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.subCategoryName.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 15,
                                          color: AppColors.borderColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomMultiSelect(
                                      key: GlobalKey(),
                                      isSingle: true,
                                      hint: LocaleKeys.selectCategory.tr(),
                                      onChange: (List<ValueItem> items) {
                                        if (items.isNotEmpty) {
                                          selectedSubSubCategory = items.first;
                                          getAllOptions();
                                        } else {
                                          selectedSubSubCategory = null;
                                        }
                                      },
                                      items: items,
                                      selectedItems:
                                          selectedSubSubCategory?.value != null
                                              ? [
                                                  items.firstWhere((element) =>
                                                      element.value ==
                                                      selectedSubSubCategory
                                                          ?.value)
                                                ]
                                              : [],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              );
                            }),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        // Expanded(
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         LocaleKeys.brands.tr(),
                        //         style: AppFonts.apptextStyle.copyWith(
                        //             fontSize: 15,
                        //             color: AppColors.borderColor,
                        //             fontWeight: FontWeight.w700),
                        //       ),
                        //       const SizedBox(
                        //         height: 16,
                        //       ),
                        //       GenericBuilder<List<BrandModel>>(
                        //           genericCubit: brandsCubit,
                        //           builder: (brandsC) {
                        //             return CustomMultiSelect(
                        //               isSingle: true,
                        //               hint: LocaleKeys.selectBrands.tr(),
                        //               onChange: (List<ValueItem> items) {
                        //                 if (items.isNotEmpty) {
                        //                   selectedBrand = items.first;
                        //                 } else {
                        //                   selectedBrand = null;
                        //                 }
                        //               },
                        //               items: brandsC
                        //                   .map((BrandModel brand) => ValueItem(
                        //                       label: isArabic
                        //                           ? (brand.name ?? '')
                        //                           : (brand.nameEn ?? ''),
                        //                       value: brand.id))
                        //                   .toList(),
                        //             );
                        //           }),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    LocaleKeys.productImages.tr(),
                    style: AppFonts.apptextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? 'اضف صورة العرض الرئيسية'
                              : 'Add main display image',
                          style:
                              AppFonts.apptextStyle.copyWith(fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  UploadImageController.getFormDataImage()
                                      .then((value) async {
                                    if (value != null) {
                                      defaultImagesCubit.update(data: value);
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
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 40,
                                          top: 40),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
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
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            GenericBuilder<XFile>(
                                genericCubit: defaultImagesCubit,
                                builder: (images) {
                                  return images.path.isNotEmpty
                                      ? Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              // image: DecorationImage(
                                              //     image: NetworkImage(
                                              //       images.path,
                                              //     ),
                                              //     fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          margin: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 10,
                                              top: 10),
                                          width: 130,
                                          height: 160,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: 130,
                                                height: 160,
                                                child: CustomNetworkImage(
                                                    link: images.path,
                                                    height: 160,
                                                    fit: BoxFit.cover,
                                                    width: 130),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    defaultImagesCubit.update(
                                                        data: XFile(''));
                                                  },
                                                  icon: CircleAvatar(
                                                      radius: 17,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 13,
                                                        color: Colors.red,
                                                      ))),
                                            ],
                                          ),
                                        )
                                      : SizedBox();
                                })
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          isArabic ? ' تفاصيل صور اكثر' : 'More photo details',
                          style:
                              AppFonts.apptextStyle.copyWith(fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  UploadImageController.getFormDataImage()
                                      .then((value) async {
                                    if (value != null) {
                                      imagesCubit.state.data?.add(value);
                                      imagesCubit.update(
                                          data: imagesCubit.state.data!);
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
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 40,
                                          top: 40),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
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
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
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
                                                        BorderRadius.circular(
                                                            16)),
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
                                                          imagesCubit.update(
                                                              data: images);
                                                        },
                                                        icon: CircleAvatar(
                                                            radius: 17,
                                                            backgroundColor:
                                                                Colors.white,
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
                        SizedBox(
                          height: 15,
                        ),
                        GenericBuilder(
                            builder: (onlineImages) {
                              return Wrap(
                                direction: Axis.horizontal,
                                children: onlineImages
                                    .map((e) => Stack(
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 150,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: CustomNetworkImage(
                                                  link:
                                                      e?.photo?.fullLink ?? '',
                                                  height: 150,
                                                  width: 150),
                                            ),
                                            Positioned(
                                              right: 20,
                                              top: 10,
                                              child: InkWell(
                                                onTap: () {
                                                  onlineImages.remove(e);
                                                  onlineImagesCubit.update(
                                                      data: onlineImages);
                                                  removeImageFromProduct(
                                                      imagesId: e?.id ?? '');
                                                },
                                                child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                    .toList(),
                              );
                            },
                            genericCubit: onlineImagesCubit),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          isArabic
                              ? 'اضف صور المنتج / يجب مراعاه حجم الصور ليكون 500 طول * 350 عرض ومضاعفاتها'
                              : 'Add the logo / The logo size must be 300 length * 500 width and multiples thereof',
                          style:
                              AppFonts.apptextStyle.copyWith(fontSize: 12.sp),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Text(
                        //   isArabic
                        //       ? 'يجب وضع مقاسات المنتج وحجمة بالصورة او في خانة وصف المنتج'
                        //       : 'Product dimensions and sizes must be included in the image or in the product description box.',
                        //   style:
                        //       AppFonts.apptextStyle.copyWith(fontSize: 12.sp),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    LocaleKeys.productDetails.tr(),
                    style: AppFonts.apptextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Column(
                      children: [
                        CustomTextField(
                          onTap: () {},
                          labelText: LocaleKeys.productNameArabic.tr(),
                          hintText: 'مثال : شامبو',
                          controller: arabicNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          onTap: () {},
                          labelText: LocaleKeys.productEnglishName.tr(),
                          hintText: 'Example : shampo',
                          controller: englishNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          onTap: () {},
                          maxlines: 4,
                          labelText: LocaleKeys.descriptionArabic.tr(),
                          hintText:
                              'اذكر مواصفات المنتج وطريقة العناية به وكيفية استخدامة',
                          controller: arabicDescriptionController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          onTap: () {},
                          maxlines: 4,
                          labelText: LocaleKeys.descriptionEnglish.tr(),
                          hintText:
                              'Mention the product specifications, care instructions, and how to use it.',
                          controller: englishDescriptionController,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GenericBuilder(
                      genericCubit: optionsCubit,
                      builder: (options) {
                        List<ProductModelProductOptionsOption> colors = [];
                        List<ProductModelProductOptionsOption> sizes = [];
                        List<ProductModelProductOptionsOption> selectedOptions =
                            [];

                        selectedOptionsCubit.update(data: selectedOptions);

                        List<ProductModelProductOptionsOption> otherOptions =
                            [];
                        for (var element in options) {
                          if (element.groupKey == 'Color') {
                            colors.add(element);
                          } else if (element.groupKey == 'Size') {
                            sizes.add(element);
                          } else {
                            otherOptions.add(element);
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic
                                  ? 'الالوان والمقاسات المتوفرة والخيارات الاخري'
                                  : "Available colors, sizes and other options",
                              style: AppFonts.apptextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (colors.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'إختر اللون'
                                              : "Select Color",
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp),
                                        ),
                                      if (colors.isNotEmpty)
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      if (colors.isNotEmpty)
                                        GenericBuilder(
                                            genericCubit: selectedOptionsCubit,
                                            builder: (selectedOptions) {
                                              return Container(
                                                  height: 45.h,
                                                  child: ListView.separated(
                                                    itemCount: colors.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        width: 13.w,
                                                      );
                                                    },
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (selectedOptions
                                                              .contains(colors[
                                                                  index])) {
                                                            selectedOptions
                                                                .remove(colors[
                                                                    index]);
                                                            selectedOptionsCubit
                                                                .update(
                                                                    data:
                                                                        selectedOptions);
                                                          } else {
                                                            selectedOptions.add(
                                                                colors[index]);
                                                            selectedOptionsCubit
                                                                .update(
                                                                    data:
                                                                        selectedOptions);
                                                          }
                                                        },
                                                        child: Container(
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth:
                                                                      45.h),
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey),
                                                                BoxShadow(
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        4,
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            .4))
                                                              ],
                                                              color: Color(
                                                                  int.parse(
                                                                      '0xff${colors[index].other?.substring(1)}')),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          250.r)),
                                                          child: selectedOptions
                                                                  .contains(
                                                                      colors[
                                                                          index])
                                                              ? Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(250
                                                                              .r),
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color:
                                                                              Color(int.parse('0xff${colors[index].other?.substring(1) == 'ffffff' ? 'ED0022' : colors[index].other?.substring(1)}')))),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          int.parse(
                                                                              '0xff${colors[index].other?.substring(1)}')),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              250.r),
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                        ),
                                                      );
                                                    },
                                                  ));
                                            }),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      if (sizes.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'إختر الحجم'
                                              : "Select Size",
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp),
                                        ),
                                      if (sizes.isNotEmpty)
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      if (sizes.isNotEmpty)
                                        GenericBuilder(
                                            genericCubit: selectedOptionsCubit,
                                            builder: (selectedOptions) {
                                              return SizedBox(
                                                  height: 45.h,
                                                  child: ListView.separated(
                                                    itemCount: sizes.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        width: 13.w,
                                                      );
                                                    },
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (selectedOptions
                                                              .contains(sizes[
                                                                  index])) {
                                                            selectedOptions
                                                                .remove(sizes[
                                                                    index]);
                                                          } else {
                                                            selectedOptions.add(
                                                                sizes[index]);
                                                          }

                                                          selectedOptionsCubit
                                                              .update(
                                                                  data:
                                                                      selectedOptions);
                                                        },
                                                        child: Container(
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth:
                                                                      45.h),
                                                          decoration: BoxDecoration(
                                                              color: selectedOptions
                                                                      .contains(
                                                                          sizes[
                                                                              index])
                                                                  ? Color(
                                                                      0xff010101)
                                                                  : Color(0xff010101)
                                                                      .withOpacity(
                                                                          .05),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          250.r)),
                                                          child: Center(
                                                              child: Text(
                                                            sizes[index].nameEn?[
                                                                    0] ??
                                                                '',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 16.sp,
                                                                color: !selectedOptions
                                                                        .contains(sizes[
                                                                            index])
                                                                    ? Color(
                                                                        0xff010101)
                                                                    : Colors
                                                                        .white),
                                                          )),
                                                        ),
                                                      );
                                                    },
                                                  ));
                                            }),
                                      if (otherOptions.isNotEmpty)
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      if (otherOptions.isNotEmpty)
                                        Text(
                                          LocaleKeys.productOptions.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 15,
                                              color: AppColors.borderColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      if (otherOptions.isNotEmpty)
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      if (otherOptions.isNotEmpty)
                                        GenericBuilder(
                                            genericCubit: selectedOptionsCubit,
                                            builder: (selectedOptions) {
                                              return SizedBox(
                                                  height: 45.h,
                                                  child: ListView.separated(
                                                    itemCount:
                                                        otherOptions.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        width: 13.w,
                                                      );
                                                    },
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (selectedOptions
                                                              .contains(
                                                                  otherOptions[
                                                                      index])) {
                                                            selectedOptions
                                                                .remove(
                                                                    otherOptions[
                                                                        index]);
                                                          } else {
                                                            selectedOptions.add(
                                                                otherOptions[
                                                                    index]);
                                                          }

                                                          selectedOptionsCubit
                                                              .update(
                                                                  data:
                                                                      selectedOptions);
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth:
                                                                      45.h),
                                                          decoration: BoxDecoration(
                                                              color: selectedOptions
                                                                      .contains(
                                                                          otherOptions[
                                                                              index])
                                                                  ? Color(
                                                                      0xff010101)
                                                                  : Color(0xff010101)
                                                                      .withOpacity(
                                                                          .05),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r)),
                                                          child: Center(
                                                              child: Text(
                                                            otherOptions[index]
                                                                    .nameEn ??
                                                                '',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 16.sp,
                                                                color: !selectedOptions.contains(
                                                                        otherOptions[
                                                                            index])
                                                                    ? Color(
                                                                        0xff010101)
                                                                    : Colors
                                                                        .white),
                                                          )),
                                                        ),
                                                      );
                                                    },
                                                  ));
                                            }),
                                      // const SizedBox(
                                      //   height: 16,
                                      // ),
                                      // SizedBox(
                                      //   height: 50,
                                      //   width: 1.sw,
                                      //   child: CustomMultiSelect(
                                      //     key: GlobalKey(),
                                      //     selectedItems: tempSelectedOptions
                                      //         .map((element) => ValueItem(
                                      //             label: isArabic
                                      //                 ? element.name ?? ''
                                      //                 : element.nameEn ?? '',
                                      //             value: element.id))
                                      //         .toList(),
                                      //     hint: LocaleKeys.productOptions.tr(),
                                      //     onChange: (List<ValueItem> items) {
                                      //       if (items.isNotEmpty) {
                                      //         selectedOptions = [];
                                      //         items.forEach((element) {
                                      //           selectedOptions
                                      //               .add(element.value);
                                      //         });
                                      //       } else {
                                      //         selectedOptions = [];
                                      //       }
                                      //     },
                                      //     items: options
                                      //         .map((e) => ValueItem(
                                      //             label: isArabic
                                      //                 ? e.name ?? ""
                                      //                 : e.nameEn ?? '',
                                      //             value: e.id))
                                      //         .toList(),
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 16,
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      }),
                  Text(
                    isArabic
                        ? "عدد المتوفر لديك في المخزن / المستودع من هذا المنتج"
                        : "How many of this product do you have in stock/warehouse?",
                    style: AppFonts.apptextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                controller: stockController,
                                labelText: LocaleKeys.productAmount.tr(),
                                hintText: 'مثال : 34',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomTextField(
                                onTap: () {},
                                controller: suggestedPriceController,
                                labelText: isArabic
                                    ? "اقل عدد من المنتج للمخزون"
                                    : "minimum stock of product",
                                hintText: 'مثال : 34',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          isArabic
                              ? 'في حالة لم تلتزم بتوفير المنتج بعد دفع العميل للأموال سوف يتم خصم 30% من قيمة المنتج لصالح النظام'
                              : 'If you do not commit to providing the product after the customer pays the money, 30% of the product value will be deducted in favor of the system.',
                          style:
                              AppFonts.apptextStyle.copyWith(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    LocaleKeys.price.tr(),
                    style: AppFonts.apptextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Column(
                      children: [
                        CustomTextField(
                          onTap: () {},
                          labelText: LocaleKeys.price.tr(),
                          controller: priceController,
                          formatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            NumberRangeTextInputFormatter(min: 1, max: 1000000),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // CustomTextField(
                        //   onTap: () {},
                        //   labelText: isArabic
                        //       ? "السعر المقترح للبيع"
                        //       : "Suggested price",
                        //   controller: suggestedPriceController,
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        // CustomTextField(
                        //   onTap: () {},
                        //   controller: noteForReturnController,
                        //   labelText: LocaleKeys.noteForReturn.tr(),
                        //   hintText: '',
                        //   maxlines: 4,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              LocaleKeys.productDetails.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  fontSize: 16,
                                  color: AppColors.borderColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: addIndicationForuse,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.mainColor, width: 2),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GenericBuilder<List<ProductDetails>>(
                            builder: (indicationsForuse) {
                              return Column(
                                children: [
                                  IndicationForUse(
                                    indicationsForuse: indicationsForuse,
                                  ),
                                  Divider()
                                ],
                              );
                            },
                            genericCubit: productDetailsCubit),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    isArabic ? "ملاحظات" : "notes",
                    style: AppFonts.apptextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? '1-  تابع جميع الطلبات من العملاء في خانة استلام طلبات العملاء في الصفحة الرئيسية'
                              : "1- Track all customer requests in the Customer Requests section on the home page.",
                          style:
                              AppFonts.apptextStyle.copyWith(fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Text(
                        //   isArabic
                        //       ? '2-  في حال وصل المخزون لهذا المنتج لاقل من 50 اختر نفذت من خانة المخزون في الصفحة الرئيسية'
                        //       : "2- If the stock for this product reaches less than 50, select “Out of Stock” from the stock box on the home page.",
                        //   style:
                        //       AppFonts.apptextStyle.copyWith(fontSize: 15.sp),
                        // ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   isArabic
                  //       ? "اختر ابدا الان لنقوم بعرض المنتج"
                  //       : "Select Start Now to view the product.",
                  //   style: AppFonts.apptextStyle
                  //       .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: AppButton(
                          onPress: () =>
                              updateProduct(product: widget.productModel),
                          title: isArabic ? 'حفظ' : 'Save',
                          titleFontColor: Colors.white,
                          titleFontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: AppButton(
                          onPress: () {
                            context.router.push(VendorProductsRoute());
                          },
                          title: isArabic ? 'لاحقا' : 'later',
                          backgroundColor: AppColors.barrierColor,
                          titleFontColor: Colors.black,
                          titleFontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
