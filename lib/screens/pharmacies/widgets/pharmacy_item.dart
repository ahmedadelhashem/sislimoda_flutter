
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class PharmacyItem extends StatelessWidget {
  final VendorModel? pharmacy;
  final Function approvePharmacy;

  const PharmacyItem({
    super.key,
    required this.pharmacy,
    required this.approvePharmacy,
  });

  @override
  Widget build(BuildContext context) {
          final  isArabic = Localizations.localeOf(context).languageCode == 'ar';  

    return InkWell(
      onTap: () {
        context.router.push(VendorDetails(vendorId: pharmacy?.id ?? ""));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade300),
        ),
        child: Row(
          children: [
            // الصورة
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: pharmacy?.logoId != null && pharmacy!.logoId!.isNotEmpty
                  ? Image.network(
                      pharmacy!.logoId!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'asset/images/sis.png',
                        width: 50,
                        height: 50,
                      ),
                    )
                  : Image.asset(
                      'asset/images/sis.png',
                      width: 50,
                      height: 50,
                    ),
            ),
            const SizedBox(width: 12),

            // الاسم
            Expanded(
              flex: 2,
              child: Text(
                isArabic ? pharmacy?.name ?? '' : pharmacy?.nameEn ?? '',
                style: AppFonts.apptextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // الهاتف
            Expanded(
              flex: 2,
              child: Text(
                pharmacy?.owner?.phoneNumer ?? LocaleKeys.noPhoneNumber.tr(),
                style: const TextStyle(fontSize: 14),
                maxLines: 1,
              ),
            ),

            // الإيميل
            Expanded(
              flex: 3,
              child: Text(
                pharmacy?.owner?.userName ?? '',
                style: const TextStyle(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // الحالة
            Row(
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: Color(
                    int.parse(
                      '0xff${pharmacy?.vendorStatus?.color?.substring(1) ?? '999999'}',
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  isArabic
                      ? pharmacy?.vendorStatus?.nameAr ?? ''
                      : pharmacy?.vendorStatus?.nameEn ?? '',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/models/pharmacy/get_pharmacy_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class PharmacyItem extends StatefulWidget {
  const PharmacyItem(
      {super.key, required this.pharmacy, required this.approvePharmacy});
  final VendorModel? pharmacy;
  final Function approvePharmacy;
  @override
  State<PharmacyItem> createState() => _PharmacyItemState();
}

class _PharmacyItemState extends State<PharmacyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(VendorDetails(vendorId: widget.pharmacy?.id ?? ""));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white,
             border: Border.all(
    color: Colors.red.withOpacity(1), // أحمر خفيف
    width: 1.5,
  ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height: 150,
               child: widget.pharmacy?.logoId != null && widget.pharmacy!.logoId!.isNotEmpty
    ? CustomNetworkImage(
        link: widget.pharmacy!.logoId!,
        height: 150,
        width: 336,
      )
    : Image.asset(
        'asset/images/sis.png',
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      ),

                ),
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
                              ? (widget.pharmacy?.name ?? '')
                              : (widget.pharmacy?.nameEn ?? ''),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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
                        widget.pharmacy?.owner?.phoneNumer ??
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
                          widget.pharmacy?.owner?.userName ?? '',
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
                        backgroundColor: Color(int.parse(
                            '0xff${widget.pharmacy?.vendorStatus?.color?.substring(1)}')),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        isArabic
                            ? widget.pharmacy?.vendorStatus?.nameAr ?? ''
                            : widget.pharmacy?.vendorStatus?.nameEn ?? '',
                        maxLines: 5,
                        style: AppFonts.apptextStyle.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      // if (widget.pharmacy?.isApproved == false)
                      //   PopupMenuButton(
                      //       position: PopupMenuPosition.under,
                      //       color: Colors.white,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(15.r)),
                      //       constraints: BoxConstraints(minWidth: 220.w),
                      //       itemBuilder: (context) {
                      //         return [
                      //           PopupMenuItem(
                      //               height: 35,
                      //               onTap: () {
                      //                 widget.approvePharmacy();
                      //               },
                      //               child: Row(
                      //                 children: [
                      //                   SvgPicture.asset(
                      //                     AppImages.update,
                      //                     width: 20,
                      //                     height: 20,
                      //                   ),
                      //                   SizedBox(
                      //                     width: 10,
                      //                   ),
                      //                   Text(
                      //                     LocaleKeys.approvePharmacy.tr(),
                      //                     style: AppFonts.apptextStyle.copyWith(
                      //                         color: AppColors.black,
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w400),
                      //                   ),
                      //                 ],
                      //               )),
                      //         ];
                      //       },
                      //       child: SvgPicture.asset(AppImages.edit))
                    ],
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
*/