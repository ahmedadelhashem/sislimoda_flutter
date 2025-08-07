part of 'selectitems_cubit.dart';

abstract class SelectitemsState extends Equatable {
  final List<Item>? items;
  final Item? selectedItems;
  final bool? change;
  final String? searchWord;
  final List<Item>? searchItemsList;
  final String? errorText;
  const SelectitemsState(
      {this.items,
      this.selectedItems,
      this.change,
      this.searchWord,
      this.searchItemsList,
      this.errorText});
}

class SelectitemsLoad extends SelectitemsState {
  SelectitemsLoad(
      bool change, List<Item> items, Item? selecteditem, String? errorText)
      : super(
            items: items,
            searchItemsList: items,
            selectedItems: selecteditem,
            change: change,
            errorText: errorText);
  @override
  List<Object?> get props =>
      [items, selectedItems, change, searchWord, searchItemsList, errorText];
}

class SelectitemsError extends SelectitemsState {
  SelectitemsError(
      bool change, List<Item>? items, Item? selecteditem, String? errorText)
      : super(
            items: items,
            searchItemsList: items,
            selectedItems: selecteditem,
            change: change,
            errorText: errorText);
  @override
  List<Object?> get props =>
      [items, selectedItems, change, searchWord, searchItemsList, errorText];
}
class SelectitemsInitError extends SelectitemsState {
  SelectitemsInitError(
      bool change, List<Item> items, Item selecteditem, String errorText)
      : super(
            items: items,
            searchItemsList: items,
            selectedItems: selecteditem,
            change: change,
            errorText: errorText);
  @override
  List<Object?> get props =>
      [items, selectedItems, change, searchWord, searchItemsList, errorText];
}

class SelectitemsInitial extends SelectitemsState {
  SelectitemsInitial(String? errorText)
      : super(
            items: [],
            selectedItems: null,
            change: false,
            searchItemsList: [],
            searchWord: null,
            errorText: errorText);
  @override
  List<Object?> get props =>
      [items, selectedItems, change, searchWord, searchItemsList, errorText];
}

class SelectitemsSearch extends SelectitemsState {
  SelectitemsSearch(bool change, List<Item>? items, Item? selectedItems,
      List<Item>? searchItemsList, String? searchWord,String? errorText)
      : super(
            items: items,
            selectedItems: selectedItems,
            change: change,
            searchItemsList: searchItemsList,
            searchWord: searchWord,errorText: errorText);
  @override
  List<Object?> get props =>
      [items, selectedItems, change, searchWord, searchItemsList, errorText];
}
