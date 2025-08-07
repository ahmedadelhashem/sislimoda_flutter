
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/loader_custom/loader_item.dart';

class Loader extends StatelessWidget {
  final Loading loading;
  final Widget? loader;
    const Loader({Key? key, required this.loading, this.loader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Loading, LoadingState>(
      bloc: loading,
      builder: (context, state) {
        if (state is LoadingChange) {
          return state.loading!
              ? WillPopScope(
                onWillPop: ()async{
                    loading.hide;
                  return true;
                },
                  // canPop: true,
                  // onPopInvoked:  (value) async {
                  //   loading.hide;
                  // },
                  child: loader == null ?const LoaderItem() : loader!,

                )
              : Container();
        } else {
          return Container();
        }
      },
    );
  }
}
