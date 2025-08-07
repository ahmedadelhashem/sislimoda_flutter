import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'loading_state.dart';

class Loading extends Cubit<LoadingState> {
  Loading() : super(LoadingInitial());

  // onChangeLoading() {
  //   emit(LoadingChange(!state.change, !state.loading));
  // }

  get hide {
   
    emit(LoadingChange(!state.change!, false));
  }

  get show {
      // FocusScope.of(Get.context!).unfocus();
    emit(LoadingChange(!state.change!, true));
  }
}
