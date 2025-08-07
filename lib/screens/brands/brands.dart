import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/brands_data.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/DailyCouponUsageScreen.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/InfluencerStatsPage.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/OffersStatsPage.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/VendorAnalysisPage.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/widgets/coupon_button.dart';
@RoutePage()
class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> with VendorStatisticsData {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final items = [
      _AnalysisItem(
       title: isArabic ? 'إحصائيات المبيعات' : 'Sales Stats',
        icon: Icons.bar_chart,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AllVendorsStatisticsScreen(
                
              ),
            ),
          );
        },
      ),
      _AnalysisItem(
        title: isArabic ? 'إحصائيات العروض' : 'Offers Stats',
        icon: Icons.local_offer,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => OfferStatisticsScreen()));
        },
      ),
      _AnalysisItem(
        title: isArabic ? 'إحصائيات الكوبونات' : 'Coupons Stats',
        icon: Icons.discount,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CouponSummaryScreen()));
        },
      ),
      _AnalysisItem(
        title: isArabic ? 'إحصائيات المشهور' : 'Influencer Stats',
        icon: Icons.person,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const InfluencerSummaryScreen()));
        },
      ),
    ];

    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 4,
          children: items.map((item) => _buildCard(context, item)).toList(),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, _AnalysisItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 36, color: Colors.teal),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class _AnalysisItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _AnalysisItem({required this.title, required this.icon, required this.onTap});
}
