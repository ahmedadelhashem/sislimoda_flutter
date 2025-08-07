import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/data/gobal_cubits.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class ReplyItem extends StatelessWidget {
  const ReplyItem({super.key, required this.reply});
  final TicketModelTicketReply? reply;
  @override
  Widget build(BuildContext context) {
    bool isFromUser =
        reply?.appUserId == BlocProvider.of<UserCubit>(context).user?.id;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // if(isFromUser!)
          //   Container(clipBehavior: Clip.antiAlias,
          //     width: 30.h,
          //     height: 30.h,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(7.r)
          //     ),
          //     child: CustomNetworkImage(
          //       link: message.securityGuard!.securityGuard!.photo!.fullLink.toString(),
          //     ),
          //   ),
          SizedBox(
            width: 10.w,
          ),
          Material(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
              bottomLeft: Radius.circular((isFromUser && isArabic)
                  ? 0.r
                  : (isFromUser && !isArabic)
                      ? 15.r
                      : (!isFromUser && isArabic)
                          ? 15.r
                          : (!isFromUser && !isArabic)
                              ? 0
                              : 15),
              bottomRight: Radius.circular(!(isFromUser && isArabic)
                  ? 15.r
                  : !(isFromUser && !isArabic)
                      ? 15.r
                      : !(!isFromUser && isArabic)
                          ? 15.r
                          : !(!isFromUser && !isArabic)
                              ? 0
                              : 15),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: .3.sw),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                  color: !isFromUser
                      ? AppColors.mainColor
                      : AppColors.secondaryFontColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular((isFromUser && isArabic)
                        ? 0.r
                        : (isFromUser && !isArabic)
                            ? 10.r
                            : (!isFromUser && isArabic)
                                ? 10.r
                                : (!isFromUser && !isArabic)
                                    ? 0
                                    : 10),
                    bottomRight: Radius.circular(!(isFromUser && isArabic)
                        ? 0.r
                        : !(isFromUser && !isArabic)
                            ? 10.r
                            : !(!isFromUser && isArabic)
                                ? 10.r
                                : !(!isFromUser && !isArabic)
                                    ? 0
                                    : 10),
                  )),
              child: Text(
                reply?.message ?? '',
                style: GoogleFonts.roboto(
                    color: !isFromUser ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
