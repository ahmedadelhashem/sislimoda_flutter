import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class CustomMultiSelect extends StatelessWidget {
  const CustomMultiSelect(
      {super.key,
      required this.hint,
      required this.items,
      required this.onChange,
      this.isSingle = false,
      this.selectedItems = const [],
      this.backgroundColor = Colors.white,
      this.forGroundColor = Colors.black});
  final String hint;
  final List<ValueItem> items;
  final List<ValueItem> selectedItems;
  final Function onChange;
  final bool isSingle;
  final Color backgroundColor;
  final Color forGroundColor;
  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      key: GlobalKey(),
      onOptionSelected: (options) {
        debugPrint(options.toString());
        onChange(options);
      },
      inputDecoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12)),
      hint: hint,
      clearIcon: Icon(
        Icons.add,
        color: backgroundColor,
      ),
      hintStyle:
          AppFonts.apptextStyle.copyWith(color: forGroundColor, fontSize: 16),
      options: items,
      searchEnabled: true,
      selectedOptions: selectedItems,
      singleSelectItemStyle:
          AppFonts.apptextStyle.copyWith(color: forGroundColor, fontSize: 16),
      selectionType: isSingle ? SelectionType.single : SelectionType.multi,
      chipConfig: ChipConfig(
        wrapType: WrapType.scroll,
        labelColor: AppColors.black,
        labelStyle: AppFonts.apptextStyle
            .copyWith(color: AppColors.black, fontSize: 16),
        padding: EdgeInsets.only(left: 10, right: 10),
      ),
      dropdownHeight: items.length > 10 ? 300 : items.length * 40,
      optionTextStyle: AppFonts.apptextStyle
          .copyWith(color: AppColors.secondaryFontColor, fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
    );
  }
}
