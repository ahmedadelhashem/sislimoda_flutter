import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/models/settings/settings.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/settings/settings.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';

class EditSettingDialog extends StatefulWidget {
  final SettingsModel setting;
  final Function(SettingsModel updated) onUpdated;

  const EditSettingDialog({
    super.key,
    required this.setting,
    required this.onUpdated,
  });

  @override
  State<EditSettingDialog> createState() => _EditSettingDialogState();
}

class _EditSettingDialogState extends State<EditSettingDialog> {
  late TextEditingController _keyController;
  late TextEditingController _keyArController;
  late TextEditingController _valueController;
  bool _isLoading = false;

  @override
  void initState() {
    _keyController = TextEditingController(text: widget.setting.key ?? '');
    _keyArController = TextEditingController(text: widget.setting.keyAr ?? '');
    _valueController = TextEditingController(text: widget.setting.value ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _keyController.dispose();
    _keyArController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _isLoading = true;
    });

    final result = await AppService.callService(
      actionType: ActionType.post,
      apiName: 'api/Settings/Update',
      body: {
        "id": widget.setting.id,
        "key": _keyController.text,
        "keyAr": _keyArController.text,
        "value": _valueController.text,
      },
    );

    result.fold((success) {
      final updated = widget.setting.copyWith(
        key: _keyController.text,
        keyAr: _keyArController.text,
        value: _valueController.text,
      );
      widget.onUpdated(updated);
      Navigator.of(context).pop();
      showSuccessMessage(
        message: isArabic ? 'تم التعديل بنجاح' : 'Setting updated successfully',
      );
    }, (error) {
      showErrorMessage(message: error.message);
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isArabic ? 'تعديل الإعداد' : 'Edit Setting',
        style: AppFonts.apptextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: InputDecoration(
              labelText: isArabic ? 'Key (إنجليزي)' : 'Key',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _keyArController,
            decoration: InputDecoration(
              labelText: isArabic ? 'Key (عربي)' : 'Key (Arabic)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(
              labelText: isArabic ? 'القيمة' : 'Value',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(isArabic ? 'إلغاء' : 'Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryFontColor,
          ),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(isArabic ? 'حفظ' : 'Save'),
        ),
      ],
    );
  }
}



/*
class EditSettingDialog extends StatefulWidget {
  final SettingsModel setting;
  final Function reload;

  const EditSettingDialog({
    super.key,
    required this.setting,
    required this.reload,
  });

  @override
  State<EditSettingDialog> createState() => _EditSettingDialogState();
}

class _EditSettingDialogState extends State<EditSettingDialog> {
  late TextEditingController _keyController;
  late TextEditingController _keyArController;
  late TextEditingController _valueController;
  bool _isLoading = false;

  @override
  void initState() {
    _keyController = TextEditingController(text: widget.setting.key ?? '');
    _keyArController = TextEditingController(text: widget.setting.keyAr ?? '');
    _valueController = TextEditingController(text: widget.setting.value ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _keyController.dispose();
    _keyArController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _isLoading = true;
    });

    final result = await AppService.callService(
      actionType: ActionType.post,
      apiName: 'api/Settings/Update',
      body: {
        "id": widget.setting.id,
        "key": _keyController.text,
        "keyAr": _keyArController.text,
        "value": _valueController.text,
      },
    );

    result.fold((success) {
      widget.reload();
      Navigator.of(context).pop();
      showSuccessMessage(
        message: isArabic ? 'تم التعديل بنجاح' : 'Setting updated successfully',
      );
    }, (error) {
      showErrorMessage(message: error.message);
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isArabic ? 'تعديل الإعداد' : 'Edit Setting',
        style: AppFonts.apptextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: InputDecoration(
              labelText: isArabic ? 'Key (إنجليزي)' : 'Key',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _keyArController,
            decoration: InputDecoration(
              labelText: isArabic ? 'Key (عربي)' : 'Key (Arabic)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(
              labelText: isArabic ? 'القيمة' : 'Value',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(isArabic ? 'إلغاء' : 'Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryFontColor,
          ),
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(isArabic ? 'حفظ' : 'Save'),
        ),
      ],
    );
  }
}
*/