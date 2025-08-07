import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/CouponsStatsPage.dart' hide CouponSummaryScreen;
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/DailyCouponUsageScreen.dart';


class CouponButtonScreen extends StatelessWidget {
  const CouponButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'إحصائيات الكوبونات' : 'Coupons Statistics'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isArabic ? 'إختر نوع الإحصائية' : 'Select Statistics Type',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (_) =>  CouponSummaryScreen()));
              },
              icon: const Icon(Icons.check_circle_outline),
              label: Text(isArabic ? 'الكوبونات المفعّلة' : 'Active Coupons'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>  CouponSummaryScreen()));
               },
              icon: const Icon(Icons.insert_chart),
              label: Text(isArabic ? 'استخدام الكوبونات' : 'Coupons Daily Usage'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
