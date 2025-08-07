import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';

class DashBoardMiddleWare extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    // ref.clear();

    String? userToken = ref.getString(LocalStoreNames.userToken);
    String? role = ref.getString('role');
    if (userToken != null) {
      if (role == 'vendor') {
        router.replace(VendorHomeLayout());
      } else if (role == 'admin') {
        resolver.next(true);
      }
    } else {
      router.replace(LoginRoute());
    }
  }
}
