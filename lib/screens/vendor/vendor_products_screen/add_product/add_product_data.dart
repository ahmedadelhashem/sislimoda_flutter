import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/controllers/upload_image_controller.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/brands/brand_model.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/add_product_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/models/vendor_models/vendor_model.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/layout_data.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin AddProductData {
  Loading loading = Loading();
  final GenericCubit<List<ProductModelProductOptionsOption>>
      selectedOptionsCubit =
      GenericCubit<List<ProductModelProductOptionsOption>>();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController englishDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController suggestedPriceController = TextEditingController();
  TextEditingController noteForReturnController = TextEditingController();
  TextEditingController systemProfitController = TextEditingController();
  TextEditingController clientCashbackController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GenericCubit<List<CategoryModel>> categoriesCubit =
      GenericCubit<List<CategoryModel>>();
  GenericCubit<List<XFile>> imagesCubit = GenericCubit<List<XFile>>();
  GenericCubit<XFile> defaultImagesCubit = GenericCubit<XFile>();
  GenericCubit<ProductModelDefaultPhoto> onlineDefaultImagesCubit =
      GenericCubit<ProductModelDefaultPhoto>();
  GenericCubit<List<ProductModelProductImages?>> onlineImagesCubit =
      GenericCubit<List<ProductModelProductImages?>>();

  List<BrandModel> brands = [];
  ValueItem? selectedBrand;
  ValueItem? selectedCategory;
  ValueItem? selectedSubSubCategory;
  ValueItem? selectedSubCategory;
  GenericCubit<List<BrandModel>> brandsCubit = GenericCubit<List<BrandModel>>();
  List<ProductDetails> productDetails = [];
  GenericCubit<List<ProductDetails>> productDetailsCubit =
      GenericCubit<List<ProductDetails>>();

  List<CategoryModel> subCategories = [];
  GenericCubit<List<CategoryModel>> subCategoryCubit =
      GenericCubit<List<CategoryModel>>();

  List<CategoryModel> subSubCategories = [];
  GenericCubit<List<CategoryModel>> subSubCategoryCubit =
      GenericCubit<List<CategoryModel>>();

  List<ProductModelProductOptionsOption> tempSelectedOptions = [];

  initData({required bool isEdit, required ProductModel product}) async {
    stockController.text = '50';
    imagesCubit.update(data: []);
    defaultImagesCubit.update(
        data: XFile(product.defaultPhoto?.fullLink ?? ''));
    productDetailsCubit.update(data: []);
    await getBrands();

    if (isEdit) {
      arabicNameController.text = product.name ?? "";
      englishNameController.text = product.nameEn ?? "";
      arabicDescriptionController.text = product.description ?? "";
      englishDescriptionController.text = product.descriptionEn ?? "";
      onlineImagesCubit.update(data: product.productImages ?? []);
      onlineDefaultImagesCubit.update(
          data: product.defaultPhoto ?? ProductModelDefaultPhoto());
      priceController.text = product.defaultPrice ?? '';
      stockController.text = product.totalProductStock ?? '';
      suggestedPriceController.text =
          product.suggestedSalePriceFromVendor ?? '';
      noteForReturnController.text = product.noteForReturn ?? '';
      productDetails = product.productDetails!
          .map((element) => ProductDetails(
              icon: element?.id,
              value: element?.value ?? '',
              key: element?.key,
              keyEn: element?.keyEn,
              valueEn: element?.valueEn))
          .toList();
      productDetailsCubit.update(data: productDetails);
      if (product.mainCategoryId != null) {
        getSubCategories(categoryId: product.mainCategoryId ?? '');
        selectedCategory = ValueItem(label: '', value: product.mainCategoryId);
      }
      if (product.subCategoryId != null) {
        getSubSubCategories(categoryId: product.subCategoryId ?? '');
        selectedSubCategory =
            ValueItem(label: '', value: product.subCategoryId);
      }
      selectedBrand = ValueItem(label: '', value: product.brandId);
      selectedSubSubCategory = ValueItem(label: '', value: product.categoryId);
      selectedOptions = product.productOptions!.map((element) {
        tempSelectedOptions.add(
          ProductModelProductOptionsOption(
              name: element?.option?.name ?? '',
              nameEn: element?.option?.nameEn,
              id: element?.optionId,
              optionType: element?.option?.optionType,
              other: element?.option?.other),
        );
        return element?.optionId ?? '';
      }).toList();
    }
    // await getAllOptions();
  }

  initDataAdd() async {
    stockController.text = '50';

    imagesCubit.update(data: []);
    productDetailsCubit.update(data: []);
    await getBrands();
  }

  addProduct() async {
    if (checkIfProfileNotCompleted(
        vendor: vendorCubit.state.data ?? VendorModel())) {
      showErrorMessage(
          message: isArabic
              ? 'لا يمكنك إضافة المنتج إلا بعد إكمال ملفك الشخصي'
              : "You can not add product unless you complete your profile");
      return;
    }
    if (imagesCubit.state.data?.isEmpty ?? true) {
      showErrorMessage(
          message: isArabic ? "الرجاء إضافة صور" : "please add images");
      return;
    }

    if (defaultImagesCubit.state.data?.path.isEmpty ?? true) {
      showErrorMessage(
          message: isArabic
              ? "الرجاء إضافة صورة صورة اساسية"
              : "please add default image ");
      return;
    }

    if (formKey.currentState!.validate()) {
      loading.show;
      List<String> imageIds = [];
      try {
        for (var element in imagesCubit.state.data!) {
          final bytes = await element.readAsBytes();
          String img64 = base64Encode(bytes.toList());
          await currentContext.uploadAttachment(
              img64: img64,
              imageName: element.name ?? '',
              afterUpload: (selectedId) async {
                imageIds.add(selectedId);
              });
        }
        await Future.delayed(Duration(milliseconds: 300));
        final bytes = await defaultImagesCubit.state.data!.readAsBytes();
        String img64 = base64Encode(bytes.toList());
        String defaultImage = '';
        await currentContext.uploadAttachment(
            img64: img64,
            imageName: defaultImagesCubit.state.data!.name ?? '',
            afterUpload: (selectedId) async {
              defaultImage = selectedId;
              imageIds.add(selectedId);
            });

        SharedPreferences ref = await SharedPreferences.getInstance();
        String? vendorId = ref.getString('vendorId');
        AddProductModel addProductModel = AddProductModel(
            name: arabicNameController.text,
            nameEn: englishNameController.text,
            description: arabicDescriptionController.text,
            descriptionEn: englishDescriptionController.text,
            isActive: vendorCubit.state.data?.vendorStatus?.value != '3'
                ? true
                : false,
            amount: stockController.text,
            brandId: true
                ? '882b0fb2-0ae8-4cb1-a7ef-08dc83899165'
                : selectedBrand?.value,
            categoryId: selectedSubSubCategory?.value,
            defaultPrice: priceController.text,
            productPrice: priceController.text,
            oldPrice: priceController.text,
            evaluationRate: '0.0',
            couponDeduction: '0.0',
            influencerValue: '0',
            influencerPercentage: '0',
            finalDisplayPrice: priceController.text,
            discountPercentage: '0',
            maxDiscountWithFamous: '0',
            maxProgramDiscountPercentage: '0',
            priceAfterProgramInfluencer: priceController.text,
            priceBeforeDiscount: priceController.text,
            priceWithInfluencer: priceController.text,
            productDiscountPercentage: '0',
            productDiscountValue: '0',
            programDiscountPercentage: '0',
            programDiscountValue: '0',
            htmlOther: '',
            htmlDescriptions: '',
            noteForReturn: true ? '' : noteForReturnController.text,
            paymentType: 'cash',
            orderNUmber: '0',
            totalProductStock: stockController.text,
            productDetails: true
                ? []
                : productDetails
                    .map((element) => AddProductModelProductDetails(
                        key: element.key,
                        value: element.value,
                        keyEn: element.keyEn,
                        valueEn: element.valueEn,
                        icon: ''))
                    .toList(),
            productOptions: selectedOptionsCubit.state.data!
                .map((element) => AddProductModelProductOptions(
                    price: '0', optionId: element.id))
                .toList(),
            vendorId: vendorId,
            subCategoryId: selectedSubCategory?.value,
            mainCategoryId: selectedCategory?.value,
            // suggestedSalePriceFromVendor: '0',
            suggestedSalePriceFromVendor: suggestedPriceController.text,
            defaultPhotoId: defaultImage,
            productImages: imageIds
                .map((e) => AddProductModelProductImages(photoId: e))
                .toList());
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Product/Add',
            body: addProductModel.toJson());
        result.fold((success) {
          imagesCubit.update(data: []);
          defaultImagesCubit.update(data: XFile(''));
          arabicNameController.clear();
          englishNameController.clear();
          arabicDescriptionController.clear();
          englishDescriptionController.clear();
          stockController.clear();
          priceController.clear();
          suggestedPriceController.clear();
          noteForReturnController.clear();
          if (vendorCubit.state.data?.vendorStatus?.value != '3') {
            showSuccessMessage(
                message: isArabic
                    ? "تم اضافة المنتج بنجاح ولكن لن يتم عرضة حتي يتم الموافقة علية من قبل الادارة"
                    : "The product has been added successfully but will not be displayed until it is approved by the administration.");
          } else {
            showSuccessMessage(message: isArabic ? 'تم ' : 'Done');
          }
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }
  }

  getBrands() async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Brand/GetAllBrand',
          body: null);
      result.fold((l) {
        brandsCubit.update(data: brandModelFromJson(l));
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }

  addIndicationForuse() {
    TextEditingController keyArabicController = TextEditingController();
    TextEditingController keyEnglishController = TextEditingController();
    TextEditingController valueEnglishController = TextEditingController();
    TextEditingController valueArabicController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showDialog(
        context: currentContext,
        builder: (context) {
          return Form(
            key: formKey,
            child: SizedBox(
              width: 800,
              child: SimpleDialog(
                contentPadding: const EdgeInsets.only(
                    left: 40, right: 40, top: 40, bottom: 40),
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 400,
                        child: CustomTextField(
                            onTap: () {},
                            formatters: [
                              // FilteringTextInputFormatter.allow(
                              //     RegExp("^[\u0600-\u06FF\\s]+\$")),
                            ],
                            controller: keyArabicController,
                            labelText: LocaleKeys.nameArabic.tr()),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 350,
                        child: CustomTextField(
                            onTap: () {},
                            formatters: [
                              // FilteringTextInputFormatter.allow(
                              //     RegExp("^[\u0600-\u06FF\\s]+\$")),
                            ],
                            controller: valueArabicController,
                            labelText: LocaleKeys.value.tr()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 400,
                        child: CustomTextField(
                            formatters: [
                              // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]+"))
                            ],
                            onTap: () {},
                            controller: keyEnglishController,
                            labelText: LocaleKeys.nameEngish.tr()),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 350,
                        child: CustomTextField(
                            formatters: [
                              // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]+"))
                            ],
                            onTap: () {},
                            controller: valueEnglishController,
                            labelText: LocaleKeys.value.tr()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 44,
                          width: 700,
                          child: AppButton(
                            fontWeight: FontWeight.w700,
                            titleFontSize: 14,
                            title: LocaleKeys.add.tr(),
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.pop(context);
                                productDetails.add(ProductDetails(
                                    key: keyArabicController.text,
                                    keyEn: keyEnglishController.text,
                                    value: valueArabicController.text,
                                    valueEn: valueEnglishController.text));
                                productDetailsCubit.update(
                                    data: productDetails);
                              }
                            },
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.mainColor)),
                          child: Center(
                            child: Icon(Icons.close),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  getSubCategories({required String categoryId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Category/GetAllSubById?catId=$categoryId',
          body: {});
      result.fold((success) {
        subCategories = categoryModelFromJson(success);
        subCategoryCubit.update(data: subCategories);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getSubSubCategories({required String categoryId}) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Category/GetAllSubById?catId=$categoryId',
          body: {});
      result.fold((success) {
        subSubCategories = categoryModelFromJson(success);
        subSubCategoryCubit.update(data: subSubCategories);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<ProductModelProductOptionsOption> options = [];
  List<String> selectedOptions = [];
  GenericCubit<List<ProductModelProductOptionsOption>> optionsCubit =
      GenericCubit<List<ProductModelProductOptionsOption>>();

  getAllOptions() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Option/GetAll', body: {});
      result.fold((success) {
        options = productOptionsFromJson(success);
        options.removeWhere(
            (element) => element.categoryId != selectedSubSubCategory?.value);
        optionsCubit.update(data: options);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  removeImageFromProduct({required String imagesId}) {
    AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Product/DeleteProductImages?Id=$imagesId',
        body: {});
  }

  addImageToProduct({required String productId, required String imageId}) {
    AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Product/AddProductImages',
        body: {"productId": productId, "photoId": imageId});
  }

  updateProduct({required ProductModel product}) async {
    if (formKey.currentState!.validate()) {
      loading.show;
      try {
        SharedPreferences ref = await SharedPreferences.getInstance();
        String? vendorId = ref.getString('vendorId');

        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/Product/Update',
            body: {
              "id": product.id,
              "name": arabicNameController.text,
              "nameEn": englishNameController.text,
              "description": arabicDescriptionController.text,
              "descriptionEn": englishNameController.text,
              "defaultPrice": priceController.text,
              "oldPrice": product.oldPrice,
              "orderNUmber": product.orderNUmber,
              "htmlDescriptions": "string",
              "htmlOther": "string",
              "isActive": true,
              "defaultPhotoId": product.defaultPhotoId,
              "brandId": selectedBrand?.value,
              "categoryId": selectedSubSubCategory?.value,
              "vendorId": vendorId,
              "amount": stockController.text,
              "paymentType": product.paymentType,
              "noteForReturn": noteForReturnController.text,
              "productPrice": product.productPrice,
              "programDiscountPercentage": product.programDiscountPercentage,
              "programDiscountValue": product.programDiscountValue,
              "priceAfterProgramInfluencer":
                  product.priceAfterProgramInfluencer,
              "influencerPercentage": product.influencerPercentage,
              "influencerValue": product.influencerValue,
              "priceWithInfluencer": product.priceWithInfluencer,
              "maxDiscountWithFamous": product.maxDiscountWithFamous,
              "productDiscountPercentage": product.productDiscountPercentage,
              "productDiscountValue": product.productDiscountValue,
              "priceBeforeDiscount": product.priceBeforeDiscount,
              "maxProgramDiscountPercentage":
                  product.maxProgramDiscountPercentage,
              "finalDisplayPrice": product.finalDisplayPrice,
              "discountPercentage": product.discountPercentage,
              "evaluationRate": product.evaluationRate,
              "couponDeduction": product.couponDeduction,
              "mainCategoryId": selectedCategory?.value,
              "totalProductStock": stockController.text,
              "totalProductSold": product.totalProductSold,
              "subCategoryId": selectedSubCategory?.value,
              "suggestedSalePriceFromVendor": suggestedPriceController.text
            });
        result.fold((success) {
          showSuccessMessage(message: 'Done');
        }, (fail) {
          showErrorMessage(message: fail.message);
        });
      } catch (error) {}
      loading.hide;
    }
  }
}
