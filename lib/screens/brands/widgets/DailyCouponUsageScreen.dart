import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/CouponStatisticsModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/CouponSummary/coupon_statistics_data.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'dart:ui' as ui;

class CouponSummaryScreen extends StatefulWidget {
  const CouponSummaryScreen({super.key});

  @override
  State<CouponSummaryScreen> createState() => _CouponSummaryScreenState();
}

class _CouponSummaryScreenState extends State<CouponSummaryScreen> {
  DateTime from = DateTime(2021, 2, 1);
  DateTime to = DateTime.now();

  CouponSummaryStats? stats;
  List<CouponDailyUsageModel> daily = [];
  bool loading = true;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => loading = true);
    stats = await loadCouponSummaryData(from: from, to: to);
    daily = await loadCouponDailyUsage(from: from, to: to);
    setState(() => loading = false);
  }

  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  Future<void> selectFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: from,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: isArabic ? const Locale("ar") : const Locale("en"),
    );
    if (picked != null && picked != from) {
      setState(() => from = picked);
      loadData();
    }
  }


  Future<void> selectToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: to,
      firstDate: from,
      lastDate: DateTime.now(),
      locale: isArabic ? const Locale("ar") : const Locale("en"),
    );
    if (picked != null && picked != to) {
      setState(() => to = picked);
      loadData();
    }
  }


  Widget _buildDateSelector({
    required String label,
    required DateTime selectedDate,
    required void Function(DateTime) onDateSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
            locale: Locale(isArabic ? 'ar' : 'en'),
          );
          if (picked != null) onDateSelected(picked);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          child: Row(
            children: [
              const Icon(Icons.date_range, color: Colors.teal),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$label: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    if (stats == null || stats!.totalSalesViaCoupon == 0) {
      return Center(child: Text(isArabic ? "لا توجد بيانات كافية للرسم البياني" : "No data for chart"));
    }

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sectionsSpace: 4,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: stats!.totalInfluencerProfit,
            title: touchedIndex == 0
                ? '${stats!.totalInfluencerProfit.toStringAsFixed(1)} \u062c.\u0645'
                : (isArabic ? 'المؤثر' : 'Influencer'),
            color: Colors.blueAccent,
            radius: touchedIndex == 0 ? 70 : 60,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: stats!.totalSystemProfit,
            title: touchedIndex == 1
                ? '${stats!.totalSystemProfit.toStringAsFixed(1)} \u062c.\u0645'
                : (isArabic ? 'النظام' : 'System'),
            color: Colors.green,
            radius: touchedIndex == 1 ? 70 : 60,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Widget buildPieChart() {
  //   if (stats == null || (stats!.totalInfluencerProfit + stats!.totalSystemProfit) == 0) {
  //     return Center(
  //       child: Text(isArabic ? "لا يوجد بيانات" : "No data available"),
  //     );
  //   }

  //   return PieChart(
  //     PieChartData(
  //       sections: [
  //         PieChartSectionData(
  //           color: Colors.orange,
  //           value: stats!.totalInfluencerProfit,
  //           title: isArabic
  //               ? 'المؤثر\n${stats!.totalInfluencerProfit.toStringAsFixed(1)}'
  //               : 'Influencer\n${stats!.totalInfluencerProfit.toStringAsFixed(1)}',
  //           radius: touchedIndex == 0 ? 70 : 60,
  //           titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
  //         ),
  //         PieChartSectionData(
  //           color: Colors.blue,
  //           value: stats!.totalSystemProfit,
  //           title: isArabic
  //               ? 'النظام\n${stats!.totalSystemProfit.toStringAsFixed(1)}'
  //               : 'System\n${stats!.totalSystemProfit.toStringAsFixed(1)}',
  //           radius: touchedIndex == 1 ? 70 : 60,
  //           titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
  //         ),
  //       ],
  //       sectionsSpace: 2,
  //       centerSpaceRadius: 30,
  //       pieTouchData: PieTouchData(
  //         touchCallback: (event, pieTouchResponse) {
  //           setState(() {
  //             if (!event.isInterestedForInteractions ||
  //                 pieTouchResponse == null ||
  //                 pieTouchResponse.touchedSection == null) {
  //               touchedIndex = -1;
  //             } else {
  //               touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
  //             }
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.teal),
        title: Text(
          isArabic ? "\uD83D\uDCCA ملخص الكوبونات" : "\uD83D\uDCCA Coupon Summary",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
      ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : (stats == null
                ? Center(child: Text(isArabic ? "لا يوجد بيانات" : "No data available"))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            children: [
                              _buildDateSelector(
                                label: isArabic ? "من" : "From",
                                selectedDate: from,
                                onDateSelected: (date) {
                                  setState(() => from = date);
                                  loadData();
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildDateSelector(
                                label: isArabic ? "إلى" : "To",
                                selectedDate: to,
                                onDateSelected: (date) {
                                  setState(() => to = date);
                                  loadData();
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        GridView.count(
                          crossAxisCount: isWide ? 3 : 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 5.5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildStatCard(
                              isArabic ? "إجمالي الاستخدامات" : "Total Uses",
                              "${stats!.totalUses}",
                              Colors.deepPurple,
                              Icons.confirmation_number_outlined,
                            ),
                            _buildStatCard(
                              isArabic ? "إجمالي الخصومات" : "Total Discounts",
                              stats!.totalDiscount.toStringAsFixed(2),
                              Colors.red,
                              Icons.money_off,
                            ),
                            _buildStatCard(
                              isArabic ? "مبيعات الكوبونات" : "Sales via Coupons",
                              stats!.totalSalesViaCoupon.toStringAsFixed(2),
                              Colors.green,
                              Icons.shopping_cart,
                            ),
                            _buildStatCard(
                              isArabic ? "أرباح المؤثر" : "Influencer Profit",
                              stats!.totalInfluencerProfit.toStringAsFixed(2),
                              Colors.blue,
                              Icons.person,
                            ),
                            _buildStatCard(
                              isArabic ? "أرباح النظام" : "System Profit",
                              stats!.totalSystemProfit.toStringAsFixed(2),
                              Colors.teal,
                              Icons.account_balance,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(
                          isArabic ? "مقارنة الأرباح" : "Profit Comparison",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(height: 220, child: _buildPieChart()),
                        const SizedBox(height: 32),
                        Text(
                          isArabic ? "تفاصيل يومية" : "Daily Details",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        daily.isEmpty
                            ? Center(child: Text(isArabic ? "لا يوجد بيانات" : "No data available"))
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: daily.length,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (_, index) {
                                  final item = daily[index];
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${isArabic ? "الكود" : "Code"}: ${item.couponCode}'),
                                          Text('${isArabic ? "المؤثر" : "Influencer"}: ${item.influencerName ?? "-"}'),
                                          Text('${isArabic ? "الاستخدامات" : "Uses"}: ${item.uses}'),
                                          Text('${isArabic ? "الخصم الكلي" : "Total Discount"}: ${item.totalDiscount.toStringAsFixed(2)}'),
                                          Text('${isArabic ? "المبيعات" : "Sales"}: ${item.totalSalesViaCoupon.toStringAsFixed(2)}'),
                                          Text('${isArabic ? "نسبة الخصم" : "Discount %"}: ${item.discountPercent.toStringAsFixed(1)}%'),
                                          Text('${isArabic ? "نسبة المؤثر" : "Influencer %"}: ${item.influencerPercentage.toStringAsFixed(1)}%'),
                                          Text('${isArabic ? "نسبة النظام" : "System %"}: ${item.systemPercentage.toStringAsFixed(1)}%'),
                                          Text('${isArabic ? "ربح المؤثر" : "Influencer Profit"}: ${item.influencerProfit.toStringAsFixed(2)}'),
                                          Text('${isArabic ? "ربح النظام" : "System Profit"}: ${item.systemProfit.toStringAsFixed(2)}'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  )),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.withOpacity(0.06),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 10)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
