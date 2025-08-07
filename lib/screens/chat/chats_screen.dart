import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/chat_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/cubits/chat_cubit/chat_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/chat/chat_model.dart';
import 'package:sislimoda_admin_dashboard/screens/chat/widgets/message_item.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}
/*
class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 34, right: 34),
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
                      isArabic
                          ? 'إدارة الدعم الفني'
                          : "Customer support management",
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        isArabic
                            ? 'يمكنك إدارة الدعم الفني'
                            : "You can manage all chats",
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                Spacer(),
                // SizedBox(
                //   width: 247,
                //   height: 40,
                //   child: AppButton(
                //     title: isArabic ? "أضف كوبونات" : "Add Coupons",
                //     titleFontColor: AppColors.black,
                //     onPress: () {},
                //     titleFontSize: 16,
                //     fontWeight: FontWeight.w700,
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
                child: Screen(
              loadingCubit: BlocProvider.of<ChatCubit>(context).loading,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: BlocBuilder<ChatCubit, ChatState>(
                          builder: (context, state) {
                            if (state is ChatLoaded &&
                                state.selectedChat.id != null) {
                              return GenericBuilder(
                                  genericCubit:
                                      BlocProvider.of<ChatCubit>(context)
                                          .singleChatCubit,
                                  builder: (chat) {
                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            250)),
                                                child: CustomNetworkImage(
                                                    link: state.selectedChat
                                                            .myAppUser?.photo ??
                                                        '',
                                                    height: 60,
                                                    width: 60),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${state.selectedChat.myAppUser?.firstName ?? ''} ${state.selectedChat.myAppUser?.lastName ?? ''}',
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    state.selectedChat.myAppUser
                                                            ?.email ??
                                                        '',
                                                    style: AppFonts.apptextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount:
                                                  chat.userMessages?.length,
                                              reverse: true,
                                              itemBuilder: (context, index) {
                                                return MessageItem(
                                                    message: chat.userMessages?[
                                                            index] ??
                                                        ChatModelUserMessages());
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await AppService.callService(
                                                      actionType:
                                                          ActionType.post,
                                                      apiName:
                                                          'api/Chat/MessageToUser',
                                                      body: {
                                                        "myAppUserId":
                                                            chat.myAppUserId,
                                                        "userChatId": chat.id,
                                                        "message":
                                                            messageController
                                                                .text,
                                                        "replayUserId":
                                                            BlocProvider.of<
                                                                        UserCubit>(
                                                                    context)
                                                                .user
                                                                ?.id
                                                      });
                                                  messageController.clear();

                                                  await BlocProvider.of<
                                                          ChatCubit>(context)
                                                      .getAllChats();

                                                  BlocProvider.of<ChatCubit>(
                                                              context)
                                                          .selectedChat =
                                                      state.chats.firstWhere(
                                                          (element) =>
                                                              element.id ==
                                                              chat.id);
                                                  await BlocProvider.of<
                                                          ChatCubit>(context)
                                                      .getAllChats();
                                                },
                                                child: CircleAvatar(
                                                  radius: 27,
                                                  child: Center(
                                                      child: Transform.rotate(
                                                    angle: pi,
                                                    child: Icon(
                                                      Icons.send,
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 0,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 40,
                                                  child: TextFormField(
                                                    controller:
                                                        messageController,
                                                    onFieldSubmitted:
                                                        (message) async {
                                                      await AppService.callService(
                                                          actionType:
                                                              ActionType.post,
                                                          apiName:
                                                              'api/Chat/MessageToUser',
                                                          body: {
                                                            "myAppUserId": chat
                                                                .myAppUserId,
                                                            "userChatId":
                                                                chat.id,
                                                            "message":
                                                                messageController
                                                                    .text,
                                                            "replayUserId":
                                                                BlocProvider.of<
                                                                            UserCubit>(
                                                                        context)
                                                                    .user
                                                                    ?.id
                                                          });
                                                      messageController.clear();
                                                      await BlocProvider.of<
                                                                  ChatCubit>(
                                                              context)
                                                          .getAllChats();

                                                      BlocProvider.of<ChatCubit>(
                                                                  context)
                                                              .selectedChat =
                                                          state.chats
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      chat.id);
                                                      await BlocProvider.of<
                                                                  ChatCubit>(
                                                              context)
                                                          .getAllChats();
                                                    },
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                  ),
                                                ),
                                              ),

                                              // SizedBox(
                                              //   width: 30,
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }

                            return SizedBox();
                          },
                        )),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        if (state is ChatLoaded) {
                          return Expanded(
                              flex: 1,
                              child: ListView.separated(
                                  padding: EdgeInsets.all(18),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: state.chats.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          BlocProvider.of<ChatCubit>(context)
                                                  .selectedChat =
                                              state.chats[index];
                                          BlocProvider.of<ChatCubit>(context)
                                              .getAllChats();
                                        },
                                        child:
                                            ChatItem(chat: state.chats[index]));
                                  }));
                        }
                        return SizedBox();
                      },
                    ),

                    // Expanded(child: child),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
*/

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController messageController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: Container(
        padding: EdgeInsets.only(left: 34, right: 34),
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
                      isArabic ? 'إدارة الدعم الفني' : "Customer support management",
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        isArabic ? 'يمكنك إدارة الدعم الفني' : "You can manage all chats",
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
              width: 350,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: isArabic ? 'بحث باسم البائع...' : 'Search by vendor name...',
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
              ],
            ),
            // SizedBox(height: 16),
            // Search Field
            
            SizedBox(height: 16),
            Expanded(
              child: Screen(
                loadingCubit: BlocProvider.of<ChatCubit>(context).loading,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: BlocBuilder<ChatCubit, ChatState>(
                          builder: (context, state) {
                            if (state is ChatLoaded && state.selectedChat.id != null) {
                              return GenericBuilder(
                                genericCubit: BlocProvider.of<ChatCubit>(context).singleChatCubit,
                                builder: (chat) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(250)),
                                              child: CustomNetworkImage(
                                                  link: state.selectedChat.myAppUser?.photo ?? '',
                                                  height: 60,
                                                  width: 60),
                                            ),
                                            SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${state.selectedChat.myAppUser?.firstName ?? ''} ${state.selectedChat.myAppUser?.lastName ?? ''}',
                                                  style: AppFonts.apptextStyle.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  state.selectedChat.myAppUser?.email ?? '',
                                                  style: AppFonts.apptextStyle.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w400),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Divider(thickness: 1),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: chat.userMessages?.length,
                                            reverse: true,
                                            itemBuilder: (context, index) {
                                              return MessageItem(
                                                  message: chat.userMessages?[index] ??
                                                      ChatModelUserMessages());
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            InkWell(
                                              onTap: () async {
                                                await AppService.callService(
                                                    actionType: ActionType.post,
                                                    apiName: 'api/Chat/MessageToUser',
                                                    body: {
                                                      "myAppUserId": chat.myAppUserId,
                                                      "userChatId": chat.id,
                                                      "message": messageController.text,
                                                      "replayUserId": BlocProvider.of<UserCubit>(context).user?.id
                                                    });
                                                messageController.clear();

                                                await BlocProvider.of<ChatCubit>(context).getAllChats();

                                                BlocProvider.of<ChatCubit>(context).selectedChat =
                                                    state.chats.firstWhere((element) => element.id == chat.id);
                                                await BlocProvider.of<ChatCubit>(context).getAllChats();
                                              },
                                              child: CircleAvatar(
                                                radius: 27,
                                                child: Center(
                                                    child: Transform.rotate(
                                                  angle: pi,
                                                  child: Icon(
                                                    Icons.send,
                                                    color: Colors.red,
                                                  ),
                                                )),
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 0),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: TextFormField(
                                                  controller: messageController,
                                                  onFieldSubmitted: (message) async {
                                                    await AppService.callService(
                                                        actionType: ActionType.post,
                                                        apiName: 'api/Chat/MessageToUser',
                                                        body: {
                                                          "myAppUserId": chat.myAppUserId,
                                                          "userChatId": chat.id,
                                                          "message": messageController.text,
                                                          "replayUserId": BlocProvider.of<UserCubit>(context).user?.id
                                                        });
                                                    messageController.clear();
                                                    await BlocProvider.of<ChatCubit>(context).getAllChats();

                                                    BlocProvider.of<ChatCubit>(context).selectedChat =
                                                        state.chats.firstWhere((element) => element.id == chat.id);
                                                    await BlocProvider.of<ChatCubit>(context).getAllChats();
                                                  },
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600),
                                                  decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(15))),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                            }
                            return SizedBox();
                          },
                        ),
                      ),
                      VerticalDivider(thickness: 2),
                      BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          if (state is ChatLoaded) {
                            // فلترة حسب اسم البائع (vendor)
                            final filteredChats = state.chats.where((chat) {
                              final vendorName = (chat.myAppUser?.firstName ?? '') +
                                  ' ' +
                                  (chat.myAppUser?.lastName ?? '');
                              return vendorName
                                  .toLowerCase()
                                  .contains(searchText.toLowerCase());
                            }).toList();

                            return Expanded(
                              flex: 1,
                              child: ListView.separated(
                                padding: EdgeInsets.all(18),
                                separatorBuilder: (context, index) => SizedBox(height: 10),
                                itemCount: filteredChats.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      BlocProvider.of<ChatCubit>(context).selectedChat =
                                          filteredChats[index];
                                      BlocProvider.of<ChatCubit>(context).getAllChats();
                                    },
                                    child: ChatItem(chat: filteredChats[index]),
                                  );
                                },
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
