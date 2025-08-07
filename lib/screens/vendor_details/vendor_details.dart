import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor_details/vendor_details_data.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor_details/widgets/statistics.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor_details/widgets/vendor_orders.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor_details/widgets/vendor_products.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

@RoutePage()
class VendorDetails extends StatefulWidget {
  const VendorDetails({super.key, @pathParam required this.vendorId});
  final String vendorId;
  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> with VendorDetailsData {
  @override
  void initState() {
    // TODO: implement initState
    getVendor(vendorId: widget.vendorId);
    getVendorsProducts(vendorId: widget.vendorId);
    getVendorsOrders(vendorId: widget.vendorId);
    getVendorStatus();

    super.initState();
  }
/*
  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
          ),
          body: Container(
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
                          LocaleKeys.clientManagement.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          LocaleKeys.clientManagementHint.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: context.isMobile ? 12.spMin : 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          context.router.back();
                        },
                        icon: Icon(Icons.arrow_forward))
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                GenericBuilder(
                    genericCubit: vendorCubit,
                    builder: (vendor) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                child: CustomNetworkImage(
                                    link: vendor.baner?.fullLink ?? '',
                                    height: 250,
                                    width: 250),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isArabic
                                          ? (vendor.name ?? '')
                                          : (vendor.nameEn ?? ''),
                                      style: AppFonts.apptextStyle.copyWith(
                                          color: AppColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.phone),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          vendor.owner?.phoneNumer ??
                                              LocaleKeys.noPhoneNumber.tr(),
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              height: 1.8,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.email,
                                          width: 18,
                                          height: 18,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          vendor.owner?.userName ?? '',
                                          maxLines: 1,
                                          style: AppFonts.apptextStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    GenericBuilder(
                                        genericCubit: statusCubit,
                                        builder: (status) {
                                          return SizedBox(
                                            width: 300,
                                            child: CustomMultiSelect(
                                                isSingle: true,
                                                selectedItems: [
                                                  ValueItem(
                                                      label: vendor.vendorStatus
                                                              ?.nameAr ??
                                                          '',
                                                      value: vendor
                                                          .vendorStatus?.id)
                                                ],
                                                hint: '',
                                                items: status,
                                                onChange:
                                                    (List<ValueItem> options) {
                                                  if (options.isNotEmpty) {
                                                    changeVendorStatus(
                                                        vendorId:
                                                            widget.vendorId,
                                                        selectedValue: options
                                                            .first.value);
                                                  }
                                                }),
                                          );
                                        })
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //       width: 4,
                                    //     ),
                                    //     CircleAvatar(
                                    //       radius: 6,
                                    //       backgroundColor: Color(int.parse(
                                    //           '0xff${vendor.vendorStatus?.color?.substring(1)}')),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 16,
                                    //     ),
                                    //     Text(
                                    //       isArabic
                                    //           ? vendor.vendorStatus?.nameAr ??
                                    //               ''
                                    //           : vendor.vendorStatus?.nameEn ??
                                    //               '',
                                    //       maxLines: 5,
                                    //       style: AppFonts.apptextStyle.copyWith(
                                    //           color: Colors.black,
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.w400),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: .55.sh,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            // padding: EdgeInsets.all(10),
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Row(
                                //   children: [
                                //     const SizedBox(
                                //       width: 30,
                                //     ),
                                //     Text(
                                //       isArabic ? 'لوحه التحكم' : 'Leaderboard',
                                //       textAlign: TextAlign.center,
                                //       style: AppFonts.apptextStyle.copyWith(
                                //           color: Colors.black,
                                //           fontSize: 18,
                                //           fontWeight: FontWeight.w600),
                                //     ),
                                //     const SizedBox(
                                //       width: 16,
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: .48.sh,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: DefaultTabController(
                                      length: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TabBar(
                                            dividerColor: Colors.transparent,
                                            indicatorPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 6, horizontal: 0),
                                            tabAlignment: TabAlignment.start,
                                            isScrollable: true,
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            indicator: BoxDecoration(
                                                color: const Color(0xffEBF4FF),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            labelStyle: AppFonts.apptextStyle
                                                .copyWith(
                                                    color: Color(0xff003B7E),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            unselectedLabelStyle:
                                                AppFonts.apptextStyle.copyWith(
                                                    color: Color(0xff556377),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            tabs: [
                                              Tab(
                                                text: isArabic
                                                    ? 'طلبات البائع'
                                                    : 'Vendors order',
                                              ),
                                              Tab(
                                                text: isArabic
                                                    ? 'منتجات البائع'
                                                    : 'Vendor product',
                                              ),
                                              // Tab(
                                              //   text: isArabic
                                              //       ? 'الإحصائيات'
                                              //       : 'Statistics',
                                              // )
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                GenericBuilder(
                                                    genericCubit:
                                                        vendorOrdersCubit,
                                                    builder: (orders) {
                                                      return VendorOrders(
                                                        orders: orders,
                                                      );
                                                    }),
                                                GenericBuilder(
                                                    genericCubit:
                                                        vendorProductsCubit,
                                                    builder: (products) {
                                                      return VendorProducts(
                                                        products: products,
                                                      );
                                                    }),
                                                // Statistics(dataSource: [],)
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          )),
    );
  }
}
*/

  @override
  Widget build(BuildContext context) {
          final  isArabic = Localizations.localeOf(context).languageCode == 'ar';  

    return Screen(
      loadingCubit: loading,
      child: Scaffold(
        appBar: AppBarCustom(ctx: context),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.clientManagement.tr(),
                                style: AppFonts.apptextStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.isMobile ? 14.spMin : 22,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                LocaleKeys.clientManagementHint.tr(),
                                style: AppFonts.apptextStyle.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.isMobile ? 12.spMin : 16,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => context.router.back(),
                            icon: const Icon(Icons.arrow_forward),
                          )
                        ],
                      ),
                      SizedBox(height: 25.h),
                      GenericBuilder(
                        genericCubit: vendorCubit,
                        builder: (vendor) {
                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CustomNetworkImage(
                                          link: vendor.baner?.fullLink ?? '',
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              isArabic
                                                  ? vendor.name ?? ''
                                                  : vendor.nameEn ?? '',
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Row(
                                              children: [
                                                Icon(Icons.phone,
                                                    size: 18,
                                                    color: Colors.grey),
                                                SizedBox(width: 8),
                                                Text(
                                                  vendor.owner?.phoneNumer ??
                                                      LocaleKeys.noPhoneNumber
                                                          .tr(),
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.email_outlined,
                                                    size: 18,
                                                    color: Colors.grey),
                                                SizedBox(width: 8),
                                                Text(
                                                  vendor.owner?.userName ?? '',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12),
                                            GenericBuilder(
                                              genericCubit: statusCubit,
                                              builder: (status) {
                                                return CustomMultiSelect(
                                                  isSingle: true,
                                                  selectedItems: [
                                                    ValueItem(
                                                      label:isArabic?vendor.vendorStatus
                                                              ?.nameAr ??'' : vendor.vendorStatus?.nameEn ?? '',
                                                          
                                                      value: vendor
                                                          .vendorStatus?.id,
                                                    )
                                                  ],
                                                  hint: '',
                                                  items: status,
                                                  onChange: (options) {
                                                    if (options.isNotEmpty) {
                                                      changeVendorStatus(
                                                        vendorId:
                                                            widget.vendorId,
                                                        selectedValue:
                                                            options.first.value,
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(height: 12),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    title: Text(isArabic
                                                        ? 'تفاصيل إضافية'
                                                        : 'More Details'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "الاسم بالعربي"
                                                                : "Name (AR)",
                                                            vendor.name,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "الاسم بالإنجليزية"
                                                                : "Name (EN)",
                                                            vendor.nameEn,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "الوصف بالعربي"
                                                                : "Description (AR)",
                                                            vendor.description,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "الوصف بالإنجليزية"
                                                                : "Description (EN)",
                                                            vendor
                                                                .descriptionEn,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "رقم الهاتف الأول"
                                                                : "Phone 1",
                                                            vendor
                                                                .ownerPhoneNumber,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "رقم الهاتف الثاني"
                                                                : "Phone 2",
                                                            vendor
                                                                .ownerPhoneNumber2,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "اسم الشركة"
                                                                : "Company Name",
                                                            vendor.companyName,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "عنوان الشركة"
                                                                : "Company Address",
                                                            vendor
                                                                .fullCompanyAddress,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "عدد المنتجات المسموح بيعها"
                                                                : "Allowed Products",
                                                            vendor
                                                                .numberOfProductsToSell,
                                                          ),
                                                          _buildInfoItem(
                                                            isArabic
                                                                ? "اسم البنك"
                                                                : "Bank Name",
                                                            vendor.bankName,
                                                          ),
                                                          SizedBox(height: 16),
                                                          Divider(),
                                                          Text(
                                                            isArabic
                                                                ? "المرفقات"
                                                                : "Attachments",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(height: 8),
                                                          if (vendor.vendorCompanyAttachments !=
                                                                  null &&
                                                              vendor
                                                                  .vendorCompanyAttachments!
                                                                  .isNotEmpty)
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: vendor
                                                                  .vendorCompanyAttachments!
                                                                  .map((attachment) =>
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(Icons.attach_file,
                                                                                size: 16),
                                                                            SizedBox(width: 6),
                                                                            Expanded(
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  final url = attachment?.attachment?.fullLink;
                                                                                  if (url != null && url.isNotEmpty) {
                                                                                    html.window.open(url, '_blank');
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  attachment?.attachment?.name ?? '',
                                                                                  style: TextStyle(
                                                                                    color: Colors.blue,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                            )
                                                          else
                                                            Text(isArabic
                                                                ? "لا يوجد مرفقات"
                                                                : "No attachments"),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text(isArabic
                                                            ? 'إغلاق'
                                                            : 'Close'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.info_outline),
                                              label: Text(isArabic
                                                  ? 'عرض التفاصيل'
                                                  : 'View Details'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue.shade700,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                      // التاب بار
                      TabBar(
                        indicator: BoxDecoration(
                          color: const Color(0xffEBF4FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        labelColor: const Color(0xff003B7E),
                        unselectedLabelColor: const Color(0xff556377),
                        tabs: [
                          Tab(
                              text:
                                  isArabic ? 'طلبات البائع' : 'Vendor Orders'),
                          Tab(
                              text: isArabic
                                  ? 'منتجات البائع'
                                  : 'Vendor Products'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: TabBarView(
                children: [
                  GenericBuilder(
                    genericCubit: vendorOrdersCubit,
                    builder: (orders) => VendorOrders(orders: orders),
                  ),
                  GenericBuilder(
                    genericCubit: vendorProductsCubit,
                    builder: (products) => VendorProducts(products: products),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String? value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Text(value?.isNotEmpty == true ? value! : "-"),
          ),
        ],
      ),
    );
  }
}
