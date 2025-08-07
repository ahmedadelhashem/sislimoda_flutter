import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/screens/edit_product_screen/edit_products_data.dart';
import 'package:sislimoda_admin_dashboard/screens/vendor/vendor_products_screen/add_product/add_product.dart';

@RoutePage()
class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, @pathParam required this.productId});
  final String productId;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen>
    with EditProductsData {
  @override
  void initState() {
    // TODO: implement initState
    getProduct(productId: widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
          ),
          body: GenericBuilder(
            genericCubit: productCubit,
            builder: (product) {
              return AddProduct(
                isAddProductsCubit: GenericCubit<bool>(),
                productModel: product,
                isUpdate: true,
              );
            },
          )),
    );
  }
}
