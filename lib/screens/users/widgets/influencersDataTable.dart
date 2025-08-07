import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/users/InfluencerModel.dart';
import 'package:sislimoda_admin_dashboard/screens/users/widgets/editinf.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class InfluencersDatatable extends StatelessWidget {
  final GenericCubit<List<InfluencerModel>> influencersCubit;
  final Function(String id) deleteInfluencer;
  final Function(InfluencerModel user) updateInfluencer;
  final List<ValueItem> optionSet;
  final Function changeUserStatus;

  const InfluencersDatatable({
    super.key,
    required this.influencersCubit,
    required this.deleteInfluencer,
    required this.updateInfluencer,
    required this.optionSet,
    required this.changeUserStatus,
  });

  @override
  Widget build(BuildContext context) {
    final influencers = influencersCubit.state.data ?? [];

    return DataTable2(
      dividerThickness: 0,
      columnSpacing: 40,
      horizontalMargin: 10,
      columns: _buildColumns(),
      rows: influencers.asMap().entries.map((entry) {
        final index = entry.key;
        final element = entry.value;
        return _buildRow(context, index, element);
      }).toList(),
    );
  }

  List<DataColumn2> _buildColumns() {
    return [
      _buildColumn(LocaleKeys.id.tr(), ColumnSize.S),
      _buildColumn(LocaleKeys.clientName.tr(), ColumnSize.L),
      _buildColumn(LocaleKeys.mobileNumber.tr(), ColumnSize.M),
      _buildColumn(LocaleKeys.email.tr(), ColumnSize.L),
      _buildColumn(LocaleKeys.status.tr(), ColumnSize.L),
      _buildColumn('', ColumnSize.S),
    ];
  }

  DataColumn2 _buildColumn(String label, ColumnSize size) {
    return DataColumn2(
      label: Text(
        label,
        style: AppFonts.apptextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryFontColor,
        ),
      ),
      size: size,
    );
  }

  DataRow2 _buildRow(BuildContext context, int index, InfluencerModel element) {
    return DataRow2(
      cells: [
        _buildCell('#${index + 1}'),
        _buildCell(element.name ?? 'غير مكتمل'),
        _buildCell(element.user?.phoneNumer ?? 'غير مكتمل'),
        _buildCell(element.user?.email ?? ''),
        _buildStatusCell(element),
        _buildActionsCell(context, element),
      ],
    );
  }

  DataCell _buildCell(String text) {
    return DataCell(
      Text(
        text,
        style: AppFonts.apptextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryFontColor,
        ),
      ),
    );
  }

DataCell _buildStatusCell(InfluencerModel element) {
  ValueItem? selected = optionSet.firstWhere(
    (item) => item.value == element.influencerStatus?.id,
    orElse: () => ValueItem(label: '', value: null),
  );

  final selectedItems = selected.value == null ? <ValueItem>[] : [selected];
  final color = _parseColor(element.influencerStatus?.color);

     return DataCell(
    SizedBox(
      height: 40,
      child: CustomMultiSelect(
        forGroundColor: Colors.white,
        backgroundColor: color,
        isSingle: true,
        hint: '',
        selectedItems: selectedItems,
        items: optionSet,
        onChange: (List<ValueItem> value) async {
          if (value.isNotEmpty) {
            await AppService.callService(
              actionType: ActionType.post,
              apiName: 'api/Influencer/Update',
              body: {
                "id": element.id,
                "name": element.name,
                "isActive": true,
                "photoId": element.photoId,
                "userId": element.userId,
                "influencerStatusId": value.first.value,
              },
            );
            changeUserStatus();
          }
        },
      ),
    ),
  );
}

  Color _parseColor(String? colorHex) {
    if (colorHex == null || !colorHex.startsWith('#')) {
      return Colors.white;
    }
    return Color(int.tryParse('0xff${colorHex.substring(1)}') ?? 0xffffffff);
  }

  DataCell _buildActionsCell(BuildContext context, InfluencerModel element) {
    return DataCell(
      PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') {
            showDialog(
              context: context,
              builder: (_) => InfluencerFormDialog(
                influencer: element,
                onSave: (updatedUser) {
                  updateInfluencer(updatedUser);
                },
              ),
            );
          } else if (value == 'delete') {
            deleteInfluencer(element.id ?? '');
          }
        },
        position: PopupMenuPosition.under,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        constraints: BoxConstraints(minWidth: 110.w),
        itemBuilder: (_) => [
          _popupItem(AppImages.update, LocaleKeys.edit.tr(), AppColors.black, 'edit'),
          _popupItem(AppImages.delete, LocaleKeys.delete.tr(), AppColors.error, 'delete'),
        ],
        child: const Icon(Icons.more_horiz),
      ),
    );
  }

  PopupMenuItem<String> _popupItem(String iconPath, String text, Color color, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 35,
      child: Row(
        children: [
          SvgPicture.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppFonts.apptextStyle.copyWith(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
