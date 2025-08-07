import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderItem extends StatefulWidget {
  const LoaderItem({Key? key}) : super(key: key);

  @override
  State<LoaderItem> createState() => _LoaderItemState();
}

class _LoaderItemState extends State<LoaderItem>
    with SingleTickerProviderStateMixin {
 

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: .04.sw,
          child: const LoadingIndicator(

            // pathBackgroundColor: Colors.white,
            indicatorType: Indicator.ballRotateChase,
            // pathBackgroundColor: AppColors.mainColor,
            colors: [Colors.red],
          )),
    );
  }
}
