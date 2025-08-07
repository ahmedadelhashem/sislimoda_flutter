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
import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/support_tickets/support_ticket_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen>
    with SupportTicketData {
  @override
  void initState() {
    getAllTickets();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  String selectedStatusId = '0'; // 0 تعني الكل

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
      child: Container(
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
                      LocaleKeys.ticketManagement.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
                                SizedBox(width: 16),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: isArabic ? 'بحث بالاسم...' : 'Search by name...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchText = val.trim();
                      });
                    },
                  ),
                ),
                const Spacer(),
                CustomDropdownNew(
                  title: isArabic ? 'الكل' : 'All',
                  items: statusList
                      .map((element) => Item(
                          key: element.id ?? '',
                          value: isArabic
                              ? (element.nameAr ?? '')
                              : (element.nameEn ?? '')))
                      .toList(),
                  onSelect: (item) {
                    setState(() {
                      selectedStatusId = item.key;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: Container(
                color: Colors.white,
                child: GenericBuilder<List<TicketModel?>>(
                  genericCubit: ordersCubit,
                  builder: (tickets) {
                    // فلترة حسب الاسم والحالة
final filteredTickets = tickets.where((element) {
  final name = (element?.name ?? '').toLowerCase();
  final matchesName = name.contains(searchText.toLowerCase());

  final elementStatusId = element?.ticketStatus?.id ?? '';
  final matchesStatus = selectedStatusId == '0' || selectedStatusId == elementStatusId;

  return matchesName && matchesStatus;
}).toList();

                    return DataTable2(
                      dividerThickness: 0,
                      columns: [
                        DataColumn2(
                          label: Text(
                            LocaleKeys.name.tr(),
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryFontColor),
                          ),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                            label: Text(
                              LocaleKeys.description.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryFontColor),
                            ),
                            size: ColumnSize.L,
                            fixedWidth: 250),
                        DataColumn2(
                            label: Text(
                              LocaleKeys.mobileNumber.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryFontColor),
                            ),
                            size: ColumnSize.L,
                            fixedWidth: 300),
                        DataColumn2(
                          label: Text(
                            LocaleKeys.email.tr(),
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
                      ],
                      rows: filteredTickets.map((element) {
                        return DataRow2(
                            onTap: () {
                              context.router.push(
                                  SupportTicketsDetailsRoute(
                                      ticketId: element?.id ?? ''));
                            },
                            cells: [
                              DataCell(
                                Text(
                                  element?.name ?? '',
                                  maxLines: 2,
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryFontColor),
                                ),
                              ),
                              DataCell(Text(
                                element?.description ?? '',
                                style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryFontColor),
                              )),
                              DataCell(Text(
                                element?.phone ?? '',
                                style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryFontColor),
                              )),
                              DataCell(Text(
                                element?.email ?? '',
                                style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryFontColor),
                              )),
                              DataCell(true
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          height: 40,
                                          child: CustomMultiSelect(
                                              backgroundColor: Color(
                                                  int.tryParse(
                                                          '0xff${element?.ticketStatus?.color?.substring(1)}') ??
                                                      0xffffffff),
                                              isSingle: true,
                                              selectedItems: [
                                                ValueItem(
                                                    label: isArabic
                                                        ? element
                                                                ?.ticketStatus
                                                                ?.nameAr ??
                                                            ''
                                                        : element
                                                                ?.ticketStatus
                                                                ?.nameEn ??
                                                            '',
                                                    value: element
                                                        ?.ticketStatus?.id)
                                              ],
                                              hint: '',
                                              items: itemStatus,
                                              onChange: (List<ValueItem>
                                                  options) {
                                                if (options.isNotEmpty) {
                                                  changeTicketStatus(
                                                      ticketId:
                                                          element?.id ?? '',
                                                      selectedValue: options
                                                          .first.value);
                                                }
                                              }),
                                        ),
                                      ],
                                    )
                                  // ignore: dead_code
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.w, vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: false
                                                  ? Colors.teal
                                                  : Color(int.tryParse(
                                                          '0xff${element?.ticketStatus?.color?.substring(1)}') ??
                                                      0xff000000)),
                                          child: Center(
                                            child: Text(
                                              isArabic
                                                  ? (element?.ticketStatus
                                                          ?.nameAr ??
                                                      'غير معين علي حالة')
                                                  : (element?.ticketStatus
                                                          ?.nameEn ??
                                                      'unassigned to status'),
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12.spMin),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                            ]);
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
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
                ],
              ),
            );
          }),
    );
  }
}