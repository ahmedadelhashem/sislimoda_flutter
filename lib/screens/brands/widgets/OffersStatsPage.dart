import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/OfferModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/offerSummary/offer_statistics_data.dart';

class OfferStatisticsScreen extends StatefulWidget {
  const OfferStatisticsScreen({super.key});

  @override
  State<OfferStatisticsScreen> createState() => _OfferStatisticsScreenState();
}

class _OfferStatisticsScreenState extends State<OfferStatisticsScreen> {
  DateTime from = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime to = DateTime.now();
  int touchedIndex = -1;

  List<ActiveOfferModel> offers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    final data = await loadOfferList(from: from, to: to);
    setState(() {
      offers = data;
      isLoading = false;
    });
  }

  Future<void> _selectDate({
    required DateTime initialDate,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onPicked(picked);
      await loadData();
    }
  }

  Widget _buildDateSelector(
      String label, DateTime date, Function(DateTime) onSelect) {
    return Expanded(
      child: InkWell(
        onTap: () => _selectDate(initialDate: date, onPicked: onSelect),
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
                  "$label: ${DateFormat('yyyy-MM-dd').format(date)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // تقسم العروض حسب النوع
    List<ActiveOfferModel> fixedOffers =
        offers.where((e) => e.offerType == 'مبلغ ثابت').toList();
    List<ActiveOfferModel> percentageOffers =
        offers.where((e) => e.offerType == 'نسبة مئوية').toList();
    double totalFixed = fixedOffers.fold(0.0, (sum, e) => sum + e.amount);
    double totalPercentage =
        percentageOffers.fold(0.0, (sum, e) => sum + e.amount);

    int percentageCount =
        offers.where((e) => e.offerType == 'نسبة مئوية').length;
    int fixedCount = offers.length - percentageCount;

    double totalAmount = offers.fold(0.0, (sum, e) => sum + e.amount);
    double avgAmount = offers.isNotEmpty ? totalAmount / offers.length : 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text("📊 إحصائيات العروض")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// اختيار التاريخ (من - إلى)
                    Row(
                      children: [
                        _buildDateSelector("من", from,
                            (picked) => setState(() => from = picked)),
                        const SizedBox(width: 16),
                        _buildDateSelector(
                            "إلى", to, (picked) => setState(() => to = picked)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// كروت الإحصائيات
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        buildStatCard(
                            "📦 عدد العروض", "${offers.length}", Colors.indigo),
                        buildStatCard(
                            "💵 خصومات مبلغ ثابت", "$totalFixed", Colors.red),
                        buildStatCard("📉 خصومات نسبة مئوية",
                            "$totalPercentage", Colors.blue),
                      ],
                    ),

                    const SizedBox(height: 30),
                    const Text("📊 توزيع أنواع العروض",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    if (offers.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (event, response) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      response == null ||
                                      response.touchedSection == null) {
                                    touchedIndex = -1;
                                  } else {
                                    touchedIndex = response
                                        .touchedSection!.touchedSectionIndex;
                                  }
                                });
                              },
                            ),
                            sections: [
                              PieChartSectionData(
                                value: percentageCount.toDouble(),
                                title: touchedIndex == 0
                                    ? "$percentageCount عرض"
                                    : 'نسبة مئوية',
                                color: Colors.blue,
                                radius: touchedIndex == 0 ? 70 : 60,
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: fixedCount.toDouble(),
                                title: touchedIndex == 1
                                    ? "$fixedCount عرض"
                                    : 'مبلغ ثابت',
                                color: Colors.red,
                                radius: touchedIndex == 1 ? 70 : 60,
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      const Text("لا توجد بيانات لعرضها"),

                    const SizedBox(height: 30),
                    const Text("📦 قيم الخصومات",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    if (offers.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, _) {
                                    int index = value.toInt();
                                    if (index < offers.length) {
                                      return Text(offers[index].code,
                                          style: const TextStyle(fontSize: 10));
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ),
                            barGroups: offers.asMap().entries.map((e) {
                              return BarChartGroupData(
                                x: e.key,
                                barRods: [
                                  BarChartRodData(
                                      toY: e.value.amount, color: Colors.teal),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                    const SizedBox(height: 30),
                    const Text("📋 تفاصيل العروض",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    if (percentageOffers.isNotEmpty) ...[
                      const Text("٪ نسبة مئوية",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: percentageOffers.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final offer = percentageOffers[index];
                          return ListTile(
                            title: Text("${offer.title} (${offer.code})"),
                            subtitle: Text(
                              "النوع: ${offer.offerType} | الخصم: ${offer.amount} | نهاية: ${DateFormat('yyyy-MM-dd').format(offer.endDate)}",
                            ),
                            leading: const Icon(Icons.local_offer),
                          );
                        },
                      ),
                    ],

                    const SizedBox(height: 20),

                    if (fixedOffers.isNotEmpty) ...[
                      const Text("💵 مبلغ ثابت",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fixedOffers.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final offer = fixedOffers[index];
                          return ListTile(
                            title: Text("${offer.title} (${offer.code})"),
                            subtitle: Text(
                              "النوع: ${offer.offerType} | الخصم: ${offer.amount} | نهاية: ${DateFormat('yyyy-MM-dd').format(offer.endDate)}",
                            ),
                            leading: const Icon(Icons.local_offer),
                          );
                        },
                      ),
                    ],
                    if (offers.isEmpty)
                      const Text("لا توجد عروض في هذه الفترة",
                          style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildStatCard(String title, String value, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: color)),
        ],
      ),
    );
  }
}
