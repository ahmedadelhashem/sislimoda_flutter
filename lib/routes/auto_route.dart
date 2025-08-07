import 'package:auto_route/auto_route.dart';
import 'package:sislimoda_admin_dashboard/routes/middlewares/auth_middle_ware.dart';
import 'package:sislimoda_admin_dashboard/routes/middlewares/dashboard_middleware.dart';
import 'package:sislimoda_admin_dashboard/routes/middlewares/vendor_dashboard_middleware.dart';
import 'package:sislimoda_admin_dashboard/screens/statis/vendor_statis_screen.dart';

import 'auto_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          initial: true,
          guards: [AuthMiddleWare()],
          path: Routes.splashPath,
        ),
        AutoRoute(
          page: SignupRoute.page,
          path: Routes.signup,
        ),
        AutoRoute(
          page: ForgetPasswordRoute.page,
          path: Routes.forgetPassword,
        ),
        AutoRoute(
          page: ResetPasswordRoute.page,
          path: Routes.resetPassword,
        ),
        AutoRoute(
            page: DashBoardLayout.page,
            guards: [DashBoardMiddleWare()],
            path: Routes.dashboard,
            children: [
              RedirectRoute(path: '', redirectTo: Routes.overView),
              AutoRoute(
                page: OverviewRoute.page,
                path: Routes.overView,
              ),
              AutoRoute(
                page: Orders.page,
                path: Routes.orders,
              ),
              AutoRoute(
                page: OrderDetailsRoute.page,
                initial: false,
                guards: [DashBoardMiddleWare()],
                path: Routes.orderDetails,
              ),
              AutoRoute(
                page: OffersRoute.page,
                path: Routes.offers,
              ),
              AutoRoute(page: Products.page, path: Routes.products),
              AutoRoute(
                page: PharmaciesRoute.page,
                path: Routes.vendors,
              ),
              AutoRoute(
                page: VendorDetails.page,
                path: Routes.vendorDetails,
              ),
              AutoRoute(
                page: UsersRoute.page,
                path: Routes.users,
              ),
              AutoRoute(
                page: Categories.page,
                path: Routes.categories,
              ),
              AutoRoute(
                page: CategoryDetailsRoute.page,
                path: Routes.categoryDetails,
              ),
              AutoRoute(
                page: BrandsRoute.page,
                path: Routes.brands,
              ),
              AutoRoute(
                page: Coupons.page,
                path: Routes.coupons,
              ),
              AutoRoute(
                page: ChatsRoute.page,
                path: Routes.customerSupport,
              ),
              AutoRoute(
                page: SupportTicketsRoute.page,
                path: Routes.supportTickets,
              ),
              AutoRoute(
                page: SettingsRoute.page,
                path: Routes.settings,
              ),
              AutoRoute(
                page: OptionSetItemDetailsRoute.page,
                path: Routes.optionSetItemDetails,
              ),
              AutoRoute(
                page: ReviewsRoute.page,
                path: Routes.reviews,
              ),
              AutoRoute(
                page: SubCategoriesRoute.page,
                path: Routes.subCategories,
              ),
              AutoRoute(
                page: SubSubCategoriesRoute.page,
                path: Routes.subSubCategories,
              ),
              AutoRoute(
                page: ReviewDetailsRoute.page,
                path: Routes.reviewDetails,
              ),
              AutoRoute(
                page: BannersRoute.page,
                path: Routes.banners,
              ),
              AutoRoute(
                page: CouponDetailsRoute.page,
                path: Routes.couponsDetails,
              ),
              AutoRoute(
                page: SupportTicketsDetailsRoute.page,
                path: Routes.supportTicketsDetails,
              ),
//               AutoRoute(
//   page: VendorStatisticsRoute.page, // auto_route بيولد ده
//   path: Routes.vendorStatistics,
// ),

AutoRoute(
  page: BankAdsRoute.page, // << أضف هذا
  path: Routes.bankAds,    // << معرف المسار
),
            ]),
        AutoRoute(
            page: VendorHomeLayout.page,
            guards: [VendorDashBoardMiddleWare()],
            path: Routes.vendorHomeLayout,
            children: [
              RedirectRoute(path: '', redirectTo: Routes.vendorProfile),
              AutoRoute(
                page: VendorOverviewRoute.page,
                path: Routes.vendorOverview,
              ),
              AutoRoute(
                page: EditProductRoute.page,
                path: Routes.editProduct,
              ),
              AutoRoute(
                page: VendorOrdersRoute.page,
                path: Routes.vendorOrders,
              ),
              AutoRoute(
                page: VendorProductsRoute.page,
                path: Routes.vendorProducts,
              ),
              AutoRoute(
                page: VendorMessagesRoute.page,
                path: Routes.vendorChat,
              ),
              AutoRoute(
                page: VendorProfileRoute.page,
                path: Routes.vendorProfile,
              ),
              AutoRoute(
                page: OrderDetailsRoute.page,
                path: Routes.orderDetails,
              ),
              AutoRoute(
                page: AddProductsNewRoute.page,
                path: Routes.addProducts,
              ),
            ]),
      ];
}

class Routes {
  static const String splashPath = '/auth/login';
  static const String signup = '/auth/signup';
  static const String forgetPassword = '/auth/forgetPassword';
  static const String resetPassword = '/auth/resetPassword/:email';
  static const String dashboard = '/dashboard';
  static const String overView = 'overView';
  static const String vendorOverview = 'vendorOverview';
  static const String orders = 'orders';
  static const String vendorOrders = 'vendorOrders';
  static const String offers = 'offers';
  static const String reviews = 'reviews';
  static const String reviewDetails = 'reviews/:reviewId';
  static const String addProduct = 'addProduct';
  static const String products = 'products';
  static const String editProduct = 'vendorProducts/:productId';
  static const String vendorProducts = 'vendorProducts';
  static const String supportTickets = 'supportTickets';
  static const String supportTicketsDetails = 'supportTickets/:ticketId';
  static const String vendors = 'vendors';
  static const String coupons = 'coupons';
  static const String couponsDetails = 'coupons/:couponId';
  static const String vendorDetails = 'vendorDetails/:vendorId';
  static const String users = 'users';
  static const String categories = 'categories';
  static const String categoryDetails = 'categories/:categoryId';
  static const String subCategories = 'subCategories/:categoryId';
  static const String subSubCategories = 'subSubCategories/:categoryId';
  static const String brands = 'brands';
  static const String addProducts = 'addProducts';
  static const String customerSupport = 'customerSupport';
  static const String vendorChat = 'vendorChat';
  static const String vendorProfile = 'vendorProfile';
  static const String settings = 'settings';
  static const String optionSetItemDetails =
      'optionSetItemDetailsRoute/:optionSetId';
  static const String vendorHomeLayout = '/vendor';
  static const String banners = 'banners';
  static const String orderDetails = 'orderDetails/:orderId';
  static const String vendorStatistics = 'vendorStatistics';
static const String bankAds = 'bankAds';

}
