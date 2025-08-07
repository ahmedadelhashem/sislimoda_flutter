import 'package:easy_localization/easy_localization.dart';
// import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/cubits/categories_cubit/categories_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/chat_cubit/chat_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/notifications_cubit/notofocations_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/products_cubit/products_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/language.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.dart';
import 'package:sislimoda_admin_dashboard/routes/route_observer.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_theme.dart';

late BuildContext currentContext;
late BuildContext currentSideBarContext;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Locale currentLocale = await Lang.getDefaultOrStoredLocal();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar'),Locale('tr')],
    path: 'assets/translations',
    startLocale: currentLocale,
    fallbackLocale: const Locale('ar'),
    assetLoader: const CodegenLoader(),
    child: MyApp(
      currentLocale: currentLocale,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.currentLocale});

  final Locale currentLocale;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter router = AppRouter();

  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    currentContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => NotofocationsCubit()..getNotifications()),
          BlocProvider(create: (context) => UserCubit()..getUserData()),
          BlocProvider(create: (context) => ProductsCubit()..getProducts()),
          BlocProvider(create: (context) => CategoriesCubit()..getCategories()),
          BlocProvider(create: (context) => ChatCubit()..syncChat())
        ],
        child: ScreenUtilInit(
          designSize: MediaQuery.of(context).size.width < 700
              ? Size(360, 640)
              : Size(1440, 960),
          builder: (context, child) => child!,
          child: MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            routerConfig: router.config(
              navigatorObservers: () => [MyObserver()],
            ),
          ),
        ),
      ),
    );
  }
}
