import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/screens/support_tickets/support_ticket_dtails/support_ticket_details.dart';
import 'package:sislimoda_admin_dashboard/screens/support_tickets/support_ticket_dtails/widgets/reply_item.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class SupportTicketsDetailsScreen extends StatefulWidget {
  const SupportTicketsDetailsScreen(
      {super.key, @pathParam required this.ticketId});
  final String ticketId;
  @override
  State<SupportTicketsDetailsScreen> createState() =>
      _SupportTicketsDetailsScreenState();
}

class _SupportTicketsDetailsScreenState
    extends State<SupportTicketsDetailsScreen> with SupportTicketDetailsData {
  @override
  void initState() {
    // TODO: implement initState
    getTicket(ticketId: widget.ticketId);
    getAllStatus();
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: Screen(
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
                          LocaleKeys.ticketManagement.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                           
                        // Text(
                        //   LocaleKeys.ordersManagementHint.tr(),
                        //   style: AppFonts.apptextStyle.copyWith(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 16),
                        // )
                      ],
                    ),const Spacer(),
                    SizedBox(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppColors.black,
                            size: 20.sp,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Expanded(
                  child: GenericBuilder(
                      genericCubit: ticketCubit,
                      builder: (ticket) {
                        return Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 24.h),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${LocaleKeys.name.tr()} : ${ticket.appUser?.firstName ?? ''} ${ticket.appUser?.lastName ?? ''}',
                                          style: AppFonts.apptextStyle
                                              .copyWith(fontSize: 16.sp),
                                        ),
                                      ),
                                      GenericBuilder(
                                          genericCubit: statusCubit,
                                          builder: (status) {
                                            return SizedBox(
                                              width: 200,
                                              height: 40,
                                              child: CustomMultiSelect(
                                                  backgroundColor: Color(
                                                      int.tryParse(
                                                              '0xff${ticket.ticketStatus?.color?.substring(1)}') ??
                                                          0xffffffff),
                                                  isSingle: true,
                                                  selectedItems: [
                                                    ValueItem(
                                                        label: isArabic
                                                            ? ticket.ticketStatus
                                                                    ?.nameAr ??
                                                                ''
                                                            : ticket.ticketStatus
                                                                    ?.nameEn ??
                                                                '',
                                                        value: ticket
                                                            .ticketStatus?.id)
                                                  ],
                                                  hint: '',
                                                  items: status,
                                                  onChange: (List<ValueItem>
                                                      options) {
                                                    if (options.isNotEmpty) {
                                                      changeTicketStatus(
                                                          ticketId:
                                                              ticket.id ?? '',
                                                          selectedValue: options
                                                              .first.value);
                                                    }
                                                  }),
                                            );
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${LocaleKeys.email.tr()} : ${ticket.email ?? ''} ',
                                    style: AppFonts.apptextStyle
                                        .copyWith(fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${LocaleKeys.mobileNumber.tr()} : ${ticket.phone ?? ''} ',
                                    style: AppFonts.apptextStyle
                                        .copyWith(fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${LocaleKeys.description.tr()} : ${ticket.description ?? ''} ',
                                    style: AppFonts.apptextStyle
                                        .copyWith(fontSize: 16.sp),
                                  ),
                                ],
                              )),
                              VerticalDivider(),
                              Expanded(
                                  child: Column(
                                children: [
                                  Expanded(
                                      child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            return ReplyItem(
                                              reply: ticket.ticketReply![index],
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 5,
                                            );
                                          },
                                          itemCount:
                                              ticket.ticketReply?.length ?? 0)),
                                  if (ticket.ticketStatus?.value != '4')
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          controller: messageController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12.w),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black54),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GenericBuilder(
                                            genericCubit: sendCubit,
                                            builder: (isSending) {
                                              return SizedBox(
                                                height: 40.h,
                                                child: isSending
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    20.w),
                                                        child:
                                                            CupertinoActivityIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: 100.w,
                                                        child: AppButton(
                                                          onPress: () => addReply(
                                                              appUserId:
                                                                  BlocProvider.of<UserCubit>(
                                                                              context)
                                                                          .user
                                                                          ?.id ??
                                                                      ''),
                                                          title: isArabic
                                                              ? "إضافة رد"
                                                              : "Add Reply",
                                                          titleFontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          borderRadius: 12,
                                                        ),
                                                      ),
                                              );
                                            }),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 40.h,
                                  )
                                ],
                              ))
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
