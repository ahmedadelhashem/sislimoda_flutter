import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product, required this.delete});
  final ProductModel product;
  final Function delete;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height: 203,
                child: widget.product.defaultPhoto != null
                    ? CustomNetworkImage(
                        link: widget.product.defaultPhoto?.fullLink ?? '',
                        height: 203,
                        width: 336,
                      )
                    : CustomNetworkImage(
                        link: '',
                        height: 203,
                        width: 336,
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
                              ? (widget.product.name ?? '')
                              : (widget.product.nameEn ?? ''),
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
                      //               widget.delete();
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
                    height: 5,
                  ),
                  Text(
                    isArabic
                        ? (widget.product.description ?? '')
                        : (widget.product.descriptionEn ?? ''),
                    style: AppFonts.apptextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 8,
                  ),
        
                  // Container(
                  //   width: double.infinity,
                  //   height: 32,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey.shade100,
                  //       borderRadius: BorderRadius.circular(8)),
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 14,
                  //       ),
                  //       // SvgPicture.asset(
                  //       //   AppImages.stock,
                  //       //   width: 21,
                  //       //   height: 21,
                  //       // ),
                  //       // SizedBox(
                  //       //   width: 10,
                  //       // ),
                  //       // Text(
                  //       //   '${widget.product.amount} ${LocaleKeys.productInStock.tr()}',
                  //       //   maxLines: 5,
                  //       //   style: AppFonts.apptextStyle.copyWith(
                  //       //       color: Colors.black,
                  //       //       fontSize: 14,
                  //       //       fontWeight: FontWeight.w400),
                  //       // )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 32,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey.shade100,
                  //       borderRadius: BorderRadius.circular(8)),
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 14,
                  //       ),
                  //       SizedBox(
                  //         width: 21,
                  //         child: Transform.scale(
                  //             scaleX: .4,
                  //             scaleY: .4,
                  //             child: CupertinoSwitch(
                  //                 value: true, onChanged: (value) {})),
                  //       ),
                  //       SizedBox(
                  //         width: 14,
                  //       ),
                  //       Text(
                  //         LocaleKeys.available.tr(),
                  //         style: AppFonts.apptextStyle.copyWith(
                  //             color: Colors.black,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
