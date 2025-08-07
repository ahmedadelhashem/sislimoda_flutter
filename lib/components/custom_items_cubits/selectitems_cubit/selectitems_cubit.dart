import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';
part 'selectitems_state.dart';

class SelectitemsCubit extends Cubit<SelectitemsState> {
  final String? errorText;

  SelectitemsCubit({this.errorText}) : super(SelectitemsInitial(errorText));

  initErrorMessage(String errortxt) {
    emit(SelectitemsSearch(!state.change!, state.items, state.selectedItems,
        state.searchItemsList, state.searchWord, errortxt));
  }

  loadData(List<Item> itemList, [Item? item]) {
    emit(SelectitemsLoad(
        !state.change!, itemList, state.selectedItems, state.errorText));
  }

  ///Select Items From List
  ///[item] selected Items from list
  selectItems(Item item) {
    //! Emit New state by selected item
    emit(SelectitemsSearch(!state.change!, state.items, item,
        state.searchItemsList, state.searchWord, state.errorText));
  }

  ///Error Text
  error() {
    //! Emit New state by selected item
    emit(SelectitemsError(
        !state.change!, state.items, state.selectedItems, state.errorText));
  }

  ///Serach in Items List
  ///[searchWord] word need to search by
  searchInItemsList(String searchWord) {
    //! Search in list by search Word
    List<Item> listItems = state.items!
        .where((element) =>
            element.value!.toLowerCase().contains(searchWord.toLowerCase()))
        .toList();
    //! Emit New Search List
    emit(SelectitemsSearch(!state.change!, state.items, state.selectedItems,
        listItems, searchWord, state.errorText));
  }

  reset() {
    emit(SelectitemsLoad(!state.change!, [], null, state.errorText));
  }
}
