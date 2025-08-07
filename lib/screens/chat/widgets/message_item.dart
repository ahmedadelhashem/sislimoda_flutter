import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/cubits/chat_cubit/chat_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/chat/chat_model.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_messages/api_servse_chat.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart'; // لازم تكون فيه isArabic

class MessageItem extends StatefulWidget {
  const MessageItem({super.key, required this.message});
  final ChatModelUserMessages message;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  String? translatedText;
  bool isTranslating = false;

Future<void> _translateMessage() async {
  if (translatedText != null) return; // تجنب التكرار
  setState(() {
    isTranslating = true;
  });

  final result = await TranslationService.translateAuto(
    widget.message.message ?? '',
  );

  setState(() {
    translatedText = result;
    isTranslating = false;
  });
}

  

  @override
  Widget build(BuildContext context) {
    final isFromAdmin = widget.message.fromAdmin ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isFromAdmin ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Material(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: Radius.circular(isFromAdmin ? 0 : 15),
              bottomRight: Radius.circular(isFromAdmin ? 15 : 0),
            ),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFromAdmin ? Colors.white : Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      widget.message.message ?? '',
                      style: TextStyle(
                        color: isFromAdmin ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    getSinceTime(dateTime: widget.message.created ?? ''),
                    style: TextStyle(
                      color: isFromAdmin ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
if (translatedText != null && translatedText!.trim() != widget.message.message?.trim())
                    Text(
                      translatedText!,
                      style: TextStyle(
                        color: isFromAdmin ? Colors.black87 : Colors.white70,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                  if (translatedText == null)
  TextButton(
    onPressed: isTranslating ? null : _translateMessage,
    child: Text(
      isTranslating
          ? (isArabic ? 'جارٍ الترجمة...' : 'Translating...')
          : (isArabic ? 'ترجم' : 'Translate'),
      style: TextStyle(
        color: isFromAdmin ? Colors.black54 : Colors.white70,
        fontSize: 13,
      ),
    ),
  )
else
  TextButton(
    onPressed: () {
      setState(() {
        translatedText = null;
      });
    },
    child: Text(
      isArabic ? 'إخفاء الترجمة' : 'Hide translation',
      style: TextStyle(
        color: isFromAdmin ? Colors.black54 : Colors.white70,
        fontSize: 13,
      ),
    ),
  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
