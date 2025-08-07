import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  Loading loading = Loading();

  getProducts() async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAll',
          body: null);
      result.fold((l) {
        emit(ProductsLoaded(products: productModelFromJson(l)));
      }, (r) {
        emit(ProductsFailed());

        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
