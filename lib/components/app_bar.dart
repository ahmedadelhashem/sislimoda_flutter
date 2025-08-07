import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/add_notification.dart';
import 'package:sislimoda_admin_dashboard/components/chat_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/cubits/chat_cubit/chat_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/notofications/notifications_request_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class AppBarCustom extends PreferredSize {
  AppBarCustom({super.key, required this.ctx, this.search})
      : super(child: Container(), preferredSize: const Size.fromHeight(120));
  final BuildContext ctx;
  final Function(String)? search;

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? mobileDesign() : webDesign();
  }

  Widget webDesign() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      width: 400.w,
      height: 60,
      child: Row(
        children: [
          const SizedBox(
            width: 34,
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Text(
                '${LocaleKeys.hello.tr()} , ${state is UserLoaded ? state.user.firstName : ''}',
                style: AppFonts.apptextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              );
            },
          ),
          const Spacer(),
          if (search != null)
            SizedBox(
              width: 400,
              height: 48,
              child: SearchBar(
                onChanged: search ?? (text) {},
                hintText: '${LocaleKeys.search.tr()}...',
                hintStyle: MaterialStateProperty.all(AppFonts.apptextStyle
                    .copyWith(
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                textStyle: MaterialStateProperty.all(AppFonts.apptextStyle
                    .copyWith(
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16)),
                leading: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(AppImages.search),
                  ],
                ),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
            ),
          SizedBox(
            width: 16.w,
          ),
PopupMenuButton<Locale>(
  tooltip: 'Change Language',
  offset: const Offset(0, 40), // تحكم في مكان القائمة المنسدلة
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  icon: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.white,
    ),
    child: Icon(
      Icons.language,
      color: AppColors.secondaryFontColor,
      size: 24,
    ),
  ),
  onSelected: (locale) {
    ctx.setLocale(locale);
    currentSideBarContext.setLocale(locale);
  },
  itemBuilder: (context) => [
    PopupMenuItem(
      value: const Locale('ar'),
      child: Text('العربية',
          style: AppFonts.apptextStyle.copyWith(fontWeight: FontWeight.w500)),
    ),
    PopupMenuItem(
      value: const Locale('en'),
      child: Text('English',
          style: AppFonts.apptextStyle.copyWith(fontWeight: FontWeight.w500)),
    ),
    PopupMenuItem(
      value: const Locale('tr'),
      child: Text('Türkçe',
          style: AppFonts.apptextStyle.copyWith(fontWeight: FontWeight.w500)),
    ),
  ],
),


          SizedBox(
            width: 16.w,
          ),
          // BlocBuilder<NotofocationsCubit, NotofocationsState>(
          //   builder: (context, state) {
          //     return PopupMenuButton(
          //       position: PopupMenuPosition.under,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15.r)),
          //       constraints: BoxConstraints(minWidth: 400.w, maxHeight: .4.sh),
          //       itemBuilder: (ctx) {
          //         List<PopupMenuEntry> notifications = [
          //           PopupMenuItem(
          //             onTap: null,
          //             enabled: false,
          //             child: Row(
          //               children: [
          //                 Spacer(),
          //                 IconButton(
          //                     onPressed: () {
          //                       Navigator.pop(ctx);
          //                       showDialog(
          //                           context: context,
          //                           builder: (context) {
          //                             return AddNotification(
          //                               operationType: OperationType.add,
          //                               notification: NotificationModel(),
          //                             );
          //                           });
          //                     },
          //                     icon: Icon(Icons.add))
          //               ],
          //             ),
          //           )
          //         ];
          //
          //         if (state is NotofocationsLoaded) {
          //           for (var element in state.notifications) {
          //             notifications.add(PopupMenuItem(
          //                 onTap: null,
          //                 child: NotificationItem(
          //                   notification: element,
          //                 )));
          //           }
          //         }
          //         return true
          //             ? notifications
          //             : state is NotofocationsLoaded
          //                 ? state.notifications.map((element) {
          //                     return PopupMenuItem(
          //                         onTap: () {
          //                           // showDialog(context: context, builder: (context){
          //                           //   return
          //                           // });
          //                         },
          //                         child: NotificationItem(
          //                           notification: element,
          //                         ));
          //                   }).toList()
          //                 : [];
          //       },
          //       child: Badge(
          //         label: Text(state is NotofocationsLoaded
          //             ? '${state.unReadcount}'
          //             : '0'),
          //         padding: EdgeInsets.all(7),
          //         largeSize: 25,
          //         smallSize: 25,
          //         child: Container(
          //           padding: const EdgeInsets.all(15),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(250.r),
          //               color: Colors.white),
          //           child: SvgPicture.asset(
          //             AppImages.notifications,
          //             width: 24,
          //             height: 24,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          SizedBox(
            width: 16.w,
          ),
          if (BlocProvider.of<UserCubit>(currentContext).user?.isAdmin ?? false)
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return PopupMenuButton(
                  position: PopupMenuPosition.under,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  constraints:
                      BoxConstraints(minWidth: 400.w, maxHeight: .4.sh),
                  itemBuilder: (ctx) {
                    List<PopupMenuEntry> chats = [
                      PopupMenuItem(
                        onTap: null,
                        enabled: false,
                        child: Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddNotification(
                                          operationType: OperationType.add,
                                          notification: NotificationModel(),
                                        );
                                      });
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      )
                    ];

                    if (state is ChatLoaded) {
                      for (var element in state.chats) {
                        chats.add(PopupMenuItem(
                            onTap: null,
                            child: ChatItem(
                              chat: element,
                            )));
                      }
                    }
                    return chats;
                  },
                  child: Badge(
                    label: Text(
                        state is ChatLoaded ? '${state.unreadMessages}' : '0'),
                    padding: EdgeInsets.all(7),
                    largeSize: 25,
                    smallSize: 25,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(250.r),
                          color: Colors.white),
                      child: SvgPicture.asset(
                        AppImages.chat,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                );
              },
            ),
          SizedBox(
            width: 30.w,
          )
        ],
      ),
    );
  }

  Widget mobileDesign() {
    return const SizedBox();
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel? notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: CustomNetworkImage(
                link: notification?.photo?.fullLink ?? '',
                height: 60,
                width: 60),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      isArabic
                          ? notification?.title ?? ''
                          : notification?.titleEn ?? '',
                      style: AppFonts.apptextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    getSinceTime(),
                    style: AppFonts.apptextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: Text(
                  isArabic
                      ? notification?.description ?? ''
                      : notification?.descriptionEn ?? '',
                  maxLines: 1,
                  style: AppFonts.apptextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String getSinceTime() {
    DateTime date =
        DateFormat('dd-MM-yyy HH:mm:ss').parse(notification?.created ?? '');
    DateTime serverTime = DateTime.now();
    String sinceTime = '';
    int min = serverTime.difference(date).inMinutes;
    if (min < 1) {
      sinceTime = isArabic ? 'الان' : 'just now';
    } else if (min >= 1 && min < 60) {
      sinceTime = isArabic ? 'منذ $min دقائق' : 'since $min miniutes';
    } else {
      int hours = serverTime.difference(date).inHours;
      if (hours >= 1 && hours < 24) {
        sinceTime = isArabic
            ? 'منذ $hours ساعات و ${min % 60} دقايق '
            : 'since $hours hours and ${min % 60} miniutes';
      } else {
        // sinceTime = DateFormat.Hms().format(date);
        sinceTime =
            DateFormat('MMMMEEEEd', isArabic ? 'ar' : 'en').format(date);
        sinceTime =
            '$sinceTime  ${isArabic ? "ساعه" : "hour"} ${DateFormat('jm', isArabic ? 'ar' : 'en').format(date)} ';
      }
    }
    return sinceTime;
  }
}
