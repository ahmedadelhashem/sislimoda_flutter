import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/InfluencerSummaryModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/fluencerSummary/InfluencersSummary_data.dart';
import 'dart:ui' as ui;

class InfluencerSummaryScreen extends StatefulWidget {
  const InfluencerSummaryScreen({super.key});

  @override
  State<InfluencerSummaryScreen> createState() => _InfluencerSummaryScreenState();
}

class _InfluencerSummaryScreenState extends State<InfluencerSummaryScreen> {
  List<InfluencerSummaryModel> influencers = [];
  bool isLoading = false;

  int totalSoldProducts = 0;
  double totalRevenue = 0;
  int totalProducts = 0;

  DateTime fromDate = DateTime(2024, 1, 1);
  DateTime toDate = DateTime.now();

  Locale get currentLocale => Localizations.localeOf(context);
  bool get isArabic => currentLocale.languageCode == 'ar';

  @override
  void initState() {
    super.initState();
    loadInfluencerSummaryData();
  }

  Future<void> loadInfluencerSummaryData() async {
    setState(() => isLoading = true);

    try {
      List<InfluencerSummaryModel> list = await getAllInfluencersSummary(
        from: fromDate,
        to: toDate,
      );

      int sold = 0;
      double revenue = 0;
      int product = 0;

      for (var influencer in list) {
        sold += influencer.totalSoldProducts;
        revenue += influencer.totalRevenue;
        product += influencer.totalProduct;
      }

      setState(() {
        influencers = list;
        totalSoldProducts = sold;
        totalRevenue = revenue;
        totalProducts = product;
        isLoading = false;
      });
    } catch (e) {
      print('خطأ في التحميل: $e');
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
            locale: currentLocale,
          );
          if (picked != null) {
            onDateSelected(picked);
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

  Widget _buildStatBox(String title, String value, IconData icon, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 700;

    return Directionality(
   textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          title: Text(
            isArabic ? 'ملخص المؤثرين' : 'Influencers Summary',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: loadInfluencerSummaryData,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      _buildDateSelector(isArabic ? 'من' : 'From', fromDate, (date) {
                        setState(() => fromDate = date);
                        loadInfluencerSummaryData();
                      }),
                      const SizedBox(width: 10),
                      _buildDateSelector(isArabic ? 'إلى' : 'To', toDate, (date) {
                        setState(() => toDate = date);
                        loadInfluencerSummaryData();
                      }),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatBox(isArabic ? 'إجمالي المنتج' : 'Total Products', totalProducts.toString(), Icons.inventory_2_outlined, Colors.deepPurple, 180),
                      _buildStatBox(isArabic ? 'المنتجات المباعة' : 'Sold Products', totalSoldProducts.toString(), Icons.shopping_cart_outlined, Colors.blue, 180),
                      _buildStatBox(isArabic ? 'إجمالي الإيرادات' : 'Revenue', totalRevenue.toStringAsFixed(2), Icons.attach_money, Colors.green, 180),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: influencers.length,
                        itemBuilder: (context, index) {
                          final influencer = influencers[index];
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.teal.shade100,
                                        radius: 24,
                                        child: Text(
                                          influencer.influencerName?.substring(0, 1).toUpperCase() ?? '?',
                                          style: TextStyle(
                                            color: Colors.teal.shade800,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              influencer.influencerName ?? (isArabic ? 'غير معروف' : 'Unknown'),
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${isArabic ? '📦 المنتجات' : '📦 Products'}: ${influencer.totalProduct}  |  ${isArabic ? '🛒 المباعة' : '🛒 Sold'}: ${influencer.totalSoldProducts}  |  ${isArabic ? '💵 الإيراد' : '💵 Revenue'}: ${influencer.totalRevenue.toStringAsFixed(2)}',
                                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Divider(color: Colors.grey.shade300),
                                  if (influencer.topSellingProducts.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      isArabic ? '🔥 المنتجات الأكثر مبيعًا:' : '🔥 Top Selling Products:',
                                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: influencer.topSellingProducts.map((p) {
                                        return Chip(
                                          label: Text('${p.productName} (${p.totalSold})'),
                                          backgroundColor: Colors.teal.shade50,
                                          labelStyle: TextStyle(
                                            color: Colors.teal.shade800,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        );
                                      }).toList(),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sislimoda_admin_dashboard/models/statistics/InfluencerSummaryModel.dart';
// import 'package:sislimoda_admin_dashboard/screens/brands/fluencerSummary/InfluencersSummary_data.dart';

// class InfluencerSummaryScreen extends StatefulWidget {
//   const InfluencerSummaryScreen({super.key});

//   @override
//   State<InfluencerSummaryScreen> createState() => _InfluencerSummaryScreenState();
// }

// class _InfluencerSummaryScreenState extends State<InfluencerSummaryScreen> {
//   List<InfluencerSummaryModel> summaries = [];
//   bool loading = true;
//   int totalSold = 0;
//   double totalRevenue = 0;
//   int totalProducts = 0;

//   @override
//   void initState() {
//     super.initState();
//     loadSummary();
//   }

//   Future<void> loadSummary() async {
//     try {
//       final list = await getAllInfluencersSummary(
//         from: DateTime(2022, 1, 1),
//         to: DateTime(2025, 7, 1),
//       );

//       int sold = 0;
//       double revenue = 0;
//       int products = 0;

//       for (var e in list) {
//         sold += e.totalSoldProducts;
//         revenue += e.totalRevenue;
//         products += e.totalProduct;
//       }

//       setState(() {
//         summaries = list;
//         totalSold = sold;
//         totalRevenue = revenue;
//         totalProducts = products;
//         loading = false;
//       });
//     } catch (e) {
//       setState(() => loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('حدث خطأ: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('ملخص المؤثرين')),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 _buildSummaryCards(),
//                 const SizedBox(height: 20),
//                 Expanded(child: _buildInfluencersTable()),
//               ],
//             ),
//     );
//   }

//   Widget _buildSummaryCards() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         children: [
//           _card(Icons.attach_money, 'إجمالي الإيرادات', '${totalRevenue.toStringAsFixed(2)} ج.م', Colors.green),
//           _card(Icons.shopping_cart, 'المنتجات المباعة', '$totalSold قطعة', Colors.blue),
//           _card(Icons.inventory, 'عدد المنتجات', '$totalProducts منتج', Colors.orange),
//         ],
//       ),
//     );
//   }

//   Widget _card(IconData icon, String title, String value, Color color) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Container(
//         width: 250,
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: color.withOpacity(0.1),
//               child: Icon(icon, color: color),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Text(value, style: const TextStyle(fontSize: 14)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfluencersTable() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ListView(
//         children: [
//           DataTable(
//             columnSpacing: 20,
//             headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
//             columns: const [
//               DataColumn(label: Text('الاسم')),
//               DataColumn(label: Text('عدد المنتجات')),
//               DataColumn(label: Text('المنتجات المباعة')),
//               DataColumn(label: Text('الإيرادات')),
//               DataColumn(label: Text('الأكثر مبيعًا')),
//             ],
//             rows: summaries.map((e) {
//               final topProducts = e.topSellingProducts
//                   .map((p) => '${p.productName} (${p.totalSold})')
//                   .join(', ');

//               return DataRow(cells: [
//                 DataCell(Text(e.influencerName ?? 'غير معروف')),
//                 DataCell(Text('${e.totalProduct}')),
//                 DataCell(Text('${e.totalSoldProducts}')),
//                 DataCell(Text('${e.totalRevenue.toStringAsFixed(2)}')),
//                 DataCell(Text(topProducts.isNotEmpty ? topProducts : '-')),
//               ]);
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
