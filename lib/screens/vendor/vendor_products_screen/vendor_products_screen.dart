import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/products_cubit/products_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/products/product_data.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/product_item.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_products_screen/add_product/add_product.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class VendorProductsScreen extends StatefulWidget {
  const VendorProductsScreen({super.key});

  @override
  State<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen>
    with ProductData {
  @override
  void initState() {
    // TODO: implement initState
    getVendorProducts();
    getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';  
  final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
      return Screen(
      loadingCubit: BlocProvider.of<ProductsCubit>(context).loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
            search: search,
          ),
          body: context.isMobile
              ? mobileDesign()
              : GenericBuilder<bool>(
                  genericCubit: isAddProductsCubit,
                  builder: (isAddProducts) {
                    return isAddProducts
                        ? AddProduct(
                            isAddProductsCubit: isAddProductsCubit,
                            productModel: ProductModel(),
                            isUpdate: false,
                          )
                        : Container(
                            padding: const EdgeInsets.only(left: 34, right: 34),
                            width: double.infinity,
                            height: 1.sh,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.productsManagement.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(
                                          LocaleKeys.productsManagementHint
                                              .tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isArabic ? "الحالة" : isTurkish ? "Durum" :
                                             "Status",
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 15,
                                                    color:
                                                        AppColors.borderColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          BlocBuilder<CategoriesCubit,
                                                  CategoriesState>(
                                              builder: (context, state) {
                                            if (state is CategoriesLoaded) {
                                              return CustomMultiSelect(
                                                isSingle: true,
                                                hint: isArabic
                                                    ? 'اختار الحالة' : isTurkish
                                                    ? 'Durumu seç' 
                                                    : "Select status",
                                                onChange:
                                                    (List<ValueItem> items) {
                                                  if (items.isNotEmpty) {
                                                    selectedStatus =
                                                        items.first;
                                                    filter(
                                                        type: FilterType
                                                            .category);
                                                  } else {
                                                    selectedCategory = null;
                                                  }
                                                },
                                                items: [
                                                  ValueItem(
                                                      label: isArabic
                                                          ? 'الكل' : isTurkish
                                                          ? 'Tümü'
                                                          : 'All',
                                                      value: 'all'),
                                                  ValueItem(
                                                      label: isArabic
                                                          ? 'في المراجعة' : isTurkish ? 'İnceleme'
                                                          : 'in review',
                                                      value: 'review'),
                                                  ValueItem(
                                                      label: isArabic
                                                          ? 'تمت الموافقة' : isTurkish
                                                          ? 'Onaylandı'
                                                          : 'Accepted',
                                                      value: 'accepted')
                                                ],
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LocaleKeys.categoryName.tr(),
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 15,
                                                    color:
                                                        AppColors.borderColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          BlocBuilder<CategoriesCubit,
                                                  CategoriesState>(
                                              builder: (context, state) {
                                            if (state is CategoriesLoaded) {
                                              return CustomMultiSelect(
                                                isSingle: true,
                                                hint: LocaleKeys.selectCategory
                                                    .tr(),
                                                onChange:
                                                    (List<ValueItem> items) {
                                                  if (items.isNotEmpty) {
                                                    selectedCategory =
                                                        items.first;
                                                    getSubCategories(
                                                        categoryId:
                                                            selectedCategory
                                                                ?.value);
                                                    filter(
                                                        type: FilterType
                                                            .category);
                                                  } else {
                                                    selectedCategory = null;
                                                  }
                                                },
                                                items: state.categories
                                                    .map((e) => ValueItem(
                                                        label: isArabic
                                                            ? e.name ?? ""
                                                            : e.nameEn ?? '',
                                                        value: e.id))
                                                    .toList(),
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
                                          return Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LocaleKeys.subCategoryName
                                                      .tr(),
                                                  style: AppFonts.apptextStyle
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: AppColors
                                                              .borderColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                CustomMultiSelect(
                                                  key: GlobalKey(),
                                                  isSingle: true,
                                                  hint: LocaleKeys
                                                      .selectCategory
                                                      .tr(),
                                                  onChange:
                                                      (List<ValueItem> items) {
                                                    if (items.isNotEmpty) {
                                                      getSubSubCategories(
                                                          categoryId: items
                                                              .first.value);
                                                      selectedSubCategory =
                                                          items.first;
                                                      filter(
                                                          type: FilterType
                                                              .subCategory);
                                                    } else {
                                                      selectedSubCategory =
                                                          null;
                                                    }
                                                  },
                                                  items: subCategories
                                                      .map((e) => ValueItem(
                                                          label: isArabic
                                                              ? e.name ?? ""
                                                              : e.nameEn ?? '',
                                                          value: e.id))
                                                      .toList(),
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
                                          return Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LocaleKeys.subCategoryName
                                                      .tr(),
                                                  style: AppFonts.apptextStyle
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: AppColors
                                                              .borderColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                CustomMultiSelect(
                                                  key: GlobalKey(),
                                                  isSingle: true,
                                                  hint: LocaleKeys
                                                      .selectCategory
                                                      .tr(),
                                                  onChange:
                                                      (List<ValueItem> items) {
                                                    if (items.isNotEmpty) {
                                                      selectedSubSubCategory =
                                                          items.first;
                                                      filter(
                                                          type: FilterType
                                                              .subSubCategory);
                                                    } else {
                                                      selectedSubSubCategory =
                                                          null;
                                                    }
                                                  },
                                                  items: subSubCategories
                                                      .map((e) => ValueItem(
                                                          label: isArabic
                                                              ? e.name ?? ""
                                                              : e.nameEn ?? '',
                                                          value: e.id))
                                                      .toList(),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    // SizedBox(
                                    //   width: 10.w,
                                    // ),
                                    // SizedBox(
                                    //   width: 150,
                                    //   height: 40,
                                    //   child: AppButton(
                                    //     onPress: () {
                                    //       isAddProductsCubit.update(
                                    //           data: !isAddProductsCubit
                                    //               .state.data!);
                                    //     },
                                    //     title: LocaleKeys.addProduct.tr(),
                                    //     titleFontColor: Colors.white,
                                    //     titleFontSize: 15,
                                    //     fontWeight: FontWeight.w700,
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          Text(
                                            LocaleKeys.products.tr(),
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      GenericBuilder(
                                        genericCubit: productsCubit,
                                        builder: (products) {
                                          return Expanded(
                                            child: DataTable2(
                                              empty: Center(
                                                child: Text(
                                                  isArabic
                                                      ? 'لا يوجد منتجات' : isTurkish
                                                      ? 'Ürün bulunamadı'
                                                      : 'No products found',
                                                  style: AppFonts.apptextStyle
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16),
                                                ),
                                              ),
                                              dividerThickness: 0,
                                              columns: [
                                                // DataColumn2(
                                                //   label: AppCheckbox(label: Text('')),
                                                //   fixedWidth: 60,
                                                // ),
                                                // DataColumn2(
                                                //   label: Text(
                                                //     LocaleKeys.id.tr(),
                                                //     style: AppFonts.apptextStyle
                                                //         .copyWith(
                                                //             fontSize: 16,
                                                //             fontWeight:
                                                //                 FontWeight.w400,
                                                //             color: AppColors
                                                //                 .secondaryFontColor),
                                                //   ),
                                                //   fixedWidth: 200,
                                                //   size: ColumnSize.L,
                                                // ),
                                                DataColumn2(
                                                  label: Text(
                                                    LocaleKeys.productName.tr(),
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  fixedWidth: 200,
                                                  size: ColumnSize.L,
                                                ),
                                                // DataColumn2(
                                                //   label: Text(
                                                //     LocaleKeys.stock.tr(),
                                                //     style: AppFonts
                                                //         .apptextStyle
                                                //         .copyWith(
                                                //             fontSize: 16,
                                                //             fontWeight:
                                                //                 FontWeight
                                                //                     .w400,
                                                //             color: AppColors
                                                //                 .secondaryFontColor),
                                                //   ),
                                                //   size: ColumnSize.L,
                                                // ),
                                                DataColumn2(
                                                  label: Text(
                                                    isArabic
                                                        ? 'القسم' : isTurkish
                                                        ? 'Kategori'
                                                        : "Category",
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  size: ColumnSize.L,
                                                ),
                                                DataColumn2(
                                                  label: Text(
                                                    isArabic ? "بيعت" : isTurkish
                                                        ? 'Satıldı'
                                                        : "Sold",
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  fixedWidth: 100,
                                                  size: ColumnSize.L,
                                                ),
                                                DataColumn2(
                                                  label: Text(
                                                    isArabic
                                                        ? 'المتوفر لديك' : isTurkish
                                                        ? 'Stokta'
                                                        : "Stock",
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  size: ColumnSize.L,
                                                ),
                                                DataColumn2(
                                                  label: Text(
                                                    isArabic
                                                        ? 'الحالة' : isTurkish
                                                        ? 'Durum'
                                                        : "Status",
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  fixedWidth: 150,
                                                  size: ColumnSize.L,
                                                ),
                                                DataColumn2(
                                                  label: Text(
                                                    '',
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  fixedWidth: 200,
                                                  size: ColumnSize.L,
                                                ),
                                                DataColumn2(
                                                  label: Text(
                                                    '',
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  ),
                                                  
                                                  size: ColumnSize.L,
                                                ),
                                              ],
                                              rows: products
                                                  .map(
                                                    (e) => DataRow2(
                                                      onTap: () {
                                                        context.router.push(
                                                            EditProductRoute(
                                                                productId:
                                                                    e.id ??
                                                                        ''));
                                                        // showProductDetails(
                                                        //     isAdmin: false,
                                                        //     context: context,
                                                        //     product: e);
                                                      },
                                                      color: WidgetStateProperty.all(int
                                                                  .parse(
                                                                      e.totalProductStock ??
                                                                          '0') <
                                                              int.parse(
                                                                  e.suggestedSalePriceFromVendor ??
                                                                      '0')
                                                          ? Colors.red
                                                              .withOpacity(.1)
                                                          : Colors.transparent),
                                                      cells: [
                                                        // DataCell(Text(
                                                        //   e.id?.substring(
                                                        //           0, 5) ??
                                                        //       '',
                                                        //   maxLines: 2,
                                                        //   style: AppFonts
                                                        //       .apptextStyle
                                                        //       .copyWith(
                                                        //           fontSize:
                                                        //               16,
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .w400,
                                                        //           color: AppColors
                                                        //               .secondaryFontColor),
                                                        // )),
                                                        DataCell(Text(
                                                          isArabic
                                                              ? (e.name ?? '')
                                                              : (e.nameEn ??
                                                                  ''),
                                                          maxLines: 2,
                                                          style: AppFonts
                                                              .apptextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .secondaryFontColor),
                                                        )),
                                                        // DataCell(Text(
                                                        //   e.V ?? '',
                                                        //   style: AppFonts
                                                        //       .apptextStyle
                                                        //       .copyWith(
                                                        //           fontSize:
                                                        //               16,
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .w400,
                                                        //           color: AppColors
                                                        //               .secondaryFontColor),
                                                        // )),
                                                        DataCell(Text(
                                                          isArabic
                                                              ? e.category
                                                                      ?.name ??
                                                                  ''
                                                              : e.category
                                                                      ?.nameEn ??
                                                                  '',
                                                          style: AppFonts
                                                              .apptextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .secondaryFontColor),
                                                        )),
                                                        DataCell(Text(
                                                          e.totalProductSold ??
                                                              '',
                                                          style: AppFonts
                                                              .apptextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .secondaryFontColor),
                                                        )),
                                                        DataCell(Text(
                                                          e.totalProductStock ??
                                                              '',
                                                          style: AppFonts
                                                              .apptextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .secondaryFontColor),
                                                        )),
                                                        DataCell(Text(
                                                          e.isActive == true
                                                              ? (isArabic 
                                                                  ? "تمت الموافقة" : isTurkish
                                                                  ? "Onaylandı"
                                                                  : "Accepted")
                                                              : (isArabic
                                                                  ? "في المراجعة" : isTurkish
                                                                  ? "İnceleme"
                                                                  : "In review"),
                                                          style: AppFonts
                                                              .apptextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: e.isActive ==
                                                                          true
                                                                      ? Colors
                                                                          .green
                                                                      : AppColors
                                                                          .mainColor),
                                                        )),
                                                        DataCell(
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (ctx) {
                                                                        TextEditingController
                                                                            amountController =
                                                                            TextEditingController();
                                                                        return Dialog(
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(25),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Text(
                                                                                  isArabic ? 'إضافه المزيد' : isTurkish ? 'Daha fazla ekle' :
                                                                                   'Add more',
                                                                                  style: AppFonts.apptextStyle.copyWith(
                                                                                    fontSize: 14.sp,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 300,
                                                                                  child: CustomTextField(
                                                                                    onTap: () {},
                                                                                    formatters: [
                                                                                      FilteringTextInputFormatter.digitsOnly,
                                                                                    ],
                                                                                    controller: amountController,
                                                                                    labelText: isArabic ? "الكمية" :  isTurkish ? 'Miktar' :
                                                                                     "Amount",
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 48,
                                                                                  width: 300,
                                                                                  child: AppButton(
                                                                                    onPress: () => updateAmount(product: e, newAmount: amountController.text).then((value) async {
                                                                                      Navigator.pop(ctx);
                                                                                      await getProducts();
                                                                                      showSuccessMessage(message: 'Done');
                                                                                    }),
                                                                                    title: LocaleKeys.add.tr(),
                                                                                    titleFontSize: 14.sp,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          21,
                                                                      vertical:
                                                                          8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .mainColor),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      isArabic
                                                                          ? 'إضافه المزيد' : isTurkish
                                                                              ? 'Daha fazla ekle'
                                                                              : 'Add more',
                                                                      style: AppFonts.apptextStyle.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              AppColors.mainColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  context.router.push(EditProductRoute(
                                                                      productId:
                                                                          e.id ??
                                                                              ''));
                                                                  // showProductDetails(
                                                                  //     product: ProductModel.fromJson(e!.toJson()),
                                                                  //     context: context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          21,
                                                                      vertical:
                                                                          8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .mainColor),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      LocaleKeys
                                                                          .productsDetails
                                                                          .tr(),
                                                                      style: AppFonts.apptextStyle.copyWith(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              AppColors.mainColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          );
                  },
                )),
    );
  }

  Widget mobileDesign() {
    return Container(
      padding: const EdgeInsets.only(left: 34, right: 34),
      width: double.infinity,
      height: 1.sh,
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
                    LocaleKeys.productsManagement.tr(),
                    style: AppFonts.apptextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.spMin),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: .5.sw,
                    child: Text(
                      LocaleKeys.productsManagementHint.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.spMin),
                    ),
                  )
                ],
              ),
              const Spacer(),
              // SizedBox(
              //   width: 150,
              //   height: 40,
              //   child: AppButton(
              //     backgroundColor: Colors.white,
              //     borderColor: AppColors.mainColor,
              //     onPress: () {
              //       setState(() {
              //         isDetailed = !isDetailed;
              //       });
              //     },
              //     title: isDetailed
              //         ? LocaleKeys.products.tr()
              //         : LocaleKeys.productsDetails.tr(),
              //     titleFontColor: AppColors.black,
              //     titleFontSize: 15,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // SizedBox(
              //   width: 10.w,
              // ),
              // SizedBox(
              //   width: 150,
              //   height: 40,
              //   child: AppButton(
              //     onPress: () {
              //       isAddProductsCubit.update(
              //           data: !isAddProductsCubit.state.data!);
              //     },
              //     title: LocaleKeys.addProduct.tr(),
              //     titleFontColor: AppColors.black,
              //     titleFontSize: 15,
              //     fontWeight: FontWeight.w700,
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
              child: GenericBuilder<List<ProductModel>>(
            genericCubit: productsCubit,
            builder: (products) {
              return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 336,
                      mainAxisExtent: 400.h,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: products[index],
                      delete: () {
                        CustomAlert.showConfirmDialogue(
                            confirmDone: () {
                              deleteProduct(
                                  product: products[index], index: index);
                            },
                            message: LocaleKeys.confirmDeleteCategory.tr(),
                            context: context);
                      },
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}
