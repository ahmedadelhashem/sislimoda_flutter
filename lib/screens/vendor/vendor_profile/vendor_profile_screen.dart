import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/components/tab_bar_custom.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_profile/vendor_profile_data.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_profile/widgets/profile_details.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_profile/widgets/store_data.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; 
@RoutePage()
class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen>
    with VendorProfileData {
            final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _refreshTimer;
  @override
  void initState() {
     checkForNewOrders();
 _startAutoCheck();
    // TODO: implement initState
    getVendorData();
    super.initState();
  }

  void _startAutoCheck() {
    _refreshTimer = Timer.periodic(Duration(seconds: 40), (timer) {
      checkForNewOrders();
    });
  }

void checkForNewOrders() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final result = await AppService.callService(
    actionType: ActionType.get,
    apiName:
        'api/Orders/GetVendorOrderedProduct?VendorId=${prefs.getString('vendorId')}',
    body: null,
  );

  result.fold((success) async {
    final orders = orderModelModelFromJson(success);
    final newOrdersCount = orders
        .where((e) => e?.orderStatus?.nameEn?.toLowerCase() == 'new')
        .length;

    VendorSideBarState.newOrdersCountCubit.update(data: newOrdersCount);

    final lastCount = prefs.getInt('lastNewOrdersCount') ?? 0;
    if (newOrdersCount > lastCount) {
      playNotificationSound();

      await prefs.setInt('lastNewOrdersCount', newOrdersCount);

      if (mounted) {
showDialog(
  context: context,
  builder: (ctx) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(Icons.notifications_active, color: Colors.orange, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isArabic ? "طلب جديد!" : "New Order!",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isArabic
                ? "تم استلام طلب جديد الآن.\nهل تريد الانتقال لعرض الطلبات؟"  
                : "A new order has just been received.\nWould you like to view it now?",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 15),
          Icon(Icons.shopping_cart_outlined, color: Colors.blueAccent, size: 40),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
          label: Text(
            isArabic ? "عرض الطلبات" : "View Orders",
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(ctx);
            context.router.push(const VendorOrdersRoute());
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(
            isArabic ? "لاحقاً" : "Later",
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  },
);

      }
    }
  }, (failure) {
  });
}

void playNotificationSound() {
  if (kIsWeb) {
    final audio = html.AudioElement()
      ..src = 'assets/sounds/spaceline.mp3'
      ..autoplay = false
      ..preload = 'auto';

    html.document.body?.append(audio); // بعض المتصفحات تحتاجه

    audio.onCanPlay.first.then((_) {
      audio.play();
    }).catchError((e) {
      print('Web audio play error: $e');
    });
  } else {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('sounds/spaceline.mp3'));
  }
}

  @override
  void dispose() {
    _refreshTimer?.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
      ),
      body: Screen(
        loadingCubit: BlocProvider.of<UserCubit>(context).loading,
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserLoaded) {
            return Container(
              width: double.infinity,
              height: 1.sh,
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TabBarCustom(tabNames: [
                LocaleKeys.storeDetails.tr()
                , LocaleKeys.profileDetails.tr()
              ], children: [                
                GenericBuilder(
                    genericCubit: vendorCubit,
                    builder: (vendor) {
                      return StoreData(
                        vendorModel: vendor,
                      );
                    }),
                ProfileDetails(
                  user: state.user,
                ),
              ]),
            );
          }
          return SizedBox(
            height: 1.sh,
            width: double.infinity,
          );
        }),
        
      ),
    );
  }
}
