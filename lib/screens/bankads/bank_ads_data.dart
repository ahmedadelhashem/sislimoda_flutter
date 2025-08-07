import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/screens/bankads/widgets/Adservices.dart';
import 'package:sislimoda_admin_dashboard/screens/bankads/AdModel.dart';

mixin BankAdsData {
  final bankAdsCubit = GenericCubit<List<AdModel>>(data: []);
  final loading = GenericCubit<bool>(data: false);

  void fetchBankAds() async {
    loading.update(data: true);
    try {
      final ads = await AdServices.fetchAds();
      bankAdsCubit.update(data: ads);
    } catch (e) {
      bankAdsCubit.update(data: []);
      print('Error fetching ads: $e');
    }
    loading.update(data: false);
  }
}
