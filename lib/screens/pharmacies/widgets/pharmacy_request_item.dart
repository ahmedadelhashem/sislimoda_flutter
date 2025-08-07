import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_request_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class PharmacyRequestItem extends StatefulWidget {
  const PharmacyRequestItem(
      {super.key, this.pharmacy, required this.approvePharmacy});
  final GetPharmacyRequestModelPharmacies? pharmacy;
  final Function approvePharmacy;
  @override
  State<PharmacyRequestItem> createState() => _PharmacyRequestItemState();
}

class _PharmacyRequestItemState extends State<PharmacyRequestItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: double.infinity,
              height: 150,
              child: CustomNetworkImage(
                link: '',
                height: 150,
                width: 336,
              )),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isArabic
                            ? (widget.pharmacy?.pharmacyId?.name?.AR ?? '')
                            : (widget.pharmacy?.pharmacyId?.name?.EN ?? ''),
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    // PopupMenuButton(
                    //     position: PopupMenuPosition.under,
                    //     color: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15.r)),
                    //     constraints: BoxConstraints(minWidth: 220.w),
                    //     itemBuilder: (context) {
                    //       return [
                    //         PopupMenuItem(
                    //             height: 35,
                    //             onTap: () {},
                    //             child: Row(
                    //               children: [
                    //                 SvgPicture.asset(
                    //                   AppImages.update,
                    //                   width: 20,
                    //                   height: 20,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 Text(
                    //                   LocaleKeys.updateProduct.tr(),
                    //                   style: AppFonts.apptextStyle.copyWith(
                    //                       color: AppColors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400),
                    //                 ),
                    //               ],
                    //             )),
                    //         PopupMenuItem(
                    //             height: 35,
                    //             onTap: () {
                    //               // delete();
                    //             },
                    //             child: Row(
                    //               children: [
                    //                 SvgPicture.asset(
                    //                   AppImages.delete,
                    //                   width: 20,
                    //                   height: 20,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 Text(
                    //                   LocaleKeys.deleteProduct.tr(),
                    //                   style: AppFonts.apptextStyle.copyWith(
                    //                       color: AppColors.error,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w400),
                    //                 ),
                    //               ],
                    //             )),
                    //       ];
                    //     },
                    //     child: Icon(
                    //       Icons.more_horiz,
                    //       color: AppColors.secondaryFontColor,
                    //     )),
                  ],
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
                      widget.pharmacy?.pharmacyId?.phone
                              ?.firstWhere(
                                  (element) => element?.mainNumber == true)
                              ?.number ??
                          widget.pharmacy?.pharmacyId?.phone?.first?.number ??
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
                    Expanded(
                      child: Text(
                        widget.pharmacy?.pharmacyId?.email ?? '',
                        maxLines: 1,
                        style: AppFonts.apptextStyle.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: AppColors.mainColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      widget.pharmacy?.approved == true
                          ? LocaleKeys.accepted.tr()
                          : LocaleKeys.waitingForApprove.tr(),
                      maxLines: 5,
                      style: AppFonts.apptextStyle.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    if (widget.pharmacy?.approved == false)
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
                                    widget.approvePharmacy();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.update,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LocaleKeys.approvePharmacy.tr(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                            ];
                          },
                          child: SvgPicture.asset(AppImages.edit))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
