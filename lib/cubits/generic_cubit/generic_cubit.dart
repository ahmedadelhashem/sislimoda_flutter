import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'generic_state.dart';

class GenericCubit<T> extends Cubit<GenericState<T>> {
  GenericCubit({T? data}) : super(GenericInitial<T>(data));
  update({required T data}) {
    emit(GenericUpdate<T>(change: !state.change, data: data));
  }

  
}
