import 'package:flutter/material.dart';

class GroupBox extends StatelessWidget {
  final String headerName;
  final Gradient headerBackground;
  final Color borderColor;
  final List<Widget> children;
  GroupBox(
      {required this.headerName,
      required this.headerBackground,
      required this.borderColor,
      this.children = const <Widget>[]});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: headerBackground,
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  // child: TxtN(
                  //   text: headerName,
                  //   fontSize: 16,
                  //   fontfamily: AppFonts.fontLight,
                  //   color: AppColors.white,
                  // ),
                ),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
