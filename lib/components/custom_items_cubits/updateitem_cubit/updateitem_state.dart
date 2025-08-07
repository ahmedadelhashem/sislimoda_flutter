part of 'updateitem_cubit.dart';

abstract class UpdateitemState extends Equatable {
  final bool? change;
  final Item? item;
  final String? errorText;

  const UpdateitemState({this.change, this.item, this.errorText});
}

class UpdateitemInitial extends UpdateitemState {
  UpdateitemInitial(String? errorText)
      : super(change: false, item: null, errorText: errorText);
  List<Object?> get props => [change, item, errorText];
}

class UpdateitemUpdate extends UpdateitemState {
  UpdateitemUpdate(bool change, Item? item,String? errorTxt) : super(change: change, item: item,errorText: errorTxt);
  List<Object?> get props => [change, item, errorText];
}

class UpdateitemError extends UpdateitemState {
  UpdateitemError(bool change, Item? item, String? errorText)
      : super(change: change, item: item, errorText: errorText);
  List<Object?> get props => [change, item, errorText];
}
class UpdateItemRest extends UpdateitemState {
  UpdateItemRest(bool change, String? errorText)
      : super(change: change, item:null, errorText: errorText);
  List<Object?> get props => [change, null, errorText];
}
