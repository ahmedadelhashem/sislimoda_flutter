import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String okTitle;
  final String content;
  final VoidCallback onClosePressed;

  CustomDialog(
      {required this.title,
      required this.content,
      required this.onClosePressed,
      required this.okTitle});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 350,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: AppFonts.apptextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error),
              ),
              const SizedBox(height: 30),
              Text(
                content,
                style: AppFonts.apptextStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                widthFactor: 100,
                child: SizedBox(
                  width: 100,
                  height: 42,
                  child: AppButton(
                    onPress: onClosePressed,
                    title: okTitle,
                    titleFontColor: AppColors.black,
                    titleFontSize: 16,
                    borderRadius: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

showErrorMessage({required String message}) {
  showDialog(
      context: currentContext,
      builder: (ctx) {
        return CustomDialog(
          title: LocaleKeys.error.tr(),
          okTitle: LocaleKeys.ok.tr(),
          content: message,
          onClosePressed: () {
            Navigator.pop(ctx);
          },
        );
      });
}

showTurkeyErrorMessage({required String message}) {
  showDialog(
      context: currentContext,
      builder: (ctx) {
        return CustomDialog(
          title: 'hata',
          okTitle: 'Tamam',
          content: message,
          onClosePressed: () {
            Navigator.pop(ctx);
          },
        );
      });
}

showSuccessMessage({required String message}) {
  showDialog(
      context: currentContext,
      builder: (ctx) {
        return CustomDialog(
          title: LocaleKeys.success.tr(),
          okTitle: LocaleKeys.ok.tr(),
          content: message,
          onClosePressed: () {
            Navigator.pop(ctx);
          },
        );
      });
}

showTurkeySuccessMessage({required String message}) {
  showDialog(
      context: currentContext,
      builder: (ctx) {
        return CustomDialog(
          title: 'başarı',
          okTitle: 'Tamam',
          content: message,
          onClosePressed: () {
            Navigator.pop(ctx);
          },
        );
      });
}
