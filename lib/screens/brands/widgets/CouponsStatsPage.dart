import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/CouponStatisticsModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/CouponSummary/coupon_statistics_data.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/CouponSummary/coupon_statistics_service.dart';

class CouponSummaryScreen extends StatefulWidget {
  const CouponSummaryScreen({super.key});

  @override
  State<CouponSummaryScreen> createState() => _CouponSummaryScreenState();
}

class _CouponSummaryScreenState extends State<CouponSummaryScreen> {
  CouponSummaryStats? stats;
  List<CouponStatisticsModel> couponDetails = [];
  bool isLoading = false;

  DateTime from = DateTime(2021, 2, 1);
  DateTime to = DateTime.now();

  int? touchedIndex;
  late bool isArabic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    isArabic = locale.languageCode == 'ar';
  }

  @override
  void initState() {
    super.initState();
    loadSummary();
  }

  Future<void> loadSummary() async {
    setState(() => isLoading = true);
    final data = await loadCouponSummaryData(from: from, to: to);
    final rawCoupons = await CouponStatisticsServer.getStatistics(from: from, to: to);
    setState(() {
      stats = data;
      couponDetails = rawCoupons;
      isLoading = false;
    });
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

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: isArabic ? "ar" : "en", symbol: "ج.م");

    return Scaffold(
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
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : stats == null
                ? Center(child: Text(isArabic ? "⚠️ فشل في تحميل البيانات" : "⚠️ Failed to load data"))
                : LayoutBuilder(builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 700;

                    return SingleChildScrollView(
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
                                  loadSummary();
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildDateSelector(
                                label: isArabic ? "إلى" : "To",
                                selectedDate: to,
                                onDateSelected: (date) {
                                  setState(() => to = date);
                                  loadSummary();
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
                                  Icons.confirmation_number_outlined),
                              _buildStatCard(
                                  isArabic ? "إجمالي الخصومات" : "Total Discounts",
                                  currency.format(stats!.totalDiscount),
                                  Colors.red,
                                  Icons.money_off),
                              _buildStatCard(
                                  isArabic ? "مبيعات الكوبونات" : "Sales via Coupons",
                                  currency.format(stats!.totalSalesViaCoupon),
                                  Colors.green,
                                  Icons.shopping_cart),
                              _buildStatCard(
                                  isArabic ? "أرباح المؤثر" : "Influencer Profit",
                                  currency.format(stats!.totalInfluencerProfit),
                                  Colors.blue,
                                  Icons.person),
                              _buildStatCard(
                                  isArabic ? "أرباح النظام" : "System Profit",
                                  currency.format(stats!.totalSystemProfit),
                                  Colors.teal,
                                  Icons.account_balance),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text(isArabic ? "\uD83C\uDF1F توزيع الأرباح" : "\uD83C\uDF1F Profit Distribution",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          SizedBox(height: 220, child: _buildPieChart()),
                          const SizedBox(height: 32),
                          Text(isArabic ? "\uD83D\uDCCE تفاصيل الكوبونات" : "\uD83D\uDCCE Coupon Details",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: couponDetails.map((c) {
                              return SizedBox(
                                width: isWide ? 340 : double.infinity,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.local_offer, color: Colors.indigo),
                                            const SizedBox(width: 8),
                                            Text(
                                              c.couponCode,
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${c.totalUses}x",
                                              style: const TextStyle(color: Colors.deepPurple),
                                            ),
                                          ],
                                        ),
                                        const Divider(height: 16),
                                        _infoRow(isArabic ? "المؤثر" : "Influencer", c.influencerName ?? "-"),
                                        _infoRow("\uD83D\uDCB8 ${isArabic ? "الخصم" : "Discount"}", currency.format(c.totalDiscount)),
                                        _infoRow("\uD83D\uDED2 ${isArabic ? "المبيعات" : "Sales"}", currency.format(c.totalSalesViaCoupon)),
                                        _infoRow("\uD83D\uDC64 ${isArabic ? "ربح المؤثر" : "Influencer Profit"}", currency.format(c.influencerProfit)),
                                        _infoRow("\uD83C\uDFDB️ ${isArabic ? "ربح النظام" : "System Profit"}", currency.format(c.systemProfit)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    );
                  }),
      ),
    );
  }
}


                     // const Text("🧾 تفاصيل الكوبونات",
                        //     style: TextStyle(
                        //         fontSize: 20, fontWeight: FontWeight.bold)),
                        // const SizedBox(height: 16),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: DataTable(
                        //     columns: const [
                        //       DataColumn(label: Text("الكود")),
                        //       DataColumn(label: Text("المؤثر")),
                        //       DataColumn(label: Text("الاستخدامات")),
                        //       DataColumn(label: Text("الخصم")),
                        //       DataColumn(label: Text("المبيعات")),
                        //       DataColumn(label: Text("ربح المؤثر")),
                        //       DataColumn(label: Text("ربح النظام")),
                        //     ],
                        //     rows: couponDetails.map((c) {
                        //       return DataRow(cells: [
                        //         DataCell(Text(c.couponCode)),
                        //         DataCell(Text(c.influencerName ?? "-")),
                        //         DataCell(Text(c.totalUses.toString())),
                        //         DataCell(
                        //             Text(currency.format(c.totalDiscount))),
                        //         DataCell(Text(
                        //             currency.format(c.totalSalesViaCoupon))),
                        //         DataCell(
                        //             Text(currency.format(c.influencerProfit))),
                        //         DataCell(Text(currency.format(c.systemProfit))),
                        //       ]);
                        //     }).toList(),
                        //   ),
                        // ),