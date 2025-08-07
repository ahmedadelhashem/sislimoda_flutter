import 'package:sislimoda_admin_dashboard/components/text/text_custom.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:flutter/material.dart';

class RowFillterMultiSelect extends StatefulWidget {
  final List<FillterItems> fillterItemsList;
  final Color selectedItemColor;
  final Color unSelectedItemColor;
  final Color selectedItemFontColor;
  final Color unSelectedItemFontColor;
  final Color backgroundColor;

  final Function(List<FillterItems>) multySelectedItems;

  RowFillterMultiSelect({
    required this.fillterItemsList,
    required this.selectedItemColor,
    required this.unSelectedItemColor,
    required this.selectedItemFontColor,
    required this.backgroundColor,
    required this.multySelectedItems,
    required this.unSelectedItemFontColor,
  });

  @override
  _RowFillterMultiSelectState createState() => _RowFillterMultiSelectState();
}

class _RowFillterMultiSelectState extends State<RowFillterMultiSelect> {
  final List<FillterItems> selectedFillterItemsList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // scrollDirection: Axis.horizontal,
        children: widget.fillterItemsList
            .map((e) => _displayItems(fillterItems: e))
            .toList(),
      ),
    );
  }

  Widget _displayItems({required FillterItems fillterItems}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: GestureDetector(
        onTap: () {
          fillterItems.state = !fillterItems.state;
          if (fillterItems.state) {
            if (!selectedFillterItemsList.contains(fillterItems)) {
              selectedFillterItemsList.add(fillterItems);
            }
          } else {
            selectedFillterItemsList.remove(fillterItems);
          }
          widget.multySelectedItems(selectedFillterItemsList);
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: fillterItems.state
                ? widget.selectedItemColor
                : widget.unSelectedItemColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TxtN(
              text: '${fillterItems.displayName}',
              color: fillterItems.state
                  ? widget.selectedItemFontColor
                  : widget.unSelectedItemFontColor,
              fontSize: FS.fs16,
              fontFamily: AppFonts.mainfont,
            ),
          ),
        ),
      ),
    );
  }
}

class FillterItems<T> {
  String displayName;
  bool state = false;
  String value;
  int index;
  T data;
  FillterItems({
    required this.displayName,
    required this.data,
    this.state = false,
    required this.value,
    required this.index,
  });
}

class WrapFillterMultiSelect<T> extends StatefulWidget {
  final List<FillterItems<T>> fillterItemsList;
  final Color selectedItemColor;
  final Color unSelectedItemColor;
  final Color selectedItemFontColor;
  final Color unSelectedItemFontColor;
  final Color backgroundColor;
  final bool isRow;

  final Function(FillterItems<T>?) selectedItem;

  WrapFillterMultiSelect({
    required this.fillterItemsList,
    required this.selectedItemColor,
    required this.unSelectedItemColor,
    required this.selectedItemFontColor,
    required this.backgroundColor,
    required this.selectedItem,
    required this.unSelectedItemFontColor,
    required this.isRow,
  });

  @override
  _WrapFillterMultiSelectState<T> createState() =>
      _WrapFillterMultiSelectState<T>();
}

class _WrapFillterMultiSelectState<T> extends State<WrapFillterMultiSelect<T>> {
  FillterItems<T>? selectedFillterItemsList;

  @override
  Widget build(BuildContext context) {
    return widget.isRow
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //  runAlignment: WrapAlignment.end,
              children: widget.fillterItemsList
                  .map((e) => _displayItems(fillterItems: e))
                  .toList(),
            ),
          )
        : Wrap(
            //  runAlignment: WrapAlignment.end,
            children: widget.fillterItemsList
                .map((e) => _displayItems(fillterItems: e))
                .toList(),
          );
  }

  Widget _displayItems({required FillterItems<T> fillterItems}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: GestureDetector(
        onTap: () {
          fillterItems.state = true;
          for (var item in widget.fillterItemsList) {
            if (item == fillterItems && item.state) {
              widget.selectedItem(fillterItems);
            } else {
              item.state = false;
            }
          }
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: fillterItems.state
                ? widget.selectedItemColor
                : widget.unSelectedItemColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TxtN(
              text: '${fillterItems.displayName}',
              color: fillterItems.state
                  ? widget.selectedItemFontColor
                  : widget.unSelectedItemFontColor,
              fontSize: FS.fs18,
              fontFamily: AppFonts.mainfont,
            ),
          ),
        ),
      ),
    );
  }
}
