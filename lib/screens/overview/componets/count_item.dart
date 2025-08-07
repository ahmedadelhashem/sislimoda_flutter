import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class CountItem extends StatelessWidget {
  const CountItem({super.key, required this.title, required this.count});
  final String title, count;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 110,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.apptextStyle.copyWith(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            count,
            style: AppFonts.apptextStyle.copyWith(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
