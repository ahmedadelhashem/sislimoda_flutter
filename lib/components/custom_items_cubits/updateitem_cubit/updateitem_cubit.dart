import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sislimoda_admin_dashboard/models/general/item.dart';

part 'updateitem_state.dart';

class UpdateitemCubit extends Cubit<UpdateitemState> {
  final String? erroText;

  UpdateitemCubit({
    this.erroText,
  }) : super(UpdateitemInitial(erroText));

  initErrorMessage(String errortxt) {
    emit(UpdateitemUpdate(!state.change!, state.item, errortxt));
  }

  updateItem(Item item) {
    emit(UpdateitemUpdate(!state.change!, item, state.errorText));
  }

  error() {
    emit(UpdateitemError(!state.change!, state.item, state.errorText));
  }

  rest() {
    emit(UpdateItemRest(!state.change!, state.errorText));
  }
}
