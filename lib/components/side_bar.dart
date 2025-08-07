import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/general/side_bar_model.dart';
import 'package:sislimoda_admin_dashboard/models/vendor_models/vendor_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';
import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  
  GenericCubit<SideBarModel> sidebarCubit = GenericCubit<SideBarModel>();
  List<SideBarModel> sideBarItems = [
    
    SideBarModel(
      title: LocaleKeys.overview,
      icon: AppImages.overview,
      goto: const OverviewRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.orders,
      icon: AppImages.orders,
      goto: const Orders(),
    ),
    SideBarModel(
      title: LocaleKeys.offers,
      icon: AppImages.offers,
      goto: const OffersRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.products,
      icon: AppImages.products,
      goto: const Products(),
    ),
    SideBarModel(
      title: LocaleKeys.vendors,
      icon: AppImages.pharmacies,
      goto: const PharmaciesRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.users,
      icon: AppImages.users,
      goto: const UsersRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.categories,
      icon: AppImages.categories,
      goto: const Categories(),
    ),

    SideBarModel(
        title: true
            ? LocaleKeys.coupon
            : isArabic
                ? 'إدارة الكوبونات'
                : "Coupon management",
        icon: AppImages.discount,
        goto: const Coupons()),
    SideBarModel(
        title: true
            ? LocaleKeys.chat
            : isArabic
                ? 'الدعم الفني'
                : "Technical Support",
        icon: AppImages.chat,
        goto: const ChatsRoute()),
    SideBarModel(
        title: LocaleKeys.ticketManagement,
        icon: AppImages.support,
        goto: const SupportTicketsRoute()),
    SideBarModel(
        title: LocaleKeys.settings,
        icon: AppImages.settings,
        goto: const SettingsRoute()),
    SideBarModel(
        title: LocaleKeys.banners,
        icon: AppImages.banner,
        goto: const BannersRoute()),
    SideBarModel(
        title: LocaleKeys.reviews,
        icon: AppImages.feedback,
        goto: const ReviewsRoute()),
    SideBarModel(
      title: LocaleKeys.statistics,
      icon: AppImages.overview,
      goto: const BrandsRoute(),
    ),
//         SideBarModel(
//   title:LocaleKeys.vendor_statistics,
//   icon: AppImages.overview,
//   goto: const VendorStatisticsRoute(),
// ),
SideBarModel(
  title: isArabic ? 'إعلانات البنوك' : 'Bank Ads', 
  icon: AppImages.banner, 
  goto: const BankAdsRoute(),
),

  ];

  @override
  void initState() {
     super.initState();
    if (context.router.currentUrl.toLowerCase().contains('overview')) {
      sidebarCubit.update(data: sideBarItems.first);
    } else if (context.router.currentUrl
            .toLowerCase()
            .contains('orderdetails') ||
        context.router.currentUrl.toLowerCase().contains('orders')) {
      sidebarCubit.update(data: sideBarItems[1]);
    } else if (context.router.currentUrl.toLowerCase().contains('offers')) {
      sidebarCubit.update(data: sideBarItems[2]);
    } else if (context.router.currentUrl.toLowerCase().contains('products')) {
      sidebarCubit.update(data: sideBarItems[3]);
    } else if (context.router.currentUrl.toLowerCase().contains('vendors')) {
      sidebarCubit.update(data: sideBarItems[4]);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('vendordetails')) {
      sidebarCubit.update(data: sideBarItems[4]);
    } else if (context.router.currentUrl.toLowerCase().contains('users')) {
      sidebarCubit.update(data: sideBarItems[5]);
    } else if (context.router.currentUrl.toLowerCase().contains('categories')) {
      sidebarCubit.update(data: sideBarItems[6]);
    }  else if (context.router.currentUrl.toLowerCase().contains('coupons')) {
      sidebarCubit.update(data: sideBarItems[7]);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('customersupport')) {
      sidebarCubit.update(data: sideBarItems[8]);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('supporttickets')) {
      sidebarCubit.update(data: sideBarItems[9]);
    } else if (context.router.currentUrl.toLowerCase().contains('settings')) {
      sidebarCubit.update(data: sideBarItems[10]);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('optionsetitemdetailsroute')) {
      sidebarCubit.update(data: sideBarItems[10]);
    } else if (context.router.currentUrl.toLowerCase().contains('banners')) {
      sidebarCubit.update(data: sideBarItems[11]);
    } else if (context.router.currentUrl.toLowerCase().contains('reviews')) {
      sidebarCubit.update(data: sideBarItems[12]);
    }
    else if (context.router.currentUrl.toLowerCase().contains('brands')) {
      sidebarCubit.update(data: sideBarItems[13]);
    }
//     else if (context.router.currentUrl.toLowerCase().contains('vendorStatistics')) {
//   sidebarCubit.update(data: sideBarItems.last);
// }
    else if (context.router.currentUrl.toLowerCase().contains('bankads')) {
      sidebarCubit.update(data: sideBarItems.last);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return GenericBuilder<SideBarModel>(
        genericCubit: sidebarCubit,
        builder: (selectedItem) {
          currentSideBarContext = context;
          return Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            padding:
                EdgeInsets.only(top: 24, bottom: 45, right: 10, left: 10.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                context.isMobile
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 54,
                            width: 161,
                            color: Colors.red,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 54,
                            color: Colors.red,
                            width: 200,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                SizedBox(
                  height: 16,
                ),
                Divider(),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView(
                    children: sideBarItems
                        .map((e) => SideBarItem(
                              isSelected: selectedItem == e,
                              sideBarItem: e,
                              selectIetem: () {
                                sidebarCubit.update(data: e);
                              },
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    CustomAlert.showConfirmDialogue(
                        confirmDone: () async {
                          SharedPreferences ref =
                              await SharedPreferences.getInstance();
                          ref.remove(LocalStoreNames.userToken);
                          context.router.replace(LoginRoute());
                        },
                        message: isArabic
                            ? 'هل أنت متأكد من تسجيل الخروج ؟'
                            : 'Are you sure to logout ?',
                        context: context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      SvgPicture.asset(
                        AppImages.logout,
                        width: 20.5,
                        height: 20.5,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        LocaleKeys.logout.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.secondaryFontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class SideBarItem extends StatelessWidget {
  const SideBarItem(
      {super.key,
      required this.sideBarItem,
      required this.isSelected,
      required this.selectIetem});
  final SideBarModel sideBarItem;
  final bool isSelected;
  final Function selectIetem;

  @override
  Widget build(BuildContext context) {
  final bool isReceiveOrderItem = sideBarItem.title == LocaleKeys.receiveOrder;
    return InkWell(
      // onTap: isSelected
      //     ? null
      //     : () {
      //         context.router.push(sideBarItem.goto);
      //         if (context.isMobile) {
      //           Navigator.pop(context);
      //         }
      //         selectIetem();
      //       },
      onTap: () {
        context.router.push(sideBarItem.goto);
        if (context.isMobile) {
          Navigator.pop(context);
        }
        selectIetem();
      },
      child: Container(
        width: double.infinity,
        height: context.isMobile ? 40.h : 56.h,
        padding: EdgeInsets.only(left: 26.w, right: 26.w),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.mainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            SvgPicture.asset(
              sideBarItem.icon,
              color: isSelected ? Colors.white : AppColors.secondaryFontColor,
              width: 20.5,
              height: 20.5,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        sideBarItem.title.tr(),
        style: AppFonts.apptextStyle.copyWith(
          color: isSelected ? Colors.white : AppColors.secondaryFontColor,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
      if (isReceiveOrderItem)
        BlocBuilder<GenericCubit<int>, GenericState<int>>(
          bloc: VendorSideBarState.newOrdersCountCubit,
          builder: (context, state) {
            final count = state.data ?? 0;
            if (count == 0) return SizedBox.shrink();
            return Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.red, // ✅ لون حسب التحديد
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.white, 
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}

class VendorSideBar extends StatefulWidget {
  const VendorSideBar({super.key});

  @override
  State<VendorSideBar> createState() => VendorSideBarState();
}

class VendorSideBarState extends State<VendorSideBar> {
  static  GenericCubit<int> newOrdersCountCubit = GenericCubit<int>(data: 0);
  static GenericCubit<SideBarModel> sidebarCubit = GenericCubit<SideBarModel>();
  static List<SideBarModel> sideBarItems = [
    SideBarModel(
      title: LocaleKeys.profile,
      icon: AppImages.users,
      goto: const VendorProfileRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.receiveOrder,
      icon: AppImages.orders,
      goto: const VendorOrdersRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.addProducts,
      icon: AppImages.products,
      goto: const AddProductsNewRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.stocks,
      icon: AppImages.products,
      goto: const VendorProductsRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.messageManager,
      icon: AppImages.chat,
      goto: const VendorMessagesRoute(),
    ),
    SideBarModel(
      title: LocaleKeys.statistics,
      icon: AppImages.overview,
      goto: const VendorOverviewRoute(),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    setItems(context: context);
    super.initState();
  }

  static setItems({required BuildContext context}) {
    if (context.router.currentUrl.toLowerCase().contains('vendorprofile')) {
      sidebarCubit.update(data: sideBarItems.first);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('vendoroverview')) {
      sidebarCubit.update(data: sideBarItems[5]);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('addproducts')) {
      sidebarCubit.update(data: sideBarItems[2]);
    } else if (context.router.currentUrl
            .toLowerCase()
            .contains('vendororders') ||
        context.router.currentUrl.toLowerCase().contains('orderdetails')) {
      sidebarCubit.update(data: sideBarItems[1]);
    } else if (context.router.currentUrl
        .toLowerCase()
        .contains('vendorproducts')) {
      sidebarCubit.update(data: sideBarItems[3]);
    } else if (context.router.currentUrl.toLowerCase().contains('vendorchat')) {
      sidebarCubit.update(data: sideBarItems[4]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericBuilder<SideBarModel>(
        genericCubit: sidebarCubit,
        builder: (selectedItem) {
          currentSideBarContext = context;
          return Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            padding:
                EdgeInsets.only(top: 24, bottom: 45, right: 10, left: 10.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: ListView(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                context.isMobile
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 54,
                            width: 161,
                            color: Colors.red,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 54,
                            color: Colors.red,
                            width: 200,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                SizedBox(
                  height: 16,
                ),
                Divider(),
                SizedBox(
                  height: 24,
                ),
                Column(
                  children: sideBarItems
                      .map((e) => SideBarItem(
                            isSelected: selectedItem == e,
                            sideBarItem: e,
                            selectIetem: () {
                              sidebarCubit.update(data: e);
                            },
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    //https://sislimoda.com/api/Vendor/UpdateStatus?Id=b723b1b0-cbd9-49b7-8c0b-08dd8e7ace5f&Value=5&Name=vendorstatus
                    SharedPreferences ref =
                        await SharedPreferences.getInstance();
                    String? userId = ref.getString('vendorId');

                    CustomAlert.showConfirmDialogue(
                        confirmDone: () {
                          AppService.callService(
                              actionType: ActionType.post,
                              apiName:
                                  'api/Vendor/UpdateStatus?Id=$userId&Value=5&Name=vendorstatus',
                              body: {});
                        },
                        message: isArabic
                            ? 'هل انت متاكد من الغاء اشتراكك'
                            : 'Are you sure to cancel subscription',
                        context: context);

                    // CustomAlert.showConfirmDialogue(
                    //     confirmDone: () async {
                    //       SharedPreferences ref =
                    //           await SharedPreferences.getInstance();
                    //       ref.remove(LocalStoreNames.userToken);
                    //       context.router.push(LoginRoute());
                    //     },
                    //     message: isArabic
                    //         ? 'هل أنت متأكد من تسجيل الخروج ؟'
                    //         : 'Are you sure to logout ?',
                    //     context: context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      SvgPicture.asset(
                        AppImages.warning,
                        width: 20.5,
                        height: 20.5,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        LocaleKeys.cancelSubscription.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.secondaryFontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    CustomAlert.showConfirmDialogue(
                        confirmDone: () async {
                          SharedPreferences ref =
                              await SharedPreferences.getInstance();
                          ref.remove(LocalStoreNames.userToken);
                          context.router.push(LoginRoute());
                        },
                        message: isArabic
                            ? 'هل أنت متأكد من تسجيل الخروج ؟'
                            : 'Are you sure to logout ?',
                        context: context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      SvgPicture.asset(
                        AppImages.logout,
                        width: 20.5,
                        height: 20.5,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        LocaleKeys.logout.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.secondaryFontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

bool checkIfProfileNotCompleted({required VendorModel vendor}) {
  if (vendor.companyName != null && vendor.companyName != '') {
    return false;
  } else if (vendor.bankName != null && vendor.bankName != '') {
    return false;
  } else if (vendor.bankNumber != null && vendor.bankNumber != '') {
    return false;
  } else if (vendor.iban != null && vendor.iban != '') {
    return false;
  } else if (vendor.fullCompanyAddress != null &&
      vendor.fullCompanyAddress != '') {
    return false;
  } else if (vendor.vendorCompanyAttachments != null &&
      vendor.vendorCompanyAttachments!.isEmpty) {
    return false;
  } else {
    return true;
  }
}
