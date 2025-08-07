import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  Loading loading = Loading();
  getCategories() async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Category/GetAllMainCategory',
          body: null);

      result.fold((success) {
        emit(CategoriesLoaded(categories: categoryModelFromJson(success)));
      }, (failure) {
        showErrorMessage(message: failure.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
