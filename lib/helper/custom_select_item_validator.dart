

import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/selectitems_cubit/selectitems_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/updateitem_cubit/updateitem_cubit.dart';

class SelectItemValidator {
  static bool validationFunction(
      {List<SelectitemsCubit> selectitemsCubitList = const [],
      List<UpdateitemCubit> updateitemCubitList = const []}) {
    int count = 0;

    for (var item in selectitemsCubitList) {
      if (item.state.selectedItems == null) {
        item.error();
        count = count + 1;
      }
    }

    for (var item in updateitemCubitList) {
      if (item.state.item == null) {
        item.error();
        count = count + 1;
      }
    }
    return count > 0 ? false : true;
  }
}
