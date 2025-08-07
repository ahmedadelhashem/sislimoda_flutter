import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/orders/widgets/order_item.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_orders_screen/vendor_order_changestatu.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_orders_screen/vendor_order_data.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor_details/vendor_details_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class VendorOrdersScreen extends StatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  State<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends State<VendorOrdersScreen>
    with VendorOrderData {

      
  @override
  void initState() {
    // TODO: implement initState
    getAllOrders();

    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: context.isMobile ? mobileDesing() : webDesign(),
    );
  }

  Widget webDesign() {
    
    return Screen(
      loadingCubit: loading,
      child: Container(
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
                      LocaleKeys.ordersManagement.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      LocaleKeys.ordersManagementHint.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
                const Spacer(),
                GenericBuilder(
                    genericCubit: statusCubit,
                    builder: (states) {
                      return CustomDropdownNew(
                        title: isArabic ? 'الكل' :  'All',
                        items: states
                            .map((element) => Item(
                                key: element.id ?? '',
                                value: isArabic
                                    ? (element.nameAr ?? '')
                                    : (element.nameEn ?? '')))
                            .toList(),
                        onSelect: (item) {
                          if (item.key == '0') {
                            ordersCubit.update(data: orders);
                            return;
                          }
                          ordersCubit.update(
                              data: orders.where((element) {
                            return element?.orderStatus?.id == item.key;
                          }).toList());
                        },
                      );
                    })
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            GenericBuilder<List<OrderModel?>>(
                genericCubit: ordersCubit,
                builder: (ordersData) {
                  return Expanded(
                      child: DataTable2(
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
                        size: ColumnSize.S,
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
                          fixedWidth: 250),
                      DataColumn2(
                          label: Text(
                            LocaleKeys.clientName.tr(),
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryFontColor),
                          ),
                          size: ColumnSize.L,
                          fixedWidth: 300),
                      DataColumn2(
                        label: Text(
                          LocaleKeys.price.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        ),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text(
                          LocaleKeys.status.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        ),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text(
                          LocaleKeys.status.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        ),
                        size: ColumnSize.L,
                      ),
                    ],
                    rows: ordersData.map((element) {
                      double totalOrderValueForVendor = 0;
                      element?.orderProducts?.forEach((element) {
                        totalOrderValueForVendor = totalOrderValueForVendor +
                            double.parse(element?.product?.defaultPrice ?? '0');
                      });
                      return DataRow2(cells: [
                        DataCell(
                          Text(
                            element?.id?.substring(0, 6) ?? '',
                            maxLines: 2,
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: 14,
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryFontColor),
                          ),
                        ),
                        DataCell(Text(
                          isArabic
                              ? (element?.orderProducts?.first?.product?.name ??
                                  '')
                              : (element
                                      ?.orderProducts?.first?.product?.nameEn ??
                                  ''),
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        )),
                        DataCell(Text(
                          '${element?.user?.firstName ?? ''} ${element?.user?.lastName ?? ''}',
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        )),
                        DataCell(Text(
                          totalOrderValueForVendor.toStringAsFixed(2),
                          style: AppFonts.apptextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryFontColor),
                        )),
                        DataCell(
                          
                          Column(
                          children: [
                            
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: false
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Color(int.tryParse(
                                                  '0xff${element?.orderStatus?.color?.substring(1)}') ??
                                              0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: Text(
                                          isArabic
                                              ? element?.orderStatus?.nameAr ??
                                                  ''
                                              : element?.orderStatus?.nameEn ??
                                                  '',
                                          style: AppFonts.apptextStyle
                                              .copyWith(fontSize: 14.sp),
                                        ),
                                      ),
                                    )
                                  : CustomMultiSelect(
                                      backgroundColor: Color(int.tryParse(
                                              '0xff${element?.orderStatus?.color?.substring(1)}') ??
                                          0xffffffff),
                                      isSingle: true,
                                      
                                      selectedItems: [
                                        ValueItem(
                                            label:
                                                element?.orderStatus?.nameAr ??
                                                    '',
                                            value: element?.orderStatus?.id)
                                      ],
                                      hint: '',
                                      items: itemStatus,
                                      onChange: (List<ValueItem> options) {
                                        if (options.isNotEmpty) {
                                          changeOrderStatus(
                                              orderId: element?.id ?? '',
                                              orderStatusId:
                                                  options.first.value);
                                        }
                                      }),
                            ),
                          ],
                        )
                        ),
                        DataCell(AppButton(
                          title: LocaleKeys.details.tr(),
                          borderRadius: 8.r,
                          onPress: () {
                            context.router.push(
                                OrderDetailsRoute(orderId: element?.id ?? ''));
                          },
                        )),
                      ]);
                    }).toList(),
                  ));
                }),
          ],
        ),
      ),
    );
  }

  Widget mobileDesing() {
    return Screen(
      loadingCubit: loading,
      child: GenericBuilder<bool>(
          genericCubit: isOrderCubit,
          builder: (isOrder) {
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
                            LocaleKeys.ordersManagement.tr(),
                            style: AppFonts.apptextStyle.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.spMin),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: .4.sw,
                            child: Text(
                              LocaleKeys.ordersManagementHint.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.spMin),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      PopupMenuButton(
                          position: PopupMenuPosition.under,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          constraints: BoxConstraints(minWidth: 220.w),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                height: 35,
                                onTap: () {
                                  isOrderCubit.update(data: true);
                                },
                                child: Text(
                                  LocaleKeys.allOrders.tr(),
                                  style: AppFonts.apptextStyle.copyWith(),
                                ),
                              ),
                              PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    isOrderCubit.update(data: false);
                                  },
                                  child: Text(
                                    LocaleKeys.requestsThatNeedToReReviewed
                                        .tr(),
                                    style: AppFonts.apptextStyle.copyWith(),
                                  )),
                            ];
                          },
                          child: Icon(
                            Icons.more_horiz,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  if (isOrder)
                    GenericBuilder<List<OrderModel?>>(
                        genericCubit: ordersCubit,
                        builder: (ordersData) {
                          return Expanded(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 10.h,
                                    );
                                  },
                                  itemCount: ordersData.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return OrderItem(order: ordersData[index]);
                                  }));
                        }),
                ],
              ),
            );
          }),
    );
  }
}
