// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomDropdown extends StatefulWidget {
//   final List<String> items;
//   final String selectedItem;
//   final Function(String) onChanged;
//   final String title;
//   CustomDropdown(
//       {required this.items,
//       required this.selectedItem,
//       required this.onChanged,
//       required this.title});
//
//   @override
//   _CustomDropdownState createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown> {
//   OverlayEntry? _overlayEntry;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleDropdown,
//       child: Container(
//         padding: EdgeInsets.only(left: 24.w, right: 24.w),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12.r),
//                 topRight: Radius.circular(12.r),
//                 bottomLeft: Radius.circular(_overlayEntry == null ? 12.r : 0),
//                 bottomRight: Radius.circular(_overlayEntry == null ? 12.r : 0)),
//             // color: _overlayEntry != null
//             //     ? const Color(0xff344151)
//             //     : Colors.transparent,
//             border: Border.all(color: const Color(0xffD7DFF4))),
//         child: Row(
//           children: [
//             Text(
//               widget.title,
//               maxLines: 1,
//               style: TextStyle(
//                 color: const Color(0xffD7DFF4),
//                 fontSize: 18.spMin,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             Spacer(),
//             Icon(
//               Icons.expand_more_sharp,
//               color: Colors.white,
//               size: 25.spMin,
//             )
//             // SvgPicture.asset(AppImages.arrowDown)
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _toggleDropdown() {
//     if (_overlayEntry == null) {
//       _overlayEntry = _createOverlayEntry(context);
//       Overlay.of(context)?.insert(_overlayEntry!);
//     } else {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     }
//     setState(() {});
//   }
//
//   OverlayEntry _createOverlayEntry(BuildContext context) {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//     var offset = renderBox.localToGlobal(Offset.zero);
//
//     return OverlayEntry(
//       builder: (context) {
//         return Stack(
//           children: [
//             Positioned(
//               left: offset.dx,
//               top: offset.dy - 6.h,
//               width: size.width,
//               child: Container(
//                 height: .3.sh,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(12.r),
//                     bottomLeft: Radius.circular(12.r),
//                   ),
//                   border: Border.all(color: Colors.white),
//                   color: Color(0xff064698),
//                 ),
//                 child: Column(
//                   children: widget.items.map((item) {
//                     return GestureDetector(
//                       onTap: () {
//                         widget.onChanged(item);
//                         _overlayEntry?.remove();
//                         _overlayEntry = null;
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                           item,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class AppDropDown extends StatefulWidget {
//   const AppDropDown({super.key});
//   @override
//   State<AppDropDown> createState() => _AppDropDownState();
// }
//
// class _AppDropDownState extends State<AppDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton2<String>(
//       isExpanded: true,
//       hint: Text(
//         'Select Item',
//         style: TextStyle(
//           fontSize: 14,
//           color: Theme.of(context).hintColor,
//         ),
//       ),
//       items: ['a', 'b', 'c']
//           .map((String item) => DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: const TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ))
//           .toList(),
//       value: 'a',
//       onChanged: (String? value) {
//         setState(() {
//           // selectedValue = value;
//         });
//       },
//       iconStyleData: IconStyleData(
//           icon: Icon(
//         Icons.expand_more_sharp,
//         color: Colors.white,
//         size: 25.spMin,
//       )),
//       underline: SizedBox(),
//       buttonStyleData: ButtonStyleData(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           height: 40,
//           width: 140,
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.circular(8.r))),
//       menuItemStyleData: const MenuItemStyleData(
//         height: 40,
//       ),
//     );
//   }
// }
