// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i39;
import 'package:flutter/cupertino.dart' as _i41;
import 'package:flutter/material.dart' as _i40;
import 'package:sislimoda_admin_dashboard/screens/add_products/add_products_screen.dart'
    as _i2;
import 'package:sislimoda_admin_dashboard/screens/Auth/forget_password/forget_password.dart'
    as _i13;
import 'package:sislimoda_admin_dashboard/screens/Auth/login/login_screen.dart'
    as _i14;
import 'package:sislimoda_admin_dashboard/screens/Auth/reset_password/reset_password.dart'
    as _i22;
import 'package:sislimoda_admin_dashboard/screens/Auth/signup/signup_screen.dart'
    as _i26;
import 'package:sislimoda_admin_dashboard/screens/bankads/bank_ads.dart' as _i3;
import 'package:sislimoda_admin_dashboard/screens/banners/banners_screen.dart'
    as _i4;
import 'package:sislimoda_admin_dashboard/screens/brands/brands.dart' as _i5;
import 'package:sislimoda_admin_dashboard/screens/categories/categories.dart'
    as _i6;
import 'package:sislimoda_admin_dashboard/screens/category_details/category_details_screen.dart'
    as _i7;
import 'package:sislimoda_admin_dashboard/screens/chat/chats_screen.dart'
    as _i8;
import 'package:sislimoda_admin_dashboard/screens/coupon_details_screen/coupon_details_screen.dart'
    as _i9;
import 'package:sislimoda_admin_dashboard/screens/coupons_screen/coupon.dart'
    as _i10;
import 'package:sislimoda_admin_dashboard/screens/dashboard/dashboard_layout.dart'
    as _i11;
import 'package:sislimoda_admin_dashboard/screens/edit_product_screen/edit_product_screen.dart'
    as _i12;
import 'package:sislimoda_admin_dashboard/screens/offers/offers.dart' as _i15;
import 'package:sislimoda_admin_dashboard/screens/order_details/order_details.dart'
    as _i17;
import 'package:sislimoda_admin_dashboard/screens/orders/orders.dart' as _i18;
import 'package:sislimoda_admin_dashboard/screens/overview/overview.dart'
    as _i19;
import 'package:sislimoda_admin_dashboard/screens/pharmacies/pharmacies.dart'
    as _i20;
import 'package:sislimoda_admin_dashboard/screens/products/products.dart'
    as _i21;
import 'package:sislimoda_admin_dashboard/screens/review_details_screen/review_details_screen.dart'
    as _i23;
import 'package:sislimoda_admin_dashboard/screens/reviews_screen/reviews_screen.dart'
    as _i24;
import 'package:sislimoda_admin_dashboard/screens/settings/option_set_item_details/option_set_item_details_screen.dart'
    as _i16;
import 'package:sislimoda_admin_dashboard/screens/settings/settings_screen.dart'
    as _i25;
import 'package:sislimoda_admin_dashboard/screens/sub_categories_screen/subcategires_screen.dart'
    as _i27;
import 'package:sislimoda_admin_dashboard/screens/sub_sub_categories_screen/sub_sub_categories_screen.dart'
    as _i28;
import 'package:sislimoda_admin_dashboard/screens/support_tickets/support_ticket_dtails/support_tickets_details_screen.dart'
    as _i29;
import 'package:sislimoda_admin_dashboard/screens/support_tickets/support_tickets_screen.dart'
    as _i30;
import 'package:sislimoda_admin_dashboard/screens/users/users.dart' as _i31;
import 'package:sislimoda_admin_dashboard/screens/vendor/add_products_screen/add_products_screen.dart'
    as _i1;
import 'package:sislimoda_admin_dashboard/screens/vendor/home_layout/home_layout.dart'
    as _i33;
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_messages/vendor_messages_screen.dart'
    as _i34;
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_orders_screen/vendor_orders_screen.dart'
    as _i35;
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_overview_screen/vendor_overview_screen.dart'
    as _i36;
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_products_screen/vendor_products_screen.dart'
    as _i37;
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_profile/vendor_profile_screen.dart'
    as _i38;
import 'package:sislimoda_admin_dashboard/screens/vendor_details/vendor_details.dart'
    as _i32;

abstract class $AppRouter extends _i39.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i39.PageFactory> pagesMap = {
    AddProductsNewRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddProductsNewScreen(),
      );
    },
    AddProductsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddProductsScreen(),
      );
    },
    BankAdsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BankAdsScreen(),
      );
    },
    BannersRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BannersScreen(),
      );
    },
    BrandsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.BrandsScreen(),
      );
    },
    Categories.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.Categories(),
      );
    },
    CategoryDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CategoryDetailsRouteArgs>(
          orElse: () => CategoryDetailsRouteArgs(
              categoryId: pathParams.getString('categoryId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.CategoryDetailsScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    ChatsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ChatsScreen(),
      );
    },
    CouponDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CouponDetailsRouteArgs>(
          orElse: () => CouponDetailsRouteArgs(
              couponId: pathParams.getString('couponId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.CouponDetailsScreen(
          key: args.key,
          couponId: args.couponId,
        ),
      );
    },
    Coupons.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.Coupons(),
      );
    },
    DashBoardLayout.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.DashBoardLayout(),
      );
    },
    EditProductRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditProductRouteArgs>(
          orElse: () => EditProductRouteArgs(
              productId: pathParams.getString('productId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.EditProductScreen(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ForgetPasswordRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ForgetPasswordScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.LoginScreen(),
      );
    },
    OffersRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.OffersScreen(),
      );
    },
    OptionSetItemDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OptionSetItemDetailsRouteArgs>(
          orElse: () => OptionSetItemDetailsRouteArgs(
              optionSetId: pathParams.getString('optionSetId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.OptionSetItemDetailsScreen(
          key: args.key,
          optionSetId: args.optionSetId,
        ),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderDetailsRouteArgs>(
          orElse: () =>
              OrderDetailsRouteArgs(orderId: pathParams.getString('orderId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.OrderDetailsScreen(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    Orders.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.Orders(),
      );
    },
    OverviewRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.OverviewScreen(),
      );
    },
    PharmaciesRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.PharmaciesScreen(),
      );
    },
    Products.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.Products(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () =>
              ResetPasswordRouteArgs(email: pathParams.getString('email')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.ResetPasswordScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    ReviewDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReviewDetailsRouteArgs>(
          orElse: () => ReviewDetailsRouteArgs(
              reviewId: pathParams.getString('reviewId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.ReviewDetailsScreen(
          key: args.key,
          reviewId: args.reviewId,
        ),
      );
    },
    ReviewsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.ReviewsScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.SettingsScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.SignupScreen(),
      );
    },
    SubCategoriesRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SubCategoriesRouteArgs>(
          orElse: () => SubCategoriesRouteArgs(
              categoryId: pathParams.getString('categoryId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.SubCategoriesScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    SubSubCategoriesRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SubSubCategoriesRouteArgs>(
          orElse: () => SubSubCategoriesRouteArgs(
              categoryId: pathParams.getString('categoryId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.SubSubCategoriesScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    SupportTicketsDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SupportTicketsDetailsRouteArgs>(
          orElse: () => SupportTicketsDetailsRouteArgs(
              ticketId: pathParams.getString('ticketId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i29.SupportTicketsDetailsScreen(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    SupportTicketsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.SupportTicketsScreen(),
      );
    },
    UsersRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.UsersScreen(),
      );
    },
    VendorDetails.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VendorDetailsArgs>(
          orElse: () =>
              VendorDetailsArgs(vendorId: pathParams.getString('vendorId')));
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.VendorDetails(
          key: args.key,
          vendorId: args.vendorId,
        ),
      );
    },
    VendorHomeLayout.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.VendorHomeLayout(),
      );
    },
    VendorMessagesRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.VendorMessagesScreen(),
      );
    },
    VendorOrdersRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.VendorOrdersScreen(),
      );
    },
    VendorOverviewRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.VendorOverviewScreen(),
      );
    },
    VendorProductsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.VendorProductsScreen(),
      );
    },
    VendorProfileRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.VendorProfileScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddProductsNewScreen]
class AddProductsNewRoute extends _i39.PageRouteInfo<void> {
  const AddProductsNewRoute({List<_i39.PageRouteInfo>? children})
      : super(
          AddProductsNewRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddProductsNewRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddProductsScreen]
class AddProductsRoute extends _i39.PageRouteInfo<void> {
  const AddProductsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          AddProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddProductsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BankAdsScreen]
class BankAdsRoute extends _i39.PageRouteInfo<void> {
  const BankAdsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          BankAdsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BankAdsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BannersScreen]
class BannersRoute extends _i39.PageRouteInfo<void> {
  const BannersRoute({List<_i39.PageRouteInfo>? children})
      : super(
          BannersRoute.name,
          initialChildren: children,
        );

  static const String name = 'BannersRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i5.BrandsScreen]
class BrandsRoute extends _i39.PageRouteInfo<void> {
  const BrandsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          BrandsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrandsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i6.Categories]
class Categories extends _i39.PageRouteInfo<void> {
  const Categories({List<_i39.PageRouteInfo>? children})
      : super(
          Categories.name,
          initialChildren: children,
        );

  static const String name = 'Categories';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CategoryDetailsScreen]
class CategoryDetailsRoute
    extends _i39.PageRouteInfo<CategoryDetailsRouteArgs> {
  CategoryDetailsRoute({
    _i40.Key? key,
    required String categoryId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          CategoryDetailsRoute.name,
          args: CategoryDetailsRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'categoryId': categoryId},
          initialChildren: children,
        );

  static const String name = 'CategoryDetailsRoute';

  static const _i39.PageInfo<CategoryDetailsRouteArgs> page =
      _i39.PageInfo<CategoryDetailsRouteArgs>(name);
}

class CategoryDetailsRouteArgs {
  const CategoryDetailsRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i40.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'CategoryDetailsRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i8.ChatsScreen]
class ChatsRoute extends _i39.PageRouteInfo<void> {
  const ChatsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ChatsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CouponDetailsScreen]
class CouponDetailsRoute extends _i39.PageRouteInfo<CouponDetailsRouteArgs> {
  CouponDetailsRoute({
    _i40.Key? key,
    required String couponId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          CouponDetailsRoute.name,
          args: CouponDetailsRouteArgs(
            key: key,
            couponId: couponId,
          ),
          rawPathParams: {'couponId': couponId},
          initialChildren: children,
        );

  static const String name = 'CouponDetailsRoute';

  static const _i39.PageInfo<CouponDetailsRouteArgs> page =
      _i39.PageInfo<CouponDetailsRouteArgs>(name);
}

class CouponDetailsRouteArgs {
  const CouponDetailsRouteArgs({
    this.key,
    required this.couponId,
  });

  final _i40.Key? key;

  final String couponId;

  @override
  String toString() {
    return 'CouponDetailsRouteArgs{key: $key, couponId: $couponId}';
  }
}

/// generated route for
/// [_i10.Coupons]
class Coupons extends _i39.PageRouteInfo<void> {
  const Coupons({List<_i39.PageRouteInfo>? children})
      : super(
          Coupons.name,
          initialChildren: children,
        );

  static const String name = 'Coupons';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i11.DashBoardLayout]
class DashBoardLayout extends _i39.PageRouteInfo<void> {
  const DashBoardLayout({List<_i39.PageRouteInfo>? children})
      : super(
          DashBoardLayout.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardLayout';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i12.EditProductScreen]
class EditProductRoute extends _i39.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    _i40.Key? key,
    required String productId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          EditProductRoute.name,
          args: EditProductRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'productId': productId},
          initialChildren: children,
        );

  static const String name = 'EditProductRoute';

  static const _i39.PageInfo<EditProductRouteArgs> page =
      _i39.PageInfo<EditProductRouteArgs>(name);
}

class EditProductRouteArgs {
  const EditProductRouteArgs({
    this.key,
    required this.productId,
  });

  final _i40.Key? key;

  final String productId;

  @override
  String toString() {
    return 'EditProductRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i13.ForgetPasswordScreen]
class ForgetPasswordRoute extends _i39.PageRouteInfo<void> {
  const ForgetPasswordRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ForgetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i14.LoginScreen]
class LoginRoute extends _i39.PageRouteInfo<void> {
  const LoginRoute({List<_i39.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i15.OffersScreen]
class OffersRoute extends _i39.PageRouteInfo<void> {
  const OffersRoute({List<_i39.PageRouteInfo>? children})
      : super(
          OffersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OffersRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OptionSetItemDetailsScreen]
class OptionSetItemDetailsRoute
    extends _i39.PageRouteInfo<OptionSetItemDetailsRouteArgs> {
  OptionSetItemDetailsRoute({
    _i40.Key? key,
    required String optionSetId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          OptionSetItemDetailsRoute.name,
          args: OptionSetItemDetailsRouteArgs(
            key: key,
            optionSetId: optionSetId,
          ),
          rawPathParams: {'optionSetId': optionSetId},
          initialChildren: children,
        );

  static const String name = 'OptionSetItemDetailsRoute';

  static const _i39.PageInfo<OptionSetItemDetailsRouteArgs> page =
      _i39.PageInfo<OptionSetItemDetailsRouteArgs>(name);
}

class OptionSetItemDetailsRouteArgs {
  const OptionSetItemDetailsRouteArgs({
    this.key,
    required this.optionSetId,
  });

  final _i40.Key? key;

  final String optionSetId;

  @override
  String toString() {
    return 'OptionSetItemDetailsRouteArgs{key: $key, optionSetId: $optionSetId}';
  }
}

/// generated route for
/// [_i17.OrderDetailsScreen]
class OrderDetailsRoute extends _i39.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i40.Key? key,
    required String orderId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            key: key,
            orderId: orderId,
          ),
          rawPathParams: {'orderId': orderId},
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const _i39.PageInfo<OrderDetailsRouteArgs> page =
      _i39.PageInfo<OrderDetailsRouteArgs>(name);
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.orderId,
  });

  final _i40.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i18.Orders]
class Orders extends _i39.PageRouteInfo<void> {
  const Orders({List<_i39.PageRouteInfo>? children})
      : super(
          Orders.name,
          initialChildren: children,
        );

  static const String name = 'Orders';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i19.OverviewScreen]
class OverviewRoute extends _i39.PageRouteInfo<void> {
  const OverviewRoute({List<_i39.PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i20.PharmaciesScreen]
class PharmaciesRoute extends _i39.PageRouteInfo<void> {
  const PharmaciesRoute({List<_i39.PageRouteInfo>? children})
      : super(
          PharmaciesRoute.name,
          initialChildren: children,
        );

  static const String name = 'PharmaciesRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i21.Products]
class Products extends _i39.PageRouteInfo<void> {
  const Products({List<_i39.PageRouteInfo>? children})
      : super(
          Products.name,
          initialChildren: children,
        );

  static const String name = 'Products';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i22.ResetPasswordScreen]
class ResetPasswordRoute extends _i39.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i40.Key? key,
    required String email,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            email: email,
          ),
          rawPathParams: {'email': email},
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i39.PageInfo<ResetPasswordRouteArgs> page =
      _i39.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i40.Key? key;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i23.ReviewDetailsScreen]
class ReviewDetailsRoute extends _i39.PageRouteInfo<ReviewDetailsRouteArgs> {
  ReviewDetailsRoute({
    _i40.Key? key,
    required String reviewId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          ReviewDetailsRoute.name,
          args: ReviewDetailsRouteArgs(
            key: key,
            reviewId: reviewId,
          ),
          rawPathParams: {'reviewId': reviewId},
          initialChildren: children,
        );

  static const String name = 'ReviewDetailsRoute';

  static const _i39.PageInfo<ReviewDetailsRouteArgs> page =
      _i39.PageInfo<ReviewDetailsRouteArgs>(name);
}

class ReviewDetailsRouteArgs {
  const ReviewDetailsRouteArgs({
    this.key,
    required this.reviewId,
  });

  final _i40.Key? key;

  final String reviewId;

  @override
  String toString() {
    return 'ReviewDetailsRouteArgs{key: $key, reviewId: $reviewId}';
  }
}

/// generated route for
/// [_i24.ReviewsScreen]
class ReviewsRoute extends _i39.PageRouteInfo<void> {
  const ReviewsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ReviewsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReviewsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i25.SettingsScreen]
class SettingsRoute extends _i39.PageRouteInfo<void> {
  const SettingsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i26.SignupScreen]
class SignupRoute extends _i39.PageRouteInfo<void> {
  const SignupRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i27.SubCategoriesScreen]
class SubCategoriesRoute extends _i39.PageRouteInfo<SubCategoriesRouteArgs> {
  SubCategoriesRoute({
    _i40.Key? key,
    required String categoryId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          SubCategoriesRoute.name,
          args: SubCategoriesRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'categoryId': categoryId},
          initialChildren: children,
        );

  static const String name = 'SubCategoriesRoute';

  static const _i39.PageInfo<SubCategoriesRouteArgs> page =
      _i39.PageInfo<SubCategoriesRouteArgs>(name);
}

class SubCategoriesRouteArgs {
  const SubCategoriesRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i40.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'SubCategoriesRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i28.SubSubCategoriesScreen]
class SubSubCategoriesRoute
    extends _i39.PageRouteInfo<SubSubCategoriesRouteArgs> {
  SubSubCategoriesRoute({
    _i40.Key? key,
    required String categoryId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          SubSubCategoriesRoute.name,
          args: SubSubCategoriesRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'categoryId': categoryId},
          initialChildren: children,
        );

  static const String name = 'SubSubCategoriesRoute';

  static const _i39.PageInfo<SubSubCategoriesRouteArgs> page =
      _i39.PageInfo<SubSubCategoriesRouteArgs>(name);
}

class SubSubCategoriesRouteArgs {
  const SubSubCategoriesRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i40.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'SubSubCategoriesRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i29.SupportTicketsDetailsScreen]
class SupportTicketsDetailsRoute
    extends _i39.PageRouteInfo<SupportTicketsDetailsRouteArgs> {
  SupportTicketsDetailsRoute({
    _i41.Key? key,
    required String ticketId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          SupportTicketsDetailsRoute.name,
          args: SupportTicketsDetailsRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          rawPathParams: {'ticketId': ticketId},
          initialChildren: children,
        );

  static const String name = 'SupportTicketsDetailsRoute';

  static const _i39.PageInfo<SupportTicketsDetailsRouteArgs> page =
      _i39.PageInfo<SupportTicketsDetailsRouteArgs>(name);
}

class SupportTicketsDetailsRouteArgs {
  const SupportTicketsDetailsRouteArgs({
    this.key,
    required this.ticketId,
  });

  final _i41.Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'SupportTicketsDetailsRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [_i30.SupportTicketsScreen]
class SupportTicketsRoute extends _i39.PageRouteInfo<void> {
  const SupportTicketsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SupportTicketsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupportTicketsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i31.UsersScreen]
class UsersRoute extends _i39.PageRouteInfo<void> {
  const UsersRoute({List<_i39.PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i32.VendorDetails]
class VendorDetails extends _i39.PageRouteInfo<VendorDetailsArgs> {
  VendorDetails({
    _i40.Key? key,
    required String vendorId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          VendorDetails.name,
          args: VendorDetailsArgs(
            key: key,
            vendorId: vendorId,
          ),
          rawPathParams: {'vendorId': vendorId},
          initialChildren: children,
        );

  static const String name = 'VendorDetails';

  static const _i39.PageInfo<VendorDetailsArgs> page =
      _i39.PageInfo<VendorDetailsArgs>(name);
}

class VendorDetailsArgs {
  const VendorDetailsArgs({
    this.key,
    required this.vendorId,
  });

  final _i40.Key? key;

  final String vendorId;

  @override
  String toString() {
    return 'VendorDetailsArgs{key: $key, vendorId: $vendorId}';
  }
}

/// generated route for
/// [_i33.VendorHomeLayout]
class VendorHomeLayout extends _i39.PageRouteInfo<void> {
  const VendorHomeLayout({List<_i39.PageRouteInfo>? children})
      : super(
          VendorHomeLayout.name,
          initialChildren: children,
        );

  static const String name = 'VendorHomeLayout';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i34.VendorMessagesScreen]
class VendorMessagesRoute extends _i39.PageRouteInfo<void> {
  const VendorMessagesRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VendorMessagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'VendorMessagesRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i35.VendorOrdersScreen]
class VendorOrdersRoute extends _i39.PageRouteInfo<void> {
  const VendorOrdersRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VendorOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'VendorOrdersRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i36.VendorOverviewScreen]
class VendorOverviewRoute extends _i39.PageRouteInfo<void> {
  const VendorOverviewRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VendorOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'VendorOverviewRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i37.VendorProductsScreen]
class VendorProductsRoute extends _i39.PageRouteInfo<void> {
  const VendorProductsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VendorProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'VendorProductsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i38.VendorProfileScreen]
class VendorProfileRoute extends _i39.PageRouteInfo<void> {
  const VendorProfileRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VendorProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'VendorProfileRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}
