// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
// import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
// import 'package:sislimoda_admin_dashboard/models/stati/VendorStatisticsData.dart';

// import 'package:sislimoda_admin_dashboard/services/app_services.dart';

// mixin ststisc {
  
//   Loading loading = Loading();
//   GenericCubit<List<VendorStatisticsData>> vendorStatsCubit =
//       GenericCubit<List<VendorStatisticsData>>();

//    getststisc() async {
 
//     loading.show();
//   print("⏳ Loading vendor list...");

//     try {
//           print("⏳ Calling /api/Vendor/GetAll");

//       var vendorsResult = await AppService.callService(
//         actionType: ActionType.get,
//         apiName: 'api/Vendor/GetAll',
//         body: {},
//       );

//       vendorsResult.fold((vendorsData) async {
//         List vendorList = jsonDecode(vendorsData);
//         List<VendorStatisticsData> statsList = [];
//       print("✅ Vendors fetched: ${vendorList.length}");

//         // نلف على كل Vendor ونجيب إحصائياته
//         for (var vendor in vendorList) {
//           final vendorId = vendor['id'];
//           final vendorName = vendor['name'];
//         print("🔍 Getting stats for $vendorName (ID: $vendorId)");

//           var statsResult = await AppService.callService(
//             actionType: ActionType.get,
//             apiName: 'api/Vendor/GetVendorStatistics?vendorId=$vendorId',
//             body: null,
//           );

//           statsResult.fold((success) {
//             final json = jsonDecode(success);
//                       print("📊 Stats for $vendorName: $json");

//             statsList.add(VendorStatisticsData.fromJson({
//               ...json,
//               'vendorId': vendorId,
//               'vendorName': vendorName,
//             }));
//           }, (error) {
//             print("فشل في vendor $vendorName: ${error.message}");
//                       print("❌ Failed to get stats for $vendorName: ${error.message}");

//           });
//         }

//         // نحدث البيانات في Cubit
//         vendorStatsCubit.update(data: statsList);
//       }, (error) {
//         showErrorMessage(message: error.message);
//       });
//     } catch (e) {
//       print("خطأ عام: $e");
//           print("❗ Exception occurred: $e");

//     }

//     loading.hide();
//   }
// }
