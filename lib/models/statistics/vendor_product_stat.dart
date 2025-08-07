class TopSellingProductsResponse {
  List<GetAnalysisModelTopSellingProducts>? topSellingProducts;
  int? totalSoldProducts;
  double? totalRevenue;
  int? totalProduct;

  TopSellingProductsResponse({
    this.topSellingProducts,
    this.totalSoldProducts,
    this.totalRevenue,
    this.totalProduct,
  });

  factory TopSellingProductsResponse.fromJson(Map<String, dynamic> json) {
    return TopSellingProductsResponse(
      topSellingProducts: (json['topSellingProducts'] as List<dynamic>?)
          ?.map((e) => GetAnalysisModelTopSellingProducts.fromJson(e))
          .toList(),
      totalSoldProducts: json['totalSoldProducts'],
      totalRevenue: (json['totalRevenue'] != null)
          ? (json['totalRevenue'] as num).toDouble()
          : null,
      totalProduct: json['totalProduct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topSellingProducts': topSellingProducts?.map((e) => e.toJson()).toList(),
      'totalSoldProducts': totalSoldProducts,
      'totalRevenue': totalRevenue,
      'totalProduct': totalProduct,
    };
  }
}

class GetAnalysisModelTopSellingProducts {
  String? productId;
  String? productName;
  ProductModel? product;
  int? totalSales;

  GetAnalysisModelTopSellingProducts({
    this.productId,
    this.productName,
    this.product,
    this.totalSales,
  });

  factory GetAnalysisModelTopSellingProducts.fromJson(Map<String, dynamic> json) {
    return GetAnalysisModelTopSellingProducts(
      productId: json['productId']?.toString(),
      productName: json['productName']?.toString(),
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      totalSales: json['totalSales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'product': product?.toJson(),
      'totalSales': totalSales,
    };
  }
}

class ProductModel {
  String? id;
  String? name;
  String? nameEn;
  String? description;
  String? descriptionEn;
  double? defaultPrice;
  double? oldPrice;
  int? orderNumber;
  String? htmlDescriptions;
  String? htmlOther;
  bool? isActive;
  String? defaultPhotoId;
  ProductModelDefaultPhoto? defaultPhoto;
  String? categoryId;
  String? vendorId;
  int? amount;
  String? brandId;
  dynamic brand; // null in JSON, so keeping dynamic for now
  String? paymentType;
  String? noteForReturn;
  String? created;
  dynamic category; // null in JSON
  List<dynamic>? productImages; // empty lists in JSON
  List<dynamic>? productOptions; // empty lists
  List<dynamic>? productDetails; // empty lists
  bool? isFavourite;
  double? productPrice;
  double? programDiscountPercentage;
  double? programDiscountValue;
  double? priceAfterProgramInfluencer;
  double? influencerPercentage;
  double? influencerValue;
  double? priceWithInfluencer;
  double? maxDiscountWithFamous;
  double? productDiscountPercentage;
  double? productDiscountValue;
  double? priceBeforeDiscount;
  double? maxProgramDiscountPercentage;
  double? finalDisplayPrice;
  dynamic offers; // null in JSON
  double? discountPercentage;
  double? evaluationRate;
  double? couponDeduction;
  String? mainCategoryId;
  String? subCategoryId;
  double? suggestedSalePriceFromVendor;
  int? totalProductStock;
  int? totalProductSold;
  int? minimumStock;

  ProductModel({
    this.id,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.defaultPrice,
    this.oldPrice,
    this.orderNumber,
    this.htmlDescriptions,
    this.htmlOther,
    this.isActive,
    this.defaultPhotoId,
    this.defaultPhoto,
    this.categoryId,
    this.vendorId,
    this.amount,
    this.brandId,
    this.brand,
    this.paymentType,
    this.noteForReturn,
    this.created,
    this.category,
    this.productImages,
    this.productOptions,
    this.productDetails,
    this.isFavourite,
    this.productPrice,
    this.programDiscountPercentage,
    this.programDiscountValue,
    this.priceAfterProgramInfluencer,
    this.influencerPercentage,
    this.influencerValue,
    this.priceWithInfluencer,
    this.maxDiscountWithFamous,
    this.productDiscountPercentage,
    this.productDiscountValue,
    this.priceBeforeDiscount,
    this.maxProgramDiscountPercentage,
    this.finalDisplayPrice,
    this.offers,
    this.discountPercentage,
    this.evaluationRate,
    this.couponDeduction,
    this.mainCategoryId,
    this.subCategoryId,
    this.suggestedSalePriceFromVendor,
    this.totalProductStock,
    this.totalProductSold,
    this.minimumStock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic val) => val == null ? 0 : (val is int ? val.toDouble() : val);

    return ProductModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      nameEn: json['nameEn']?.toString(),
      description: json['description']?.toString(),
      descriptionEn: json['descriptionEn']?.toString(),
      defaultPrice: toDouble(json['defaultPrice']),
      oldPrice: toDouble(json['oldPrice']),
      orderNumber: json['orderNUmber'],
      htmlDescriptions: json['htmlDescriptions']?.toString(),
      htmlOther: json['htmlOther']?.toString(),
      isActive: json['isActive'],
      defaultPhotoId: json['defaultPhotoId']?.toString(),
      defaultPhoto: json['defaultPhoto'] != null
          ? ProductModelDefaultPhoto.fromJson(json['defaultPhoto'])
          : null,
      categoryId: json['categoryId']?.toString(),
      vendorId: json['vendorId']?.toString(),
      amount: json['amount'],
      brandId: json['brandId']?.toString(),
      brand: json['brand'],
      paymentType: json['paymentType']?.toString(),
      noteForReturn: json['noteForReturn']?.toString(),
      created: json['created']?.toString(),
      category: json['category'],
      productImages: json['productImages'] as List<dynamic>?,
      productOptions: json['productOptions'] as List<dynamic>?,
      productDetails: json['productDetails'] as List<dynamic>?,
      isFavourite: json['isFavourite'],
      productPrice: toDouble(json['productPrice']),
      programDiscountPercentage: toDouble(json['programDiscountPercentage']),
      programDiscountValue: toDouble(json['programDiscountValue']),
      priceAfterProgramInfluencer: toDouble(json['priceAfterProgramInfluencer']),
      influencerPercentage: toDouble(json['influencerPercentage']),
      influencerValue: toDouble(json['influencerValue']),
      priceWithInfluencer: toDouble(json['priceWithInfluencer']),
      maxDiscountWithFamous: toDouble(json['maxDiscountWithFamous']),
      productDiscountPercentage: toDouble(json['productDiscountPercentage']),
      productDiscountValue: toDouble(json['productDiscountValue']),
      priceBeforeDiscount: toDouble(json['priceBeforeDiscount']),
      maxProgramDiscountPercentage: toDouble(json['maxProgramDiscountPercentage']),
      finalDisplayPrice: toDouble(json['finalDisplayPrice']),
      offers: json['offers'],
      discountPercentage: toDouble(json['discountPercentage']),
      evaluationRate: toDouble(json['evaluationRate']),
      couponDeduction: toDouble(json['couponDeduction']),
      mainCategoryId: json['mainCategoryId']?.toString(),
      subCategoryId: json['subCategoryId']?.toString(),
      suggestedSalePriceFromVendor: toDouble(json['suggestedSalePriceFromVendor']),
      totalProductStock: json['totalProductStock'],
      totalProductSold: json['totalProductSold'],
      minimumStock: json['minimumStock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'description': description,
      'descriptionEn': descriptionEn,
      'defaultPrice': defaultPrice,
      'oldPrice': oldPrice,
      'orderNUmber': orderNumber,
      'htmlDescriptions': htmlDescriptions,
      'htmlOther': htmlOther,
      'isActive': isActive,
      'defaultPhotoId': defaultPhotoId,
      'defaultPhoto': defaultPhoto?.toJson(),
      'categoryId': categoryId,
      'vendorId': vendorId,
      'amount': amount,
      'brandId': brandId,
      'brand': brand,
      'paymentType': paymentType,
      'noteForReturn': noteForReturn,
      'created': created,
      'category': category,
      'productImages': productImages,
      'productOptions': productOptions,
      'productDetails': productDetails,
      'isFavourite': isFavourite,
      'productPrice': productPrice,
      'programDiscountPercentage': programDiscountPercentage,
      'programDiscountValue': programDiscountValue,
      'priceAfterProgramInfluencer': priceAfterProgramInfluencer,
      'influencerPercentage': influencerPercentage,
      'influencerValue': influencerValue,
      'priceWithInfluencer': priceWithInfluencer,
      'maxDiscountWithFamous': maxDiscountWithFamous,
      'productDiscountPercentage': productDiscountPercentage,
      'productDiscountValue': productDiscountValue,
      'priceBeforeDiscount': priceBeforeDiscount,
      'maxProgramDiscountPercentage': maxProgramDiscountPercentage,
      'finalDisplayPrice': finalDisplayPrice,
      'offers': offers,
      'discountPercentage': discountPercentage,
      'evaluationRate': evaluationRate,
      'couponDeduction': couponDeduction,
      'mainCategoryId': mainCategoryId,
      'subCategoryId': subCategoryId,
      'suggestedSalePriceFromVendor': suggestedSalePriceFromVendor,
      'totalProductStock': totalProductStock,
      'totalProductSold': totalProductSold,
      'minimumStock': minimumStock,
    };
  }
}

class ProductModelDefaultPhoto {
  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  ProductModelDefaultPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });

  factory ProductModelDefaultPhoto.fromJson(Map<String, dynamic> json) {
    return ProductModelDefaultPhoto(
      id: json['id']?.toString(),
      imageId: json['imageId']?.toString(),
      name: json['name']?.toString(),
      fullLink: json['fullLink']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageId': imageId,
      'name': name,
      'fullLink': fullLink,
    };
  }
}

class VendorModel {
  final String id;
  final String name;

  VendorModel({
    required this.id,
    required this.name,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
