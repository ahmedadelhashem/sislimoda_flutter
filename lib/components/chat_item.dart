import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sislimoda_admin_dashboard/models/chat/chat_model.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({super.key, required this.chat});
  final ChatModel chat;
  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.withOpacity(.1),
            child: Icon(
              Icons.person,
              color: Colors.grey,
              size: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${widget.chat.myAppUser?.firstName ?? ''} ${widget.chat.myAppUser?.lastName ?? ''} ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                const SizedBox(
                  height: 2,
                ),
                Text(widget.chat.userMessages?.first?.message ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(getSinceTime(),
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
              // if ((chat.chatUnreadMessagesCount ?? '0') != '0')
              //   CircleAvatar(
              //     backgroundColor: Colors.red,
              //     radius: 12,
              //     child: Center(
              //       child: Text(
              //         chat.chatUnreadMessagesCount ?? '0',
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w400,
              //             fontSize: 11),
              //       ),
              //     ),
              //   )
            ],
          )
        ],
      ),
    );
  }

  String getSinceTime() {
    DateTime date = DateFormat('dd-MM-yyy HH:mm:ss')
        .parse(widget.chat.userMessages?.first?.created ?? '');
    date = date.add(Duration(hours: 1));
    DateTime serverTime = DateTime.now();
    String sinceTime = '';
    int min = serverTime.difference(date).inMinutes;
    if (min < 1) {
      sinceTime = isArabic ? 'الان' : 'just now';
    } else if (min >= 1 && min < 60) {
      sinceTime = isArabic ? 'منذ $min دقائق' : 'since $min minutes';
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
