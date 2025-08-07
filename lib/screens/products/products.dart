import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/cubits/products_cubit/products_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/products/product_data.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/product_item.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> with ProductData {
  String productStatusFilter = 'all';
  String selectedProductId = 'all';
  String _searchTerm = '';

  void search(String value) {
    setState(() {
      _searchTerm = value.trim().toLowerCase();
    });
  }

TextEditingController idSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      final  isArabic = Localizations.localeOf(context).languageCode == 'ar';  

    return Screen(
      loadingCubit: BlocProvider.of<ProductsCubit>(context).loading,
      child: Scaffold(
        appBar: AppBarCustom(
          ctx: context,
          search: search,
        ),
        body: context.isMobile
            ? mobileDesign()
            : Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: 1.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
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
                                  fontSize: 22),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              LocaleKeys.productsManagementHint.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const SizedBox(width: 24),
                                Text(
                                  LocaleKeys.products.tr(),
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                DropdownButton<String>(
                                  value: selectedProductId,
                                  items: [
                                    DropdownMenuItem(
                                      value: 'all',
                                      child: Text(isArabic ? 'كل المنتجات' : 'All Products'),
                                    ),
                                    ...getAllProducts(context).map(
                                      (prod) => DropdownMenuItem(
                                        value: prod.id ?? '',
                                        child: Text(
                                          isArabic ? (prod.name ?? '') : (prod.nameEn ?? ''),
                                        ),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedProductId = value!;
                                    });
                                  },
                                ),
                                const SizedBox(width: 16),
                                DropdownButton<String>(
                                  value: productStatusFilter,
                                  items: [
                                    DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All')),
                                    DropdownMenuItem(
                                        value: 'approved',
                                        child: Text(isArabic
                                            ? 'تمت الموافقة'
                                            : 'Approved')),
                                    DropdownMenuItem(
                                        value: 'pending',
                                        child: Text(isArabic
                                            ? 'في المراجعة'
                                            : 'Pending Review')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      productStatusFilter = value!;
                                    });
                                  },
                                ),
                                const SizedBox(width: 24),
                              ],
                            ),
                            BlocBuilder<ProductsCubit, ProductsState>(
                              builder: (context, state) {
                                return Expanded(
                                  child: DataTable2(
                                    empty: Center(
                                      child: Text(
                                        isArabic
                                            ? 'لا يوجد منتجات'
                                            : 'No products found',
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    dividerThickness: 0,
                                    columns: [
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.id.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 140,
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.productName.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 175,
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.price.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryFontColor),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.soldNumber.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryFontColor),
                                        ),
                                        
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          isArabic ? 'الحالة' : 'Status',
                                          style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondaryFontColor,
                                          ),
                                        ),
                                        fixedWidth: 120,
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          isArabic ? 'الحالة' : 'Status',
                                          style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondaryFontColor,
                                          ),
                                        ),
                                        fixedWidth: 140,
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 165,
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryFontColor),
                                        ),
                                          fixedWidth: 145,
                                        size: ColumnSize.L,
                                      ),
                                    ],
                                    rows: state is ProductsLoaded
                                        ? state.products
                                            .where((product) {
                                              final name = product.id ;
                                              final nameMatch = name?.toLowerCase().contains(_searchTerm) ?? false;
                                              final statusMatch = productStatusFilter == 'all'
                                                  ? true
                                                  : productStatusFilter == 'approved'
                                                      ? product.isActive == true
                                                      : product.isActive == false;
                                              final productMatch = selectedProductId == 'all'
                                                  ? true
                                                  : product.id == selectedProductId;
                                              return nameMatch && statusMatch && productMatch;
                                            })
                                            .map(
                                              (e) => DataRow2(
                                                cells: [
                                                  DataCell(Text(
                                                    e.id?.substring(0, 5) ?? '',
                                                    maxLines: 2,
                                                    style: AppFonts.apptextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColors.secondaryFontColor),
                                                  )),
                                                  DataCell(Text(
                                                    isArabic ? (e.name ?? '') : (e.nameEn ?? ''),
                                                    style: AppFonts.apptextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColors.secondaryFontColor),
                                                  )),
                                                  DataCell(Text(
                                                    e.valueToDisplayAfterDiscount ?? '',
                                                    style: AppFonts.apptextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColors.secondaryFontColor),
                                                  )),
                                                  DataCell(Text(
                                                    e.amount ?? '',
                                                    style: AppFonts.apptextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColors.secondaryFontColor),
                                                  )),
                                                  DataCell(
                                                    Text(
                                                      e.isActive == true
                                                          ? (isArabic ? 'تمت الموافقة' : 'Approved')
                                                          : (isArabic ? 'في المراجعة' : 'Pending Review'),
                                                      style: AppFonts.apptextStyle.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: e.isActive == true ? Colors.green : Colors.orange,
                                                      ),
                                                    ),
                                                  ),
  DataCell(
  TextButton(
    onPressed: () async {
      final newStatus = !(e.isActive ?? false);

      await updateStatus(productId: e.id ?? '', newStatus: newStatus);

      setState(() {
        e.isActive = newStatus;
      });
    },
    style: TextButton.styleFrom(
      backgroundColor: (e.isActive ?? false)
          ? Colors.red.withOpacity(0.1)
          : Colors.green.withOpacity(0.1),
    ),
    child: Text(
      (e.isActive ?? false)
          ? (isArabic ? 'رفض' : 'Reject')
          : (isArabic ? 'قبول' : 'Accept'),
      style: AppFonts.apptextStyle.copyWith(
        color: (e.isActive ?? false) ? Colors.red : Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),



                                                  DataCell(
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            showProductDetails(
                                                                isAdmin: true,
                                                                context: context,
                                                                product: e);
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8),
                                                              border: Border.all(color: AppColors.mainColor),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                LocaleKeys.productsDetails.tr(),
                                                                style: AppFonts.apptextStyle.copyWith(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColors.mainColor),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                   DataCell(
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            addcup(
                                                                isAdmin: true,
                                                                context: context,
                                                                product: e);
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal:5, vertical: 5),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8),
                                                              border: Border.all(color: AppColors.mainColor),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                 isArabic ? 'إدارة الكوبون' : 'Manage Coupon',
                                                                style: AppFonts.apptextStyle.copyWith(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColors.mainColor),
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
                                            .toList()
                                        : [],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }

  // Helper to get all products for the dropdown
  List getAllProducts(BuildContext context) {
    final state = context.read<ProductsCubit>().state;
    if (state is ProductsLoaded) {
      return state.products;
    }
    return [];
  }
Widget mobileDesign() {
  return Screen(
    loadingCubit: BlocProvider.of<ProductsCubit>(context).loading,
    child: BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final products = state is ProductsLoaded ? state.products.where((product) {
          final nameMatch = (product.name ?? '').toLowerCase().contains(_searchTerm);
          final statusMatch = productStatusFilter == 'all'
              ? true
              : productStatusFilter == 'approved'
                  ? product.isActive == true
                  : product.isActive == false;
          final productMatch = selectedProductId == 'all'
              ? true
              : product.id == selectedProductId;
          return nameMatch && statusMatch && productMatch;
        }).toList() : [];

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: products.length,
          separatorBuilder: (_, __) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final product = products[index];

            return Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج + السعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          isArabic ? (product.name ?? '') : (product.nameEn ?? ''),
                          style: AppFonts.apptextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${product.valueToDisplayAfterDiscount ?? ''} ',
                        style: AppFonts.apptextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryFontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),

                  
                  Text(
                    product.isActive == true
                        ? (isArabic ? 'تمت الموافقة' : 'Approved')
                        : (isArabic ? 'في المراجعة' : 'Pending Review'),
                    style: AppFonts.apptextStyle.copyWith(
                      color: product.isActive == true ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),

                  // أزرار التحكم
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final newStatus = !(product.isActive ?? false);
                            await updateStatus(productId: product.id ?? '', newStatus: newStatus);
                            setState(() {
                              product.isActive = newStatus;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: (product.isActive ?? false)
                                ? Colors.red.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),
                          ),
                          child: Text(
                            (product.isActive ?? false)
                                ? (isArabic ? 'رفض' : 'Reject')
                                : (isArabic ? 'قبول' : 'Accept'),
                            style: AppFonts.apptextStyle.copyWith(
                              color: (product.isActive ?? false) ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            showProductDetails(isAdmin: true, context: context, product: product);
                          },
                          child: Text(
                            LocaleKeys.productsDetails.tr(),
                            style: AppFonts.apptextStyle.copyWith(fontSize: 13),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            addcup(isAdmin: true, context: context, product: product);
                          },
                          child: Text(
                            isArabic ? 'الكوبون' : 'Coupon',
                            style: AppFonts.apptextStyle.copyWith(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}

/*
  Widget mobileDesign() {
    return Container(
      padding: const EdgeInsets.only(left: 34, right: 34),
      width: double.infinity,
      height: 1.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
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
                  SizedBox(height: 8.h),
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
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            children: [
              DropdownButton<String>(
                value: selectedProductId,
                items: [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text(isArabic ? 'كل المنتجات' : 'All Products'),
                  ),
                  ...getAllProducts(context).map(
                    (prod) => DropdownMenuItem(
                      value: prod.id ?? '',
                      child: Text(isArabic ? (prod.name ?? '') : (prod.nameEn ?? '')),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedProductId = value!;
                  });
                },
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: productStatusFilter,
                items: [
                  DropdownMenuItem(
                      value: 'all',
                      child: Text(isArabic ? 'الكل' : 'All')),
                  DropdownMenuItem(
                      value: 'approved',
                      child: Text(isArabic
                          ? 'تمت الموافقة'
                          : 'Approved')),
                  DropdownMenuItem(
                      value: 'pending',
                      child: Text(isArabic
                          ? 'في المراجعة'
                          : 'Pending Review')),
                ],
                onChanged: (value) {
                  setState(() {
                    productStatusFilter = value!;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: GenericBuilder<List>(
              genericCubit: productsCubit,
              builder: (products) {
                final filteredProducts = products.where((product) {
                  final name = isArabic ? product.name : product.nameEn;
                  final nameMatch = name?.toLowerCase().contains(_searchTerm) ?? false;
                  final statusMatch = productStatusFilter == 'all'
                      ? true
                      : productStatusFilter == 'approved'
                          ? product.isActive == true
                          : product.isActive == false;
                  final productMatch = selectedProductId == 'all'
                      ? true
                      : product.id == selectedProductId;
                  return nameMatch && statusMatch && productMatch;
                }).toList();

                return GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 336,
                      mainAxisExtent: 400.h,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: filteredProducts[index],
                      delete: () {
                        CustomAlert.showConfirmDialogue(
                            confirmDone: () {
                              deleteProduct(
                                  product: filteredProducts[index], index: index);
                            },
                            message: LocaleKeys.confirmDeleteCategory.tr(),
                            context: context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  */
}
// ...existing code...
/*
class _ProductsState extends State<Products> with ProductData {

  @override
String productStatusFilter = 'all';// 'all' | 'approved' | 'pending'


  void initState() {
    // TODO: implement initState
    // getProducts();

    super.initState();
  }
String _searchTerm = '';

void search(String value) {
  setState(() {
    _searchTerm = value.trim().toLowerCase();
  });
}


  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: BlocProvider.of<ProductsCubit>(context).loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
            search: search,
          ),
          body: context.isMobile
              ? mobileDesign()
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                LocaleKeys.productsManagementHint.tr(),
                                style: AppFonts.apptextStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 10.w,
                          ),
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
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),  const Spacer(),
    DropdownButton<String>(
      value:productStatusFilter ,
      items: [
        DropdownMenuItem(value: 'all', child: Text(isArabic ? 'الكل' : 'All')),
        DropdownMenuItem(value: 'approved', child: Text(isArabic ? 'تمت الموافقة' : 'Approved')),
        DropdownMenuItem(value: 'pending', child: Text(isArabic ? 'في المراجعة' : 'Pending Review')),
      ],
      onChanged: (value) {
        setState(() {
          productStatusFilter = value! ;
        });
      },
    ),
    const SizedBox(width: 24),
                              ],
                            ),
                            BlocBuilder<ProductsCubit, ProductsState>(
                              builder: (context, state) {
                                return Expanded(
                                  child: DataTable2(
                                    empty: Center(
                                      child: Text(
                                        isArabic
                                            ? 'لا يوجد منتجات'
                                            : 'No products found',
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    dividerThickness: 0,
                                    columns: [
                                      // DataColumn2(
                                      //   label: AppCheckbox(label: Text('')),
                                      //   fixedWidth: 60,
                                      // ),
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.id.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 200,
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.productName.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        fixedWidth: 300,
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
                                          LocaleKeys.price.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Text(
                                          LocaleKeys.soldNumber.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
  label: Text(
    isArabic ? 'الحالة' : 'Status',
    style: AppFonts.apptextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryFontColor,
    ),
  ),
  size: ColumnSize.L,
),

                                      DataColumn2(
                                        label: Text(
                                          '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                    ],
                                    rows: state is ProductsLoaded
                                        ? state.products
  .where((product) {
    final name = isArabic ? product.name : product.nameEn;
    final nameMatch = name?.toLowerCase().contains(_searchTerm) ?? false;

    final statusMatch = productStatusFilter == 'all'
        ? true
        : productStatusFilter == 'approved'
            ? product.isActive == true
            : product.isActive == false;

    return nameMatch && statusMatch;
  })
                                            .map(
                                              (e) => DataRow2(
                                                cells: [
                                                  DataCell(Text(
                                                    e.id?.substring(0, 5) ?? '',
                                                    maxLines: 2,
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  )),
                                                  DataCell(Text(
                                                    isArabic
                                                        ? (e.name ?? '')
                                                        : (e.nameEn ?? ''),
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                                    e.valueToDisplayAfterDiscount ??
                                                        '',
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  )),
                                                  DataCell(Text(
                                                    e.amount ?? '',
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryFontColor),
                                                  )),
                                                  DataCell(
  Text(
    e.isActive == true
        ? (isArabic ? 'تمت الموافقة' : 'Approved')
        : (isArabic ? 'في المراجعة' : 'Pending Review'),
    style: AppFonts.apptextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: e.isActive == true ? Colors.green : Colors.orange,
    ),
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
                                                            showProductDetails(
                                                                isAdmin: true,
                                                                context:
                                                                    context,
                                                                product: e);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        21,
                                                                    vertical:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .mainColor),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                LocaleKeys
                                                                    .productsDetails
                                                                    .tr(),
                                                                style: AppFonts
                                                                    .apptextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: AppColors
                                                                            .mainColor),
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
                                            .toList()
                                        : [],
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
*/