import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class CustomDropdownNew extends StatefulWidget {
  const CustomDropdownNew(
      {super.key,
      required this.items,
      required this.onSelect,
      required this.title,
      this.selected});
  final List<Item> items;
  final Function(Item) onSelect;
  final String title;
  final Item? selected;
  @override
  State<CustomDropdownNew> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdownNew> {
  Item? selectedValue = Item(key: '', value: '');

  @override
  void initState() {
    // TODO: implement initState
    if (widget.selected != null &&
        widget.selected?.value != null &&
        widget.selected?.key != null) {
      selectedValue = widget.selected ?? Item(key: '', value: '');
    } else {
      selectedValue?.value = widget.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        constraints: BoxConstraints(maxHeight: 300, maxWidth: 1000),
        position: PopupMenuPosition.under,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                selectedValue?.value.toString().capitalize ?? '',
                style: AppFonts.apptextStyle.copyWith(color: Colors.grey),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.expand_more)
            ],
          ),
        ),
        itemBuilder: (context) {
          return widget.items
              .map(
                (e) => PopupMenuItem(
                    height: 35,
                    onTap: () {
                      widget.onSelect(e);
                      selectedValue = e;
                      setState(() {});
                    },
                    child: Text(
                      e.value.capitalize ?? '',
                      style: AppFonts.apptextStyle.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
              )
              .toList();
        });
  }
}
