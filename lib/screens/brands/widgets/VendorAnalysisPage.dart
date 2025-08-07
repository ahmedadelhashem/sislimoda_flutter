import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/vendor_product_stat.dart'
    hide GetAnalysisModelTopSellingProducts;
import 'package:sislimoda_admin_dashboard/screens/brands/VendorSummary/getAllVendors.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/VendorSummary/vendor_statistics_data.dart';

class AllVendorsStatisticsScreen extends StatefulWidget {
  const AllVendorsStatisticsScreen({super.key});

  @override
  State<AllVendorsStatisticsScreen> createState() => _AllVendorsStatisticsScreenState();
}

class _AllVendorsStatisticsScreenState extends State<AllVendorsStatisticsScreen> {
  bool isLoading = true;
  List<VendorModel> vendors = [];
  Map<String, VendorStatisticsSummary> statsMap = {};

  DateTime from = DateTime.now().subtract(const Duration(days: 80));
  DateTime to = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  Future<void> fetchAll() async {
    setState(() => isLoading = true);
    statsMap.clear();

    try {
      final allVendors = await VendorService.getAllVendors();
      setState(() => vendors = allVendors);

      for (var vendor in allVendors) {
        final stats = await loadVendorStatisticsData(
          vendorId: vendor.id,
          from: from,
          to: to,
        );
        if (stats != null && stats.totalSoldProducts > 0) {
          statsMap[vendor.id] = stats;
        }
      }
    } catch (e) {
      print("❌ فشل تحميل البيانات: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildDateSelector(String label, DateTime selectedDate, Function(DateTime) onDateSelected) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
            locale: const Locale('ar'),
          );
          if (picked != null) {
            onDateSelected(picked);
            fetchAll();
          }
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
              Text('$label: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForProduct(String? productId) {
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.cyan,
      Colors.indigo,
    ];
    if (productId == null) return Colors.grey;
    final index = productId.codeUnits.fold(0, (a, b) => a + b) % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<VendorStatisticsSummary> availableStats = statsMap.values.toList();

    final totalSold = availableStats.fold(0, (sum, item) => sum + (item.totalSoldProducts ?? 0));
    final totalRevenue = availableStats.fold(0.0, (sum, item) => sum + (item.totalRevenue ?? 0.0));
    final totalProducts = availableStats.fold(0, (sum, item) => sum + (item.totalProducts ?? 0));

    final allTopProducts = <GetAnalysisModelTopSellingProducts>[];
    for (var stats in availableStats) {
      allTopProducts.addAll(List<GetAnalysisModelTopSellingProducts>.from(stats.topSellingProducts));
    }

    final topProduct = allTopProducts.isNotEmpty ? allTopProducts.first : null;

    return  Padding(
  padding: const EdgeInsets.all(12),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🗓️ اختيار التاريخ
        Row(
          children: [
            _buildDateSelector("من", from, (date) => setState(() => from = date)),
            const SizedBox(width: 12),
            _buildDateSelector("إلى", to, (date) => setState(() => to = date)),
          ],
        ),
        const SizedBox(height: 16),

        // 📊 كروت الإجمالي
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryCard("📦 المنتجات المباعة", totalSold.toString()),
            _buildSummaryCard("💰 الإيرادات", "${totalRevenue.toStringAsFixed(2)}"),
            _buildSummaryCard("🛒 إجمالي المنتجات", totalProducts.toString()),
          ],
        ),
        const SizedBox(height: 16),

        // 🔥 المنتج الأعلى مبيعًا
        if (topProduct != null)
          Card(
            color: Colors.amber.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "المنتج الأكثر مبيعًا: ${topProduct.product?.name ?? ''} (${topProduct.totalSales})",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 16),

        // 🟡 رسم بياني
        if (allTopProducts.isNotEmpty)
          SizedBox(
            height: 280,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("📊 نسبة مبيعات المنتجات الأكثر مبيعًا", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 180,
                      child: PieChart(
                        PieChartData(
                          sections: allTopProducts.take(5).map((product) {
                            final value = (product.totalSales ?? 0).hashCode.toDouble();
                            return PieChartSectionData(
                              color: _getColorForProduct(product.productId),
                              value: value,
                              title: '${product.product?.name ?? ''}\n(${product.totalSales})',
                              radius: 60,
                              titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                            );
                          }).toList(),
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        const SizedBox(height: 16),

        // 👤 تفاصيل البائعين
        ...vendors.map((vendor) {
          final stats = statsMap[vendor.id];
          if (stats == null) return const SizedBox();
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👤 ${vendor.name}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("🛒 المنتجات المباعة: ${stats.totalSoldProducts}"),
                  Text("💰 الإيرادات: ${stats.totalRevenue}"),
                  Text("📦 إجمالي المنتجات: ${stats.totalProducts}"),
                  const SizedBox(height: 8),
                  const Text("🔥 المنتجات الأكثر مبيعًا:"),
                  ...stats.topSellingProducts.take(3).map(
                    (p) => Text("- ${p.product?.name} (${p.totalSales})"),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    ),
  ),
);

  }

  Widget _buildSummaryCard(String title, String value) {
    return Expanded(
      child: Card(
        color: Colors.teal.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 18, color: Colors.teal)),
            ],
          ),
        ),
      ),
    );
  }
}
