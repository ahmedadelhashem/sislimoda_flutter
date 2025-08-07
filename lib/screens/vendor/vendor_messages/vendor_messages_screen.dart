import 'dart:async';
import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/models/chat/chat_model.dart';
import 'package:sislimoda_admin_dashboard/screens/chat/widgets/message_item.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_messages/vendor_chat_data.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class VendorMessagesScreen extends StatefulWidget {
  const VendorMessagesScreen({super.key});

  @override
  State<VendorMessagesScreen> createState() => _VendorMessagesScreenState();
}

class _VendorMessagesScreenState extends State<VendorMessagesScreen>
    with VendorChatData {
  final ScrollController scrollController = ScrollController();
  Timer? _chatTimer;
  @override
  void initState() {
    super.initState();
    getMessages();
      _chatTimer = Timer.periodic(Duration(seconds: 2), (timer) {
    reload(); // تحديث تلقائي كل ثانيتين
  });
  }
  @override
void dispose() {
  _chatTimer?.cancel();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';  
  final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 34),
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
                      isArabic ? 'إدارة الدعم الفني' : isTurkish ? "Müşteri destek yönetimi" :
                       "Customer support management",
                      style: AppFonts.apptextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        isArabic ? 'يمكنك إدارة الدعم الفني' :isTurkish ? "Tüm sohbetleri yönetebilirsiniz" :
                         "You can manage all chats",
                        style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: Screen(
                loadingCubit: loading,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GenericBuilder(
                          genericCubit: messagesCubit,
                          builder: (chat) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Row(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(250),
                                        ),
                                        child: CustomNetworkImage(
                                          link: 'https://ui-avatars.com/api/?name=Admin+Sislimoda',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Admin Sislimoda',
                                            style: AppFonts.apptextStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(thickness: 1),
                                  // Chat messages
                                  Expanded(
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount: chat.length,
                                      reverse: true,
                                      itemBuilder: (context, index) {
                                        return MessageItem(
  key: ValueKey(chat[index]?.id ?? index), // مفتاح فريد لكل رسالة
  message: chat[index] ?? ChatModelUserMessages(),
);

                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Send Message
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 45,
                                          child: TextFormField(
                                            controller: messageController,
                                            onFieldSubmitted: (_) async {
                                              await sendMessage();
                                              scrollToBottom();
                                            },
                                            style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: isArabic
                                                  ? "اكتب رسالتك..." : isTurkish ? "Mesajınızı yazın..." :
                                                   "Type your message...",
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                              fillColor: Colors.grey.shade100,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () async {
                                          await sendMessage();
                                          scrollToBottom();
                                        },
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundColor: AppColors.mainColor,
                                          child: Transform.rotate(
                                            angle: pi,
                                            child: const Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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

 void scrollToBottom() {
  Future.delayed(Duration(milliseconds: 300), () {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent, // ✅ ده تحت مع reverse:true
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  });
}

}
