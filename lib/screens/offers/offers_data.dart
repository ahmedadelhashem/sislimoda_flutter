import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/offers/get_offers_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/categories/widgets/add_category.dart';
import 'package:sislimoda_admin_dashboard/screens/offers/widgets/add_offer.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin OffersData {
  Loading loading = Loading();
  int totalPages = 1;
  int page = 1;
  GenericCubit<List<OfferModel>> offersCubit = GenericCubit<List<OfferModel>>();
  List<OfferModel> offers = [];

  List<ProductModel> products = [];
  getAllOffers() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.get, apiName: 'api/Offers/GetAll', body: null);
      result.fold((success) {
        offers = offerModelFromJson(success);
        offersCubit.update(data: offers);
      }, (faliure) {
        showErrorMessage(message: faliure.message);
      });
    } catch (error) {}
    await getProducts();
    loading.hide;
  }

  getProducts() async {
    loading.show;

    try {
      var result = await AppService.callService(
          actionType: ActionType.get,
          apiName: 'api/Product/GetAll',
          body: null);
      result.fold((l) {
        products = productModelFromJson(l);
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }

  addOffer() {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return AddOffer(
            operationType: OperationType.add,
            products: products,
            reload: getAllOffers,
          );
        });
  }

  updateOffer({required OfferModel offer}) {
    showDialog(
        context: currentContext,
        builder: (ctx) {
          return AddOffer(
            operationType: OperationType.update,
            products: products,
            reload: getAllOffers,
            offer: offer,
          );
        });
  }

  search(String text) async {
    if (text.isEmpty) {
      getAllOffers();
      return;
    }
    loading.show;
    // try {
    var result = await AppService.callService(
        actionType: ActionType.get,
        apiName: 'offer/search?keyword=$text',
        body: null);
    result.fold((success) {
      // GetOffersPaginationModel offerdata =
      //     GetOffersPaginationModel.fromJson(jsonDecode(success));
      // offerdata.Offer = getOffersPaginationModelOfferFromJson(
      //     jsonEncode(json.decode(success)['offers']));
      totalPages = 1;
      offersCubit.update(data: offers);
    }, (faliure) {
      showErrorMessage(message: faliure.message);
    });
    // } catch (error) {}
    loading.hide;
  }

  // deleteOffer({required GetOffersPaginationModelOffer offer}){
  //   loading.show;
  //   try{
  //     AppService.callService(actionType: ActionType.delete, apiName: apiName, body: body)
  //   }catch(error){}
  //   loading.hide;
  // }
}
