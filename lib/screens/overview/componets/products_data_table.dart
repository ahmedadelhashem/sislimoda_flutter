  import 'package:auto_route/auto_route.dart';
  import 'package:data_table_2/data_table_2.dart';
  import 'package:easy_localization/easy_localization.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
  import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
  import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
  import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
  import 'package:sislimoda_admin_dashboard/screens/products/widgets/dose.dart';
  import 'package:sislimoda_admin_dashboard/screens/products/widgets/indication_for_use.dart';
  import 'package:sislimoda_admin_dashboard/screens/products/widgets/side_effects.dart';
  import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
  import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
  import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

  class ProductsDataTable extends StatefulWidget {
    const ProductsDataTable({super.key, required this.products});

    final List<GetAnalysisModelTopSellingProducts?>? products;
    @override
    State<ProductsDataTable> createState() => _ProductsDataTableState();
  }

  class _ProductsDataTableState extends State<ProductsDataTable> {
    @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 10),
        height: .75.sh,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.topProducts.tr(),
              style: AppFonts.apptextStyle.copyWith(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Expanded(
                child: DataTable2(
              empty: Center(
                child: Text(
                  isArabic ? 'لا يوجد منتجات' : 'No products found',
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
                    maxLines: 1,
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
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
                    '',
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                  size: ColumnSize.L,
                ),
              ],
              rows: widget.products!
                  .map(
                    (e) => DataRow2(
                      cells: [
                        DataCell(Text(
                          e?.product?.id?.substring(0, 8) ?? '',
                          maxLines: 2,
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        )),
                        DataCell(Text(
                          isArabic
                              ? (e?.product?.name ?? '')
                              : (e?.product?.nameEn ?? ''),
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
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
                          e?.product?.finalDisplayPrice ?? '',
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        )),
                        DataCell(Text(
                          e?.totalSales ?? '',
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        )),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  // context.router.push(EditProductRoute(
                                  //     productId: e?.productId ?? ''));
                                  showProductDetails(
                                      product: ProductModel.fromJson(e!.toJson()),
                              context: context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: AppColors.mainColor),
                                  ),
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.productsDetails.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 13.sp,
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
                  .toList(),
            ))
          ],
        ),
      );
    }
  }

  showProductDetails(
      {required ProductModel product, required BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
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
                            Material(
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit)),
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
                            child: CustomNetworkImage(
                              link: '',
                              height: 300,
                              width: .5.sw,
                            )),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      isArabic
                                          ? (product.name ?? '')
                                          : (product.nameEn ?? ''),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
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
                                '${product.productPrice ?? ''}  ج.م',
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
                              Container(
                                width: double.infinity,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 14,
                                    ),
                                    StatefulBuilder(builder: (context, state) {
                                      return SizedBox(
                                        width: 21,
                                        child: Transform.scale(
                                            scaleX: .5,
                                            scaleY: .5,
                                            child: CupertinoSwitch(
                                                value: product.isActive == true,
                                                onChanged: (value) {
                                                  if (value) {
                                                    AppService.callService(
                                                        actionType:
                                                            ActionType.patch,
                                                        apiName:
                                                            'medicine/${product.id}/unfreeze',
                                                        body: {}).then((value) {
                                                      value.fold((success) {},
                                                          (fail) {
                                                        state(() {
                                                          product.isActive =
                                                              false;
                                                        });
                                                      });
                                                    });
                                                    state(() {
                                                      product.isActive = true;
                                                    });
                                                  } else {
                                                    AppService.callService(
                                                        actionType:
                                                            ActionType.patch,
                                                        apiName:
                                                            'medicine/${product.id}/freeze',
                                                        body: {}).then((value) {
                                                      value.fold((success) {},
                                                          (fail) {
                                                        state(() {
                                                          product.isActive = true;
                                                        });
                                                      });
                                                    });
                                                    state(() {
                                                      product.isActive = false;
                                                    });
                                                  }
                                                })),
                                      );
                                    }),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      LocaleKeys.available.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
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
          );
        });
  }
