import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/brands/brand_model.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/models/generic/generic_response.dart';
import 'package:sislimoda_admin_dashboard/models/product/add_product_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/brand_operation.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/dose.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/indication_for_use.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/side_effects.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

mixin ProductData {
  Loading loading = Loading();
  GenericCubit<List<ProductModel>> productsCubit =
      GenericCubit<List<ProductModel>>();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController englishDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController systemProfitController = TextEditingController();
  TextEditingController clientCashbackController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GenericCubit<List<CategoryModel>> categoriesCubit =
      GenericCubit<List<CategoryModel>>();
  GenericCubit<List<XFile>> imagesCubit = GenericCubit<List<XFile>>();
  List<BrandModel> brands = [];
  ValueItem? selectedBrand;
  ValueItem? selectedCategory;
  GenericCubit<List<BrandModel>> brandsCubit = GenericCubit<List<BrandModel>>();
  GenericCubit<bool> isProductDrugCubit = GenericCubit<bool>();

  bool isDetailed = false;
  GenericCubit<bool> isAddProductsCubit = GenericCubit<bool>();
  int productPage = 1;
  int productTotalPages = 1;
  // getProducts() async {
  //   imagesCubit.update(data: []);
  //   isProductDrugCubit.update(data: false);
  //   isAddProductsCubit.update(data: false);
  //   getCategories();
  //   loading.show;
  //
  //   try {
  //     var result = await AppService.callService(
  //         actionType: ActionType.get,
  //         apiName: 'medicine?useCursor=false&page=$productPage&size=8',
  //         body: null);
  //     result.fold((l) {
  //       productsCubit.update(data: productModelFromJson(l));
  //     }, (r) {
  //       showErrorMessage(message: r.message);
  //     });
  //   } catch (error) {}
  //   loading.hide;
  // }

  List<CategoryModel> subCategories = [];
  GenericCubit<List<CategoryModel>> subCategoryCubit =
      GenericCubit<List<CategoryModel>>();

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

  List<CategoryModel> subSubCategories = [];
  GenericCubit<List<CategoryModel>> subSubCategoryCubit =
      GenericCubit<List<CategoryModel>>();
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

  Future<void> updateAmount(
      {required ProductModel product, required String newAmount}) async {
    loading.show;
    try {
      SharedPreferences ref = await SharedPreferences.getInstance();
      String? vendorId = ref.getString('vendorId');

      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Product/Update',
          body: {
            "id": product.id,
            "name": product.name,
            "nameEn": product.nameEn,
            "description": product.description,
            "descriptionEn": product.descriptionEn,
            "defaultPrice": product.defaultPrice,
            "oldPrice": product.oldPrice,
            "orderNUmber": product.orderNUmber,
            "htmlDescriptions": product.htmlDescriptions,
            "htmlOther": product.htmlOther,
            "isActive": product.isActive,
            "defaultPhotoId": product.defaultPhotoId,
            "brandId": product.brandId,
            "categoryId": product.categoryId,
            "vendorId": product.vendorId,
            "amount": product.amount,
            "paymentType": product.paymentType,
            "noteForReturn": product.noteForReturn,
            "productPrice": product.productPrice,
            "programDiscountPercentage": product.programDiscountPercentage,
            "programDiscountValue": product.programDiscountValue,
            "priceAfterProgramInfluencer": product.priceAfterProgramInfluencer,
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
            "mainCategoryId": product.mainCategoryId,
            "subCategoryId": product.subCategoryId,
            "suggestedSalePriceFromVendor":
                product.suggestedSalePriceFromVendor,
            "totalProductStock":
                '${int.parse(product.totalProductStock ?? '0') + int.parse(newAmount)}',
            "totalProductSold": product.totalProductSold
          });
      result.fold((success) {}, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
  }

  getVendorProducts() async {
    imagesCubit.update(data: []);
    isProductDrugCubit.update(data: false);
    isAddProductsCubit.update(data: false);
    getCategories();
    loading.show;

    try {
      SharedPreferences ref = await SharedPreferences.getInstance();
      String? userId = ref.getString('userId');
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAllByVendor?VendorId=$userId',
          body: null);
      result.fold((l) {
        productsCubit.update(data: productModelFromJson(l));
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }

  getCategories() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'category', body: null);
      result.fold((l) {
        // ResponseModel<CategoryModel> responseModel = ResponseModel.fromJson(
        //     jsonDecode(l), CategoryModel.fromJson, 'categories');
        // categoriesCubit.update(data: responseModel.data!);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
  }

  refreshCategories() async {
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'category', body: null);
      result.fold((l) {
        // ResponseModel<CategoryModel> responseModel = ResponseModel.fromJson(
        //     jsonDecode(l), CategoryModel.fromJson, 'categories');
        // categoriesCubit.update(data: responseModel.data!);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
  }

  addBrand() async {
    showDialog(
        context: currentContext,
        barrierColor: AppColors.barrierColor,
        builder: (ctx) {
          return BrandOperation(
            // brands: brands,
            refresh: () {},
            operationType: OperationType.add,
            brand: BrandModel(),
          );
        });
  }

  addIndicationForuse() {
    TextEditingController nameArabicController = TextEditingController();
    TextEditingController nameEnglishController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showDialog(
        context: currentContext,
        builder: (context) {
          return Form(
            key: formKey,
            child: SimpleDialog(
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 20, top: 20),
              children: [
                SizedBox(
                  width: 400,
                  child: CustomTextField(
                      onTap: () {},
                      formatters: [
                        // FilteringTextInputFormatter.allow(
                        //     RegExp("^[\u0600-\u06FF\\s]+\$")),
                      ],
                      controller: nameArabicController,
                      labelText: LocaleKeys.nameArabic.tr()),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                    formatters: [
                      // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]+"))
                    ],
                    onTap: () {},
                    controller: nameEnglishController,
                    labelText: LocaleKeys.nameEngish.tr()),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 44,
                          child: AppButton(
                            titleFontColor: AppColors.black,
                            fontWeight: FontWeight.w700,
                            titleFontSize: 14,
                            title: LocaleKeys.addIndicationsForUse.tr(),
                            onPress: () {},
                          )),
                    ),
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
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        });
  }

  addProductImages(
      {required String folderName, required String productId}) async {
    List<MultipartFile> images = [];
    for (var element in imagesCubit.state.data!) {
      MultipartFile image = MultipartFile.fromBytes(
          "image", await element.readAsBytes(),
          contentType: MediaType('image', element.name.split('.').last),
          filename: element.name);
      images.add(image);
    }
    print('images.length ${images.length}');
    var result = await AppService.callService(
        actionType: ActionType.postFormData,
        apiName: 'medicine/$productId/image?imageFolderName=$folderName',
        files: images,
        body: null);

    result.fold((l) async {
      resetdata();
      // await getProducts();
      showSuccessMessage(message: 'تم إضافة المنتج بنجاح');
    }, (r) async {
      isAddProductsCubit.update(data: false);
      resetdata();
      // await getProducts();
      showErrorMessage(
          message:
              'تم إضافة المنتج بنجاح ولكن حدث خطأ في رفع الصور علي السيرفر الرجاء تعديل الصور من داخل المنتج');
    });
    loading.hide;
  }

  resetdata() {
    arabicNameController.clear();
    englishNameController.clear();
    arabicDescriptionController.clear();
    englishDescriptionController.clear();
    selectedBrand = null;
    selectedCategory = null;
    stockController.clear();
    imagesCubit.update(data: []);
    priceController.clear();
    discountController.clear();
  }

  deleteProduct({required ProductModel product, required int index}) async {
    // try {
    //   List<CategoryModel> categories = categoriesCubit.state.data!;
    //   productsCubit.state.data?.remove(product);
    //   productsCubit.update(data: productsCubit.state.data!);
    //
    //   var result = await AppService.callService(
    //       actionType: ActionType.patch,
    //       apiName: 'category/${category.id}/delete',
    //       body: {});
    //
    //   result.fold((l) {}, (r) {
    //     productsCubit.state.data?.insert(index, product);
    //     productsCubit.update(data: productsCubit.state.data!);
    //     showErrorMessage(message: r.message);
    //   });
    // } catch (error) {}
  }


 GenericCubit<ProductModel> productCubit = GenericCubit<ProductModel>();

void showProductDetails({
  required ProductModel product,
  required BuildContext context,
  required bool isAdmin,
}) {
  productCubit.update(data: product);

  showDialog(
    context: context,
    builder: (ctx) {
      return GenericBuilder(
        genericCubit: productCubit,
        builder: (product) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 0.6.sw,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomNetworkImage(
                        link: product.defaultPhoto?.fullLink ?? '',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isArabic ? (product.name ?? '') : (product.nameEn ?? ''),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isArabic ? (product.description ?? '') : (product.descriptionEn ?? ''),
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const Divider(height: 30),
                    Text('💰 ${LocaleKeys.price.tr()}: ${product.defaultPrice} \$'),
                    Text('✅ ${isArabic ? 'السعر النهائي' : 'Final Price'}: ${product.finalDisplayPrice} \$'),
                    Text('🔧 ${isArabic ? 'سعر بعد النظام' : 'Price after system'}: ${product.productPrice} \$'),
                    Text('👤 ${isArabic ? 'سعر بعد المشهور' : 'After influencer'}: ${product.priceAfterProgramInfluencer} \$'),
                    Text('🎟 ${isArabic ? 'خصم الكوبون' : 'Coupon Deduction'}: ${product.couponDeduction}%'),
                    Text('💸 ${isArabic ? 'نسبة الخصم' : 'Discount'}: ${product.discountPercentage}%'),
                    const Divider(height: 30),
                    Text('📦 ${isArabic ? 'الكمية المتاحة' : 'Available stock'}: ${product.totalProductStock}'),
                    Text('🏷️ ${isArabic ? 'التصنيف' : 'Category'}: ${product.category?.name ?? ''}'),
                    Text('🏷️ ${isArabic ? 'العلامة التجارية' : 'Brand'}: ${product.brand?.name ?? ''}'),
                    if ((product.productOptions?.isNotEmpty ?? false)) ...[
                      const SizedBox(height: 10),
                      Text('🎨 ${isArabic ? 'الخيارات' : 'Options'}:'),
                      ...product.productOptions!.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text('• ${e?.option?.groupName}: ${isArabic ? e?.option?.name : e?.option?.nameEn}'),
                          )),
                    ],
                    if ((product.productDetails?.isNotEmpty ?? false)) ...[
                      const SizedBox(height: 10),
                      Text('🧼 ${isArabic ? 'تفاصيل إضافية' : 'Additional Info'}:'),
                      ...product.productDetails!.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text('• ${isArabic ? e?.key : e?.keyEn}: ${isArabic ? e?.value : e?.valueEn}'),
                          )),
                    ],
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(isArabic ? 'إغلاق' : 'Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

  // GenericCubit<ProductModel> productCubit = GenericCubit<ProductModel>();
  void addcup(
      {required ProductModel product,
      required BuildContext context,
      required bool isAdmin}) {
    productCubit.update(data: product);
    TextEditingController influencerProfitController =
        TextEditingController(text: product.influencerPercentage);
    TextEditingController systemProfitController =
        TextEditingController(text: product.programDiscountPercentage);
    TextEditingController couponDeductionController =
        TextEditingController(text: product.couponDeduction);
    TextEditingController discountController =
        TextEditingController(text: product.discountPercentage);
    showDialog(
        context: context,
        builder: (ctx) {
          return GenericBuilder(
              genericCubit: productCubit,
              builder: (product) {
                double priceAfterCouponDeduction = (double.parse(
                                product.priceAfterProgramInfluencer ?? '0') /
                            100) *
                        double.parse(product.couponDeduction ?? '0') +
                    double.parse(product.priceAfterProgramInfluencer ?? '0');
                return Material(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1.sh,
                          width: .5.sw,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      LocaleKeys.productDetails.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    if (!isAdmin)
                                      Material(
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                              context.router.push(
                                                  EditProductRoute(
                                                      productId:
                                                          product.id ?? ''));
                                            },
                                            icon: Icon(Icons.edit)),
                                      ),
                                    Material(
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                          },
                                          icon: Icon(Icons.close)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    height: 300,
                                    child: product.defaultPhoto != null
                                        ? ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: product.productImages!
                                                .map((element) => Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 250,
                                                      child: CustomNetworkImage(
                                                        link: product
                                                                .defaultPhoto
                                                                ?.fullLink ??
                                                            '',
                                                        width: 250,
                                                        height: 300,
                                                      ),
                                                    ))
                                                .toList(),
                                          )
                                        : CustomNetworkImage(
                                            link: '',
                                            height: 300,
                                            width: .5.sw,
                                          )),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              isArabic
                                                  ? (product.name ?? '')
                                                  : (product.nameEn ?? ''),
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      color: AppColors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        isArabic
                                            ? (product.description ?? '')
                                            : (product.descriptionEn ?? ''),
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 14,
                                            height: 1.8,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${LocaleKeys.price.tr()} ${product.defaultPrice ?? ''} \$',
                                        textAlign: TextAlign.justify,
                                        style: AppFonts.apptextStyle.copyWith(
                                            height: 1.6,
                                            color: AppColors.black,
                                            fontSize: 19.spMin,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (isAdmin)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${isArabic ? "السعر بعد نسبه النظام" : "Price after system Profit"} ${product.productPrice ?? ''} \$',
                                              textAlign: TextAlign.justify,
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      height: 1.6,
                                                      color: AppColors.black,
                                                      fontSize: 19.spMin,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${isArabic ? "السعر بعد اضافه نسبة المشهور" : "Price after influencer Percentage"} ${product.priceAfterProgramInfluencer ?? ''} \$',
                                              textAlign: TextAlign.justify,
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      height: 1.6,
                                                      color: AppColors.black,
                                                      fontSize: 19.spMin,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${isArabic ? "نسبة الاضافه لخصم المشهور" : "price after influencer deduction"} ${(priceAfterCouponDeduction).toStringAsFixed(2)} \$',
                                              textAlign: TextAlign.justify,
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      height: 1.6,
                                                      color: AppColors.black,
                                                      fontSize: 19.spMin,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${isArabic ? "السعر النهائي" : "final price"} ${(priceAfterCouponDeduction + (priceAfterCouponDeduction / 100) * double.parse(product.discountPercentage ?? '0')).toStringAsFixed(2)} \$',
                                              textAlign: TextAlign.justify,
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      height: 1.6,
                                                      color: AppColors.black,
                                                      fontSize: 19.spMin,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    controller:
                                                        systemProfitController,
                                                    onTap: () {},
                                                    labelText: isArabic
                                                        ? 'نسبة النظام'
                                                        : "system profit",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  height: 48.h,
                                                  child: AppButton(
                                                    onPress: () {
                                                      saveSystemProfit(
                                                          newPercentage:
                                                              double.parse(
                                                                  systemProfitController
                                                                      .text),
                                                          product: product);
                                                    },
                                                    title: isArabic
                                                        ? "حفظ"
                                                        : "Save",
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    controller:
                                                        influencerProfitController,
                                                    onTap: () {},
                                                    labelText: isArabic
                                                        ? 'نسبة المشهور'
                                                        : "Influencer profit",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  height: 48.h,
                                                  child: AppButton(
                                                    onPress: () {
                                                      saveInfluencerProfit(
                                                          newPercentage:
                                                              double.parse(
                                                                  influencerProfitController
                                                                      .text),
                                                          product: product);
                                                    },
                                                    title: isArabic
                                                        ? "حفظ"
                                                        : "Save",
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    controller:
                                                        couponDeductionController,
                                                    onTap: () {},
                                                    labelText: isArabic
                                                        ? 'النسبه لخصم الكوبون'
                                                        : "amount to coupon deduction",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  height: 48.h,
                                                  child: AppButton(
                                                    onPress: () {
                                                      saveCouponDeduction(
                                                          newPercentage:
                                                              couponDeductionController
                                                                  .text,
                                                          productId:
                                                              product.id ?? '',
                                                          product: product);
                                                    },
                                                    title: isArabic
                                                        ? "حفظ"
                                                        : "Save",
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    controller:
                                                        discountController,
                                                    onTap: () {},
                                                    labelText: isArabic
                                                        ? 'نسبه الخصم للجمهور'
                                                        : "Users discount percent",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  height: 48.h,
                                                  child: AppButton(
                                                    onPress: () {
                                                      saveDiscount(
                                                          newPercentage:
                                                              discountController
                                                                  .text,
                                                          product: product);
                                                    },
                                                    title: isArabic
                                                        ? "حفظ"
                                                        : "Save",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),

                                      // Container(
                                      //   width: double.infinity,
                                      //   height: 32,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.grey.shade100,
                                      //       borderRadius: BorderRadius.circular(8)),
                                      //   child: Row(
                                      //     children: [
                                      //       SizedBox(
                                      //         width: 14,
                                      //       ),
                                      //       StatefulBuilder(builder: (context, state) {
                                      //         return SizedBox(
                                      //           width: 21,
                                      //           child: Transform.scale(
                                      //               scaleX: .5,
                                      //               scaleY: .5,
                                      //               child: CupertinoSwitch(
                                      //                   value: product.isActive == true,
                                      //                   onChanged: (value) {
                                      //                     if (value) {
                                      //                       AppService.callService(
                                      //                           actionType:
                                      //                               ActionType.patch,
                                      //                           apiName:
                                      //                               'medicine/${product.id}/unfreeze',
                                      //                           body: {}).then((value) {
                                      //                         value.fold((success) {},
                                      //                             (fail) {
                                      //                           state(() {
                                      //                             product.isActive =
                                      //                                 false;
                                      //                           });
                                      //                         });
                                      //                       });
                                      //                       state(() {
                                      //                         product.isActive = true;
                                      //                       });
                                      //                     } else {
                                      //                       AppService.callService(
                                      //                           actionType:
                                      //                               ActionType.patch,
                                      //                           apiName:
                                      //                               'medicine/${product.id}/freeze',
                                      //                           body: {}).then((value) {
                                      //                         value.fold((success) {},
                                      //                             (fail) {
                                      //                           state(() {
                                      //                             product.isActive =
                                      //                                 false;
                                      //                           });
                                      //                         });
                                      //                       });
                                      //                       state(() {
                                      //                         product.isActive = true;
                                      //                       });
                                      //                     }
                                      //                   })),
                                      //         );
                                      //       }),
                                      //       SizedBox(
                                      //         width: 14,
                                      //       ),
                                      //       Text(
                                      //         LocaleKeys.available.tr(),
                                      //         style: AppFonts.apptextStyle.copyWith(
                                      //             color: Colors.black,
                                      //             fontSize: 14,
                                      //             fontWeight: FontWeight.w400),
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      // IndicationForUse(
                                      //     indicationsForuse:
                                      //         product.indicationsForUse ?? []),
                                      // SizedBox(
                                      //   height: 12.h,
                                      // ),
                                      // Dose(doses: product.dose ?? []),
                                      // SizedBox(
                                      //   height: 12.h,
                                      // ),
                                      // SideEffects(
                                      //   sideEffects: product.sideEffects ?? [],
                                      // ),
                                      // SizedBox(
                                      //   height: 70.h,
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  saveSystemProfit(
      {required ProductModel product, required double newPercentage}) async {
    loading.show;
    var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Product/UpdateProgramPrice',
        body: {
          "id": product.id,
          "productPrice": double.parse(product.defaultPrice ?? '0') +
              (double.parse(product.defaultPrice ?? '0') *
                  (newPercentage / 100)),
          "programDiscountPercentage": newPercentage.toString(),
          "programDiscountValue":
              double.parse(product.defaultPrice ?? '0') * (newPercentage / 100),
          "maxProgramDiscountPercentage": 0,
          "discountPercentage": 0
        });

    result.fold((success) async {
      product.productPrice = (double.parse(product.defaultPrice ?? '0') +
              (double.parse(product.defaultPrice ?? '0') *
                  (newPercentage / 100)))
          .toStringAsFixed(2);
      product.programDiscountPercentage = newPercentage.toStringAsFixed(2);
      productCubit.update(data: product);
      await saveInfluencerProfit(
          product: product,
          newPercentage: double.parse(product.influencerPercentage ?? '0'));
    }, (fail) {});
  }

  saveInfluencerProfit(
      {required ProductModel product, required double newPercentage}) async {
    loading.show;
    var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/Product/UpdateInfluencerPrice',
        body: {
          "id": product.id,
          "priceAfterProgramInfluencer":
              double.parse(product.productPrice ?? '0') +
                  (double.parse(product.productPrice ?? '0') *
                      (newPercentage / 100)),
          "influencerPercentage": newPercentage,
          // "influencerValue":
          //     double.parse(product.productPrice ?? '0') * (newPercentage / 100),
          // "priceWithInfluencer": product.priceWithInfluencer,
          // "maxDiscountWithFamous": 0,
          // "discountPercentage": 0
        });

    result.fold((success) async {
      product.priceAfterProgramInfluencer =
          (double.parse(product.productPrice ?? '0') +
                  (double.parse(product.productPrice ?? '0') *
                      (newPercentage / 100)))
              .toStringAsFixed(2);
      product.influencerPercentage = newPercentage.toStringAsFixed(2);
      productCubit.update(data: product);
      showSuccessMessage(
          message: isArabic
              ? " تم تعديل النسبه بنجاح"
              : 'Percentage updated successfully');
    }, (fail) {});
    loading.hide;
  }

  saveCouponDeduction({
    required String newPercentage,
    required String productId,
    required ProductModel product,
  }) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName:
              'api/Product/UpdateCouponDeduction?productId=$productId&CouponDeduction=$newPercentage',
          body: {});

      result.fold((success) {
        product.couponDeduction = newPercentage;
        productCubit.update(data: product);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  saveDiscount({
    required String newPercentage,
    required ProductModel product,
  }) async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName: 'api/Product/UpdateDiscountPercentage',
          body: {"id": product.id, "discountPercentage": newPercentage});

      result.fold((success) {
        product.discountPercentage = newPercentage;
        productCubit.update(data: product);
      }, (fail) {
        showErrorMessage(message: fail.message);
      });
    } catch (error) {}
    loading.hide;
  }

  List<ProductModel> products = [];
  search(String text) async {
    if (text.isEmpty) {
      productsCubit.update(data: products);
      return;
    }
    List<ProductModel> tempProducts = [];

    for (var element in products) {
      String searchableText = '${element.name} ${element.nameEn}';
      if (searchableText.toLowerCase().contains(text.toLowerCase())) {
        tempProducts.add(element);
      }
    }
    productsCubit.update(data: tempProducts);
  }

  ValueItem? selectedSubSubCategory;
  ValueItem? selectedSubCategory;
  getProducts() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userId = ref.getString('vendorId');
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAllByVendor?VendorId=$userId',
          body: null);
      result.fold((l) {
        products = productModelFromJson(l);
        productsCubit.update(data: products);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }

  ValueItem? selectedStatus;
  filter({
    required FilterType type,
  }) {
    List<ProductModel> tempProducts = [];
    if (type == FilterType.category) {
      tempProducts = products
          .where((element) => element.mainCategoryId == selectedCategory?.value)
          .toList();
    } else if (type == FilterType.subCategory) {
      tempProducts = products
          .where((element) =>
              (element.subCategoryId == selectedSubCategory?.value))
          .toList();
    } else if (type == FilterType.subSubCategory) {
      tempProducts = products
          .where(
              (element) => element.categoryId == selectedSubSubCategory?.value)
          .toList();
    }
    if (selectedStatus?.value == 'accepted') {
      tempProducts.removeWhere((element) => element.isActive == false);
    } else if (selectedStatus?.value == 'review') {
      tempProducts.removeWhere((element) => element.isActive == true);
    }

    productsCubit.update(data: tempProducts);
  }
Future<void> updateStatus({
  required String productId,
  required bool newStatus,
}) async {
  loading.show;
  try {
    final result = await AppService.callService(
      actionType: ActionType.post,
      apiName: 'api/Product/Update',
      body: {
        "id": productId,
        "isActive": newStatus,
      },
    );

    result.fold((success) {
      showSuccessMessage(message: 'تم التحديث بنجاح');
      getProducts(); // جدد البيانات بعد التحديث
    }, (fail) {
      showErrorMessage(message: fail.message);
    });
  } catch (error) {
    showErrorMessage(message: error.toString());
  }
  loading.hide;
}

}

enum FilterType { category, subCategory, subSubCategory }
