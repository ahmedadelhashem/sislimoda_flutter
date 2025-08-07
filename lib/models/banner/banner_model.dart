import 'dart:convert';

List<BannersModel> bannersModelFromJson(String str) => List<BannersModel>.from(
    json.decode(str).map((x) => BannersModel.fromJson(x)));

class BannersModelImage {
/*
{
  "id": "119b6c41-8080-4c81-89cb-2979f0df220e",
  "imageId": "2127da8a-ea34-44ea-8456-4c0ed888684f",
  "name": "2127da8a-ea34-44ea-8456-4c0ed888684f.png",
  "fullLink": "https://sislimoda.com/Files/2127da8a-ea34-44ea-8456-4c0ed888684f.png"
}
*/

  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  BannersModelImage({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  BannersModelImage.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    imageId = json['imageId']?.toString();
    name = json['name']?.toString();
    fullLink = json['fullLink']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['imageId'] = imageId;
    data['name'] = name;
    data['fullLink'] = fullLink;
    return data;
  }
}

class BannersModelProductDefaultPhoto {
/*
{
  "id": "ea3942e9-e36a-46d9-ab14-8e5d2d49bb2d",
  "imageId": "82ab84db-7736-458e-85cb-8f470a3fc8aa",
  "name": "82ab84db-7736-458e-85cb-8f470a3fc8aa.jpg",
  "fullLink": "https://sislimoda.com/Files/82ab84db-7736-458e-85cb-8f470a3fc8aa.jpg"
}
*/

  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  BannersModelProductDefaultPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  BannersModelProductDefaultPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    imageId = json['imageId']?.toString();
    name = json['name']?.toString();
    fullLink = json['fullLink']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['imageId'] = imageId;
    data['name'] = name;
    data['fullLink'] = fullLink;
    return data;
  }
}

class BannersModelProduct {
/*
{
  "id": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
  "name": "بنطال",
  "nameEn": "Pant",
  "description": "بنطلون حريمي واسع الارجل",
  "descriptionEn": "Women's wide leg trousers",
  "defaultPrice": 30,
  "oldPrice": 0,
  "orderNUmber": 0,
  "htmlDescriptions": "string",
  "htmlOther": "string",
  "isActive": true,
  "defaultPhotoId": "ea3942e9-e36a-46d9-ab14-8e5d2d49bb2d",
  "defaultPhoto": {
    "id": "ea3942e9-e36a-46d9-ab14-8e5d2d49bb2d",
    "imageId": "82ab84db-7736-458e-85cb-8f470a3fc8aa",
    "name": "82ab84db-7736-458e-85cb-8f470a3fc8aa.jpg",
    "fullLink": "https://sislimoda.com/Files/82ab84db-7736-458e-85cb-8f470a3fc8aa.jpg"
  },
  "categoryId": "88b44ae7-86af-4c2a-8788-08dc1e165a43",
  "vendorId": "0fd4806d-e6e6-48df-7b91-08dc1ed95a1b",
  "amount": 39,
  "brandId": "ff6982b0-f2e8-47c6-0ed6-08dc1e1a7720",
  "brand": null,
  "paymentType": "string",
  "noteForReturn": "Return in 14 days",
  "created": "27-01-2024 13:10:57",
  "category": null,
  "productImages": [
    null
  ],
  "productOptions": [
    null
  ],
  "productDetails": [
    null
  ],
  "isFavourite": false,
  "productPrice": 33,
  "programDiscountPercentage": 10,
  "programDiscountValue": 3.3,
  "priceAfterProgramInfluencer": 34.65,
  "influencerPercentage": 5,
  "influencerValue": 1.73,
  "priceWithInfluencer": 36.38,
  "maxDiscountWithFamous": 0,
  "productDiscountPercentage": 0,
  "productDiscountValue": 0,
  "priceBeforeDiscount": 0,
  "maxProgramDiscountPercentage": 0,
  "finalDisplayPrice": 36.38,
  "offers": null,
  "discountPercentage": 0
}
*/

  String? id;
  String? name;
  String? nameEn;
  String? description;
  String? descriptionEn;
  String? defaultPrice;
  String? oldPrice;
  String? orderNUmber;
  String? htmlDescriptions;
  String? htmlOther;
  bool? isActive;
  String? defaultPhotoId;
  BannersModelProductDefaultPhoto? defaultPhoto;
  String? categoryId;
  String? vendorId;
  String? amount;
  String? brandId;
  String? brand;
  String? paymentType;
  String? noteForReturn;
  String? created;
  String? category;
  List<String?>? productImages;
  List<String?>? productOptions;
  List<String?>? productDetails;
  bool? isFavourite;
  String? productPrice;
  String? programDiscountPercentage;
  String? programDiscountValue;
  String? priceAfterProgramInfluencer;
  String? influencerPercentage;
  String? influencerValue;
  String? priceWithInfluencer;
  String? maxDiscountWithFamous;
  String? productDiscountPercentage;
  String? productDiscountValue;
  String? priceBeforeDiscount;
  String? maxProgramDiscountPercentage;
  String? finalDisplayPrice;
  String? offers;
  String? discountPercentage;

  BannersModelProduct({
    this.id,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.defaultPrice,
    this.oldPrice,
    this.orderNUmber,
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
  });
  BannersModelProduct.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    nameEn = json['nameEn']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    defaultPrice = json['defaultPrice']?.toString();
    oldPrice = json['oldPrice']?.toString();
    orderNUmber = json['orderNUmber']?.toString();
    htmlDescriptions = json['htmlDescriptions']?.toString();
    htmlOther = json['htmlOther']?.toString();
    isActive = json['isActive'];
    defaultPhotoId = json['defaultPhotoId']?.toString();
    defaultPhoto = (json['defaultPhoto'] != null)
        ? BannersModelProductDefaultPhoto.fromJson(json['defaultPhoto'])
        : null;
    categoryId = json['categoryId']?.toString();
    vendorId = json['vendorId']?.toString();
    amount = json['amount']?.toString();
    brandId = json['brandId']?.toString();
    brand = json['brand']?.toString();
    paymentType = json['paymentType']?.toString();
    noteForReturn = json['noteForReturn']?.toString();
    created = json['created']?.toString();
    category = json['category']?.toString();

    isFavourite = json['isFavourite'];
    productPrice = json['productPrice']?.toString();
    programDiscountPercentage = json['programDiscountPercentage']?.toString();
    programDiscountValue = json['programDiscountValue']?.toString();
    priceAfterProgramInfluencer =
        json['priceAfterProgramInfluencer']?.toString();
    influencerPercentage = json['influencerPercentage']?.toString();
    influencerValue = json['influencerValue']?.toString();
    priceWithInfluencer = json['priceWithInfluencer']?.toString();
    maxDiscountWithFamous = json['maxDiscountWithFamous']?.toString();
    productDiscountPercentage = json['productDiscountPercentage']?.toString();
    productDiscountValue = json['productDiscountValue']?.toString();
    priceBeforeDiscount = json['priceBeforeDiscount']?.toString();
    maxProgramDiscountPercentage =
        json['maxProgramDiscountPercentage']?.toString();
    finalDisplayPrice = json['finalDisplayPrice']?.toString();
    offers = json['offers']?.toString();
    discountPercentage = json['discountPercentage']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameEn'] = nameEn;
    data['description'] = description;
    data['descriptionEn'] = descriptionEn;
    data['defaultPrice'] = defaultPrice;
    data['oldPrice'] = oldPrice;
    data['orderNUmber'] = orderNUmber;
    data['htmlDescriptions'] = htmlDescriptions;
    data['htmlOther'] = htmlOther;
    data['isActive'] = isActive;
    data['defaultPhotoId'] = defaultPhotoId;
    if (defaultPhoto != null) {
      data['defaultPhoto'] = defaultPhoto!.toJson();
    }
    data['categoryId'] = categoryId;
    data['vendorId'] = vendorId;
    data['amount'] = amount;
    data['brandId'] = brandId;
    data['brand'] = brand;
    data['paymentType'] = paymentType;
    data['noteForReturn'] = noteForReturn;
    data['created'] = created;
    data['category'] = category;

    data['isFavourite'] = isFavourite;
    data['productPrice'] = productPrice;
    data['programDiscountPercentage'] = programDiscountPercentage;
    data['programDiscountValue'] = programDiscountValue;
    data['priceAfterProgramInfluencer'] = priceAfterProgramInfluencer;
    data['influencerPercentage'] = influencerPercentage;
    data['influencerValue'] = influencerValue;
    data['priceWithInfluencer'] = priceWithInfluencer;
    data['maxDiscountWithFamous'] = maxDiscountWithFamous;
    data['productDiscountPercentage'] = productDiscountPercentage;
    data['productDiscountValue'] = productDiscountValue;
    data['priceBeforeDiscount'] = priceBeforeDiscount;
    data['maxProgramDiscountPercentage'] = maxProgramDiscountPercentage;
    data['finalDisplayPrice'] = finalDisplayPrice;
    data['offers'] = offers;
    data['discountPercentage'] = discountPercentage;
    return data;
  }
}

class BannersModel {
/*
{
  "id": "096675f6-e0e0-4b79-1de8-08dd45bd56a3",
  "isDeleted": false,
  "type": "home",
  "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
  "product": {
    "id": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
    "name": "بنطال",
    "nameEn": "Pant",
    "description": "بنطلون حريمي واسع الارجل",
    "descriptionEn": "Women's wide leg trousers",
    "defaultPrice": 30,
    "oldPrice": 0,
    "orderNUmber": 0,
    "htmlDescriptions": "string",
    "htmlOther": "string",
    "isActive": true,
    "defaultPhotoId": "ea3942e9-e36a-46d9-ab14-8e5d2d49bb2d",
    "defaultPhoto": {
      "id": "ea3942e9-e36a-46d9-ab14-8e5d2d49bb2d",
      "imageId": "82ab84db-7736-458e-85cb-8f470a3fc8aa",
      "name": "82ab84db-7736-458e-85cb-8f470a3fc8aa.jpg",
      "fullLink": "https://sislimoda.com/Files/82ab84db-7736-458e-85cb-8f470a3fc8aa.jpg"
    },
    "categoryId": "88b44ae7-86af-4c2a-8788-08dc1e165a43",
    "vendorId": "0fd4806d-e6e6-48df-7b91-08dc1ed95a1b",
    "amount": 39,
    "brandId": "ff6982b0-f2e8-47c6-0ed6-08dc1e1a7720",
    "brand": null,
    "paymentType": "string",
    "noteForReturn": "Return in 14 days",
    "created": "27-01-2024 13:10:57",
    "category": null,
    "productImages": [
      null
    ],
    "productOptions": [
      null
    ],
    "productDetails": [
      null
    ],
    "isFavourite": false,
    "productPrice": 33,
    "programDiscountPercentage": 10,
    "programDiscountValue": 3.3,
    "priceAfterProgramInfluencer": 34.65,
    "influencerPercentage": 5,
    "influencerValue": 1.73,
    "priceWithInfluencer": 36.38,
    "maxDiscountWithFamous": 0,
    "productDiscountPercentage": 0,
    "productDiscountValue": 0,
    "priceBeforeDiscount": 0,
    "maxProgramDiscountPercentage": 0,
    "finalDisplayPrice": 36.38,
    "offers": null,
    "discountPercentage": 0
  },
  "imageId": "119b6c41-8080-4c81-89cb-2979f0df220e",
  "image": {
    "id": "119b6c41-8080-4c81-89cb-2979f0df220e",
    "imageId": "2127da8a-ea34-44ea-8456-4c0ed888684f",
    "name": "2127da8a-ea34-44ea-8456-4c0ed888684f.png",
    "fullLink": "https://sislimoda.com/Files/2127da8a-ea34-44ea-8456-4c0ed888684f.png"
  }
}
*/

  String? id;
  bool? isDeleted;
  String? type;
  String? productId;
  BannersModelProduct? product;
  String? imageId;
  BannersModelImage? image;

  BannersModel({
    this.id,
    this.isDeleted,
    this.type,
    this.productId,
    this.product,
    this.imageId,
    this.image,
  });
  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    isDeleted = json['isDeleted'];
    type = json['type']?.toString();
    productId = json['productId']?.toString();
    product = (json['product'] != null)
        ? BannersModelProduct.fromJson(json['product'])
        : null;
    imageId = json['imageId']?.toString();
    image = (json['image'] != null)
        ? BannersModelImage.fromJson(json['image'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['type'] = type;
    data['productId'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['imageId'] = imageId;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}
