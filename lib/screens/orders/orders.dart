import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/orders/orders_data.dart';
import 'package:sislimoda_admin_dashboard/screens/orders/widgets/order_item.dart';
import 'package:sislimoda_admin_dashboard/screens/orders/widgets/ticket_item.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with OrdersData {
  TextEditingController searchController = TextEditingController();
String searchText = '';
String selectedStatusFilter = 'all';
String selectedStatusId = '0';
late bool isArabic;

applyFilters() {
  final filtered = orders.where((order) {
    final fullName =
        '${order?.user?.firstName ?? ''} ${order?.user?.lastName ?? ''}'.toLowerCase();
    final matchesName = fullName.contains(searchText.toLowerCase());

    final status = isArabic
        ? order?.orderStatus?.nameAr?.trim()
        : order?.orderStatus?.nameEn?.trim();

    final matchesStatus = selectedStatusFilter == 'all'
        || (selectedStatusFilter == 'new' &&
            (status == 'جديد' || status?.toLowerCase() == 'new'))
        || (selectedStatusFilter == 'delivering' &&
            (status == 'قيد التوصيل' || status!.toLowerCase().contains('delivering')));

    return matchesName && matchesStatus;
  }).toList();

  ordersCubit.update(data: filtered);
}


  @override
  void initState() {
    // TODO: implement initState
    isOrderCubit.update(data: true);
    getAllOrders();
    getAllProducts();
    super.initState();
  }
@override
void dispose() {
  searchController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
       isArabic = Localizations.localeOf(context).languageCode == 'ar';  

    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: context.isMobile ? mobileDesing() : webDesign(),
    );
  }

  Widget webDesign() {
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
                      SizedBox(
      width: 250,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: isArabic ? 'ابحث باسم العميل' : 'Search by client name',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        onChanged: (value) {
          searchText = value;
          applyFilters();
        },
      ),
    ),
    SizedBox(width: 12.w),
    // فلتر الحالة
    DropdownButton<String>(
      value: selectedStatusFilter,
      items: [
        DropdownMenuItem(value: 'all', child: Text(isArabic ? 'الكل' : 'All')),
        DropdownMenuItem(
            value: 'new', child: Text(isArabic ? 'جديد' : 'New')),
        DropdownMenuItem(
            value: 'delivering',
            child: Text(isArabic ? 'قيد التوصيل' : 'Delivering')),
      ],
      onChanged: (value) {
        if (value != null) {
          selectedStatusFilter = value;
          applyFilters();
        }
      },
    ),

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
                              // DataColumn2(
                              //     label: Text(
                              //       LocaleKeys.productName.tr(),
                              //       style: AppFonts.apptextStyle.copyWith(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w400,
                              //           color: AppColors.secondaryFontColor),
                              //     ),
                              //     size: ColumnSize.L,
                              //     fixedWidth: 250),
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
                              return DataRow2(cells: [
                                DataCell(
                                  Text(
                                    element?.orderNumber ?? '',
                                    maxLines: 2,
                                    style: AppFonts.apptextStyle.copyWith(
                                        fontSize: 14,
                                        height: 1.6,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryFontColor),
                                  ),
                                ),
                                // DataCell(Text(
                                //   isArabic
                                //       ? (element?.orderProducts?.first?.product
                                //               ?.name ??
                                //           '')
                                //       : (element?.orderProducts?.first?.product
                                //               ?.nameEn ??
                                //           ''),
                                //   style: AppFonts.apptextStyle.copyWith(
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w400,
                                //       color: AppColors.secondaryFontColor),
                                // )),
                                DataCell(Text(
                                  '${element?.user?.firstName ?? ''} ${element?.user?.lastName ?? ''}',
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryFontColor),
                                )),
                                DataCell(Text(
                                  (element?.finalDisplayPrice ?? '0')
                                      .toString(),
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryFontColor),
                                )),
                                DataCell(Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.w, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: Color(int.parse(
                                              '0xff${element?.orderStatus?.color?.substring(1)}'))),
                                      child: Center(
                                        child: Text(
                                          isArabic
                                              ? (element?.orderStatus?.nameAr ??
                                                  '')
                                              : (element?.orderStatus?.nameEn ??
                                                  ''),
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.spMin),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                                DataCell(AppButton(
                                  title: LocaleKeys.details.tr(),
                                  borderRadius: 8.r,
                                  onPress: () {
                                    context.router.push(OrderDetailsRoute(
                                        orderId: element?.id ?? ''));
                                  },
                                )),
                              ]);
                            }).toList(),
                          ));
                        }),
                  // if (isOrder)
                  //   GenericBuilder<GetOrderPaginationModel>(
                  //       genericCubit: ordersCubit,
                  //       builder: (ordersData) {
                  //         return Row(
                  //           children: [
                  //             Spacer(),
                  //             Pagination(
                  //               currentPage: page,
                  //               totalPage: totalPages,
                  //               show: totalPages > 10 ? 10 : totalPages - 1,
                  //               useSkipAndPrevButtons: true,
                  //               nextButtonStyles: PaginateSkipButton(
                  //                   buttonBackgroundColor: Colors.transparent,
                  //                   icon: Icon(
                  //                     Icons.arrow_forward_ios,
                  //                     size: 15,
                  //                   )),
                  //               prevButtonStyles: PaginateSkipButton(
                  //                   buttonBackgroundColor: Colors.transparent,
                  //                   icon: Icon(
                  //                     Icons.arrow_back_ios,
                  //                     size: 15,
                  //                   )),
                  //               paginateButtonStyles: PaginateButtonStyles(
                  //                   paginateButtonBorderRadius:
                  //                       BorderRadius.circular(8),
                  //                   activeBackgroundColor:
                  //                       Colors.blue.withOpacity(.1),
                  //                   activeTextStyle: AppFonts.apptextStyle
                  //                       .copyWith(
                  //                           color: Colors.black, fontSize: 12),
                  //                   backgroundColor: Colors.transparent,
                  //                   textStyle: AppFonts.apptextStyle.copyWith(
                  //                       color: Colors.black, fontSize: 12)),
                  //               onPageChange: (int number) async {
                  //                 page = number;
                  //                 await getAllOrders();
                  //                 setState(() {});
                  //               },
                  //             )
                  //           ],
                  //         );
                  //       }),
                  // if (!isOrder)
                  //   GenericBuilder<GetTicketsPaginationModel>(
                  //       genericCubit: ticketCubit,
                  //       builder: (ticketdata) {
                  //         return ticketdata.tickets?.isEmpty ?? true
                  //             ? Expanded(
                  //                 child: Center(
                  //                     child: NoResultFound(
                  //                 title: isArabic
                  //                     ? 'لا يوجد طلبات تحتاج للمراجعه'
                  //                     : 'No orders need to confirm',
                  //               )))
                  //             : Expanded(
                  //                 child: GridView.builder(
                  //                     itemCount: ticketdata.tickets?.length,
                  //                     gridDelegate:
                  //                         SliverGridDelegateWithMaxCrossAxisExtent(
                  //                             mainAxisSpacing: 15,
                  //                             crossAxisSpacing: 10,
                  //                             mainAxisExtent: 250,
                  //                             maxCrossAxisExtent: .3.sw),
                  //                     itemBuilder: (context, index) {
                  //                       return TicketItem(
                  //                         products: products,
                  //                         width: .3.sw,
                  //                         ticket: ticketdata.tickets?[index],
                  //                       );
                  //                     }));
                  //       }),
                  // if (!isOrder)
                  //   Row(
                  //     children: [
                  //       Spacer(),
                  //       Pagination(
                  //         currentPage: ticketPage,
                  //         totalPage: totalTicketsPage,
                  //         show:
                  //             totalTicketsPage > 10 ? 10 : totalTicketsPage - 1,
                  //         useSkipAndPrevButtons: true,
                  //         nextButtonStyles: PaginateSkipButton(
                  //             buttonBackgroundColor: Colors.transparent,
                  //             icon: Icon(
                  //               Icons.arrow_forward_ios,
                  //               size: 15,
                  //             )),
                  //         prevButtonStyles: PaginateSkipButton(
                  //             buttonBackgroundColor: Colors.transparent,
                  //             icon: Icon(
                  //               Icons.arrow_back_ios,
                  //               size: 15,
                  //             )),
                  //         paginateButtonStyles: PaginateButtonStyles(
                  //             paginateButtonBorderRadius:
                  //                 BorderRadius.circular(8),
                  //             activeBackgroundColor:
                  //                 Colors.blue.withOpacity(.1),
                  //             activeTextStyle: AppFonts.apptextStyle
                  //                 .copyWith(color: Colors.black, fontSize: 12),
                  //             backgroundColor: Colors.transparent,
                  //             textStyle: AppFonts.apptextStyle
                  //                 .copyWith(color: Colors.black, fontSize: 12)),
                  //         onPageChange: (int number) async {
                  //           ticketPage = number;
                  //           await getAllTickets();
                  //           setState(() {});
                  //         },
                  //       ),
                  //     ],
                  //   )
                ],
              ),
            );
          }),
    );
  }
Widget mobileDesing() {
  return Screen(
    loadingCubit: loading,
    child: GenericBuilder<bool>(
      genericCubit: isOrderCubit,
      builder: (isOrder) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// العنوان والوصف
              Text(
                LocaleKeys.ordersManagement.tr(),
                style: AppFonts.apptextStyle.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                LocaleKeys.ordersManagementHint.tr(),
                style: AppFonts.apptextStyle.copyWith(
                  color: AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 12.h),

              /// فلترة بالاسم والحالة
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: isArabic
                            ? "ابحث باسم العميل"
                            : "Search by client name",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      onChanged: (value) {
                        searchText = value;
                        applyFilters();
                      },
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedStatusFilter,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                          value: 'all',
                          child: Text(isArabic ? 'الكل' : 'All')),
                      DropdownMenuItem(
                          value: 'new',
                          child: Text(isArabic ? 'جديد' : 'New')),
                      DropdownMenuItem(
                          value: 'delivering',
                          child: Text(
                              isArabic ? 'قيد التوصيل' : 'Delivering')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        selectedStatusFilter = value;
                        applyFilters();
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              /// القائمة
              if (isOrder)
                Expanded(
                  child: GenericBuilder<List<OrderModel?>>(
                    genericCubit: ordersCubit,
                    builder: (ordersData) {
                      if (ordersData.isEmpty) {
                        return Center(
                          child: Text(
                            isArabic ? 'لا توجد طلبات' : 'No orders found',
                            style: AppFonts.apptextStyle,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: ordersData.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final order = ordersData[index];
                          final statusColor = Color(int.parse(
                              '0xff${order?.orderStatus?.color?.substring(1)}'));
                          final statusText = isArabic
                              ? order?.orderStatus?.nameAr ?? ''
                              : order?.orderStatus?.nameEn ?? '';
                          final clientName =
                              '${order?.user?.firstName ?? ''} ${order?.user?.lastName ?? ''}';

                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// رقم الطلب
                                  Text(
                                    '${LocaleKeys.id.tr()}: ${order?.orderNumber ?? ''}',
                                    style: AppFonts.apptextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),

                                  SizedBox(height: 6),

                                  /// اسم العميل
                                  Text(
                                    '${LocaleKeys.clientName.tr()}: $clientName',
                                    style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColors.secondaryFontColor,
                                    ),
                                  ),

                                  /// السعر
                                  Text(
                                    '${LocaleKeys.price.tr()}: ${order?.finalDisplayPrice ?? '0'}',
                                    style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColors.secondaryFontColor,
                                    ),
                                  ),

                                  SizedBox(height: 8),

                                  /// الحالة
                                  Container(
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: Text(
                                      statusText,
                                      style: AppFonts.apptextStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.spMin,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  /// زر التفاصيل
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: AppButton(
                                      title: LocaleKeys.details.tr(),
                                      borderRadius: 8.r,
                                    
                                      onPress: () {
                                        context.router.push(OrderDetailsRoute(
                                            orderId: order?.id ?? ''));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    ),
  );
}

  // Widget mobileDesing() {
    
  //   return Screen(
  //     loadingCubit: loading,
  //     child: GenericBuilder<bool>(
  //         genericCubit: isOrderCubit,
  //         builder: (isOrder) {
  //           return Container(
  //             padding: const EdgeInsets.only(left: 34, right: 34),
  //             width: double.infinity,
  //             height: 1.sh,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   height: 16.h,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           LocaleKeys.ordersManagement.tr(),
  //                           style: AppFonts.apptextStyle.copyWith(
  //                               color: AppColors.black,
  //                               fontWeight: FontWeight.w700,
  //                               fontSize: 14.spMin),
  //                         ),
  //                         SizedBox(
  //                           height: 8.h,
  //                         ),
  //                         SizedBox(
  //                           width: .4.sw,
  //                           child: Text(
  //                             LocaleKeys.ordersManagementHint.tr(),
  //                             style: AppFonts.apptextStyle.copyWith(
  //                                 color: AppColors.black,
  //                                 fontWeight: FontWeight.w400,
  //                                 fontSize: 12.spMin),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     const Spacer(),
  //                     PopupMenuButton(
  //                         position: PopupMenuPosition.under,
  //                         color: Colors.white,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(15.r)),
  //                         constraints: BoxConstraints(minWidth: 220.w),
  //                         itemBuilder: (context) {
  //                           return [
  //                             PopupMenuItem(
  //                               height: 35,
  //                               onTap: () {
  //                                 isOrderCubit.update(data: true);
  //                               },
  //                               child: Text(
  //                                 LocaleKeys.allOrders.tr(),
  //                                 style: AppFonts.apptextStyle.copyWith(),
  //                               ),
  //                             ),
  //                             PopupMenuItem(
  //                                 height: 35,
  //                                 onTap: () {
  //                                   isOrderCubit.update(data: false);
  //                                 },
  //                                 child: Text(
  //                                   LocaleKeys.requestsThatNeedToReReviewed
  //                                       .tr(),
  //                                   style: AppFonts.apptextStyle.copyWith(),
  //                                 )),
  //                           ];
  //                         },
  //                         child: Icon(
  //                           Icons.more_horiz,
  //                         )),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 25.h,
  //                 ),
  //                 if (isOrder)
  //                   GenericBuilder<List<OrderModel?>>(
  //                       genericCubit: ordersCubit,
  //                       builder: (ordersData) {
  //                         return Expanded(
  //                             child: ListView.separated(
  //                                 separatorBuilder: (context, index) {
  //                                   return SizedBox(
  //                                     height: 10.h,
  //                                   );
  //                                 },
  //                                 itemCount: ordersData.length ?? 0,
  //                                 itemBuilder: (context, index) {
  //                                   return OrderItem(order: ordersData[index]);
  //                                 }));
  //                       }),
  //               ],
  //             ),
  //           );
  //         }),
  //   );
  // }
}
/*Widget webDesign() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isTablet = constraints.maxWidth < 1024;

      return Screen(
        loadingCubit: loading,
        child: GenericBuilder<bool>(
          genericCubit: isOrderCubit,
          builder: (isOrder) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  /// ✅ العنوان والفلترة بتنسيق مرن
                  Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.ordersManagement.tr(),
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: isTablet ? 18 : 22,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            LocaleKeys.ordersManagementHint.tr(),
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: isTablet ? 14 : 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: isTablet ? 200 : 250,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? "ابحث باسم العميل"
                                    : "Search by client name",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                              ),
                              onChanged: (value) {
                                searchText = value;
                                applyFilters();
                              },
                            ),
                          ),
                          SizedBox(width: 8.w),
                          DropdownButton<String>(
                            value: selectedStatusFilter,
                            items: [
                              DropdownMenuItem(
                                  value: 'all',
                                  child: Text(isArabic ? 'الكل' : 'All')),
                              DropdownMenuItem(
                                  value: 'new',
                                  child: Text(isArabic ? 'جديد' : 'New')),
                              DropdownMenuItem(
                                  value: 'delivering',
                                  child: Text(isArabic
                                      ? 'قيد التوصيل'
                                      : 'Delivering')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                selectedStatusFilter = value;
                                applyFilters();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// ✅ الجدول
                  if (isOrder)
                    GenericBuilder<List<OrderModel?>>(
                      genericCubit: ordersCubit,
                      builder: (ordersData) {
                        return Expanded(
                          child: DataTable2(
                            dividerThickness: 0,
                            columnSpacing: isTablet ? 8 : 16,
                            dataRowHeight: isTablet ? 60 : 72,
                            headingRowHeight: isTablet ? 48 : 56,
                            columns: [
                              DataColumn2(
                                label: Text(LocaleKeys.id.tr(),
                                    style: tableHeaderStyle),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(LocaleKeys.clientName.tr(),
                                    style: tableHeaderStyle),
                                size: isTablet ? ColumnSize.M : ColumnSize.L,
                                fixedWidth: isTablet ? 200 : 300,
                              ),
                              DataColumn2(
                                label: Text(LocaleKeys.price.tr(),
                                    style: tableHeaderStyle),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(LocaleKeys.status.tr(),
                                    style: tableHeaderStyle),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text(""),
                                size: ColumnSize.S,
                              ),
                            ],
                            rows: ordersData.map((element) {
                              return DataRow2(cells: [
                                DataCell(Text(
                                  element?.orderNumber ?? '',
                                  style: tableRowStyle,
                                )),
                                DataCell(Text(
                                  '${element?.user?.firstName ?? ''} ${element?.user?.lastName ?? ''}',
                                  style: tableRowStyle,
                                )),
                                DataCell(Text(
                                  (element?.finalDisplayPrice ?? '0')
                                      .toString(),
                                  style: tableRowStyle,
                                )),
                                DataCell(Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(int.parse(
                                        '0xff${element?.orderStatus?.color?.substring(1)}')),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isArabic
                                          ? (element?.orderStatus?.nameAr ?? '')
                                          : (element?.orderStatus?.nameEn ??
                                              ''),
                                      style:
                                          AppFonts.apptextStyle.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.spMin),
                                    ),
                                  ),
                                )),
                                DataCell(AppButton(
                                  title: LocaleKeys.details.tr(),
                                  borderRadius: 8.r,
                                  onPress: () {
                                    context.router.push(OrderDetailsRoute(
                                        orderId: element?.id ?? ''));
                                  },
                                )),
                              ]);
                            }).toList(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
 */