import 'dart:convert';

import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';

List<CouponModel> couponModelFromJson(String str) => List<CouponModel>.from(
    json.decode(str).map((x) => CouponModel.fromJson(x)));

class CouponModelCouponProducts {
  String? id;
  String? productId;
  ProductModel? product;
  int? totalSales;
  CouponModelCouponProducts({
    this.id,
    this.productId,
    this.product,
    this.totalSales
  });
  CouponModelCouponProducts.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    productId = json['productId']?.toString();
    product = (json['product'] != null)
        ? ProductModel.fromJson(json['product'])
        : null;
    totalSales = json['totalSales'];
    
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['totalSales']=totalSales;
    return data;
  }
}

class CouponModelInfluencer {
/*
{
  "id": "78556318-ee9a-4cb6-ff88-08dd3a3f9afd",
  "name": "ahmed almaz",
  "isActive": true,
  "photoId": "3b37b60c-f234-43d5-8c0d-c12f961a23c3",
  "photo": null,
  "userId": "dba085c5-9f20-41cd-8c90-8e60d881bb14",
  "user": null,
  "influencerStatusId": "097aa6d0-32ea-4684-181d-08dc50589aad",
  "influencerStatus": null,
  "numberOfProduct": 0,
  "idNumber": null,
  "bankAccountNumber": null,
  "whatsappNumber1": null,
  "whatsappNumber2": null,
  "telegramNumber1": null,
  "telegramNumber2": null,
  "facebookLink": null,
  "twitterLink": null,
  "instagramLink": null,
  "linkedInLink": null,
  "youTubeLink": null,
  "snapchatLink": null,
  "tikTokLink": null
}
*/

  String? id;
  String? name;
  bool? isActive;
  String? photoId;
  String? photo;
  String? userId;
  String? user;
  String? influencerStatusId;
  String? influencerStatus;
  String? numberOfProduct;
  String? idNumber;
  String? bankAccountNumber;
  String? whatsappNumber1;
  String? whatsappNumber2;
  String? telegramNumber1;
  String? telegramNumber2;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? linkedInLink;
  String? youTubeLink;
  String? snapchatLink;
  String? tikTokLink;

  CouponModelInfluencer({
    this.id,
    this.name,
    this.isActive,
    this.photoId,
    this.photo,
    this.userId,
    this.user,
    this.influencerStatusId,
    this.influencerStatus,
    this.numberOfProduct,
    this.idNumber,
    this.bankAccountNumber,
    this.whatsappNumber1,
    this.whatsappNumber2,
    this.telegramNumber1,
    this.telegramNumber2,
    this.facebookLink,
    this.twitterLink,
    this.instagramLink,
    this.linkedInLink,
    this.youTubeLink,
    this.snapchatLink,
    this.tikTokLink,
  });
  CouponModelInfluencer.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    isActive = json['isActive'];
    photoId = json['photoId']?.toString();
    photo = json['photo']?.toString();
    userId = json['userId']?.toString();
    user = json['user']?.toString();
    influencerStatusId = json['influencerStatusId']?.toString();
    influencerStatus = json['influencerStatus']?.toString();
    numberOfProduct = json['numberOfProduct']?.toString();
    idNumber = json['idNumber']?.toString();
    bankAccountNumber = json['bankAccountNumber']?.toString();
    whatsappNumber1 = json['whatsappNumber1']?.toString();
    whatsappNumber2 = json['whatsappNumber2']?.toString();
    telegramNumber1 = json['telegramNumber1']?.toString();
    telegramNumber2 = json['telegramNumber2']?.toString();
    facebookLink = json['facebookLink']?.toString();
    twitterLink = json['twitterLink']?.toString();
    instagramLink = json['instagramLink']?.toString();
    linkedInLink = json['linkedInLink']?.toString();
    youTubeLink = json['youTubeLink']?.toString();
    snapchatLink = json['snapchatLink']?.toString();
    tikTokLink = json['tikTokLink']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isActive'] = isActive;
    data['photoId'] = photoId;
    data['photo'] = photo;
    data['userId'] = userId;
    data['user'] = user;
    data['influencerStatusId'] = influencerStatusId;
    data['influencerStatus'] = influencerStatus;
    data['numberOfProduct'] = numberOfProduct;
    data['idNumber'] = idNumber;
    data['bankAccountNumber'] = bankAccountNumber;
    data['whatsappNumber1'] = whatsappNumber1;
    data['whatsappNumber2'] = whatsappNumber2;
    data['telegramNumber1'] = telegramNumber1;
    data['telegramNumber2'] = telegramNumber2;
    data['facebookLink'] = facebookLink;
    data['twitterLink'] = twitterLink;
    data['instagramLink'] = instagramLink;
    data['linkedInLink'] = linkedInLink;
    data['youTubeLink'] = youTubeLink;
    data['snapchatLink'] = snapchatLink;
    data['tikTokLink'] = tikTokLink;
    return data;
  }
}

class CouponModel {
/*
{
  "id": "df12faf5-7309-4b7e-fdbb-08dd63550e15",
  "code": "almaz100",
  "description": "",
  "descriptionEn": "",
  "couponType": 2,
  "amount": 15,
  "percent": 15,
  "mustExceed": 0,
  "startDate": "15-03-2025 00:00:00",
  "endDate": "19-03-2025 00:00:00",
  "isForAll": true,
  "isActive": true,
  "couponUsers": [
    null
  ],
  "influencerId": "78556318-ee9a-4cb6-ff88-08dd3a3f9afd",
  "influencer": {
    "id": "78556318-ee9a-4cb6-ff88-08dd3a3f9afd",
    "name": "ahmed almaz",
    "isActive": true,
    "photoId": "3b37b60c-f234-43d5-8c0d-c12f961a23c3",
    "photo": null,
    "userId": "dba085c5-9f20-41cd-8c90-8e60d881bb14",
    "user": null,
    "influencerStatusId": "097aa6d0-32ea-4684-181d-08dc50589aad",
    "influencerStatus": null,
    "numberOfProduct": 0,
    "idNumber": null,
    "bankAccountNumber": null,
    "whatsappNumber1": null,
    "whatsappNumber2": null,
    "telegramNumber1": null,
    "telegramNumber2": null,
    "facebookLink": null,
    "twitterLink": null,
    "instagramLink": null,
    "linkedInLink": null,
    "youTubeLink": null,
    "snapchatLink": null,
    "tikTokLink": null
  },
  "couponStatus": 1,
  "influencerPercentage": 50,
  "couponProducts": [
    {
      "id": "95b264c2-5242-4d30-2de7-08dd63550e19",
      "productId": "0876b916-4854-47f2-a82e-08dc3f32c82f",
      "product": {
        "id": "0876b916-4854-47f2-a82e-08dc3f32c82f",
        "name": "Aتيشيرت بشعار الماركة جرافيك",
        "nameEn": "Graphic Monogram T-ShirtA",
        "description": "لمسة كلاسيكية تضفي على هذا التيشيرت بمظهر رائع لجعل إطلالاتكم الكاجوال تلفت الأنظار.",
        "descriptionEn": "A classic touch infuses this t-shirt designed with a cool attitude to make your casual edits stand out.",
        "defaultPrice": 40,
        "oldPrice": 0,
        "orderNUmber": 0,
        "htmlDescriptions": "string",
        "htmlOther": "string",
        "isActive": true,
        "defaultPhotoId": "9f9e1022-3bee-43d8-aa0a-6b2d9f1c4eba",
        "defaultPhoto": {
          "id": "9f9e1022-3bee-43d8-aa0a-6b2d9f1c4eba",
          "imageId": "25d101e3-76f5-48de-84c1-a7a2a136d424",
          "name": "25d101e3-76f5-48de-84c1-a7a2a136d424.jpg",
          "fullLink": "https://sislimoda.com/Files/25d101e3-76f5-48de-84c1-a7a2a136d424.jpg"
        },
        "categoryId": "a0c8e64d-34b1-460c-efea-08dd12b974c8",
        "vendorId": "5e4d55fa-bdf5-45ff-4b3d-08dc3dbeaac9",
        "amount": 50,
        "brandId": "7d18ef71-b924-489d-0ed9-08dc1e1a7720",
        "brand": null,
        "paymentType": "string",
        "noteForReturn": "  ",
        "created": "08-03-2024 15:44:11",
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
        "productPrice": 44,
        "programDiscountPercentage": 10,
        "programDiscountValue": 4.4,
        "priceAfterProgramInfluencer": 46.2,
        "influencerPercentage": 5,
        "influencerValue": 2.31,
        "priceWithInfluencer": 48.51,
        "maxDiscountWithFamous": 0,
        "productDiscountPercentage": 0,
        "productDiscountValue": 0,
        "priceBeforeDiscount": 0,
        "maxProgramDiscountPercentage": 0,
        "finalDisplayPrice": 48.51,
        "offers": null,
        "discountPercentage": 0,
        "evaluationRate": 0
      }
    }
  ]
}
*/

  String? id;
  String? code;
  String? description;
  String? descriptionEn;
  String? couponType;
  String? amount;
  String? percent;
  String? mustExceed;
  String? startDate;
  String? endDate;
  bool? isForAll;
  bool? isActive;
  List<String?>? couponUsers;
  String? influencerId;
  CouponModelInfluencer? influencer;
  String? couponStatus;
  String? influencerPercentage;
  List<CouponModelCouponProducts?>? couponProducts;

  CouponModel({
    this.id,
    this.code,
    this.description,
    this.descriptionEn,
    this.couponType,
    this.amount,
    this.percent,
    this.mustExceed,
    this.startDate,
    this.endDate,
    this.isForAll,
    this.isActive,
    this.couponUsers,
    this.influencerId,
    this.influencer,
    this.couponStatus,
    this.influencerPercentage,
    this.couponProducts,
  });
  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    code = json['code']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    couponType = json['couponType']?.toString();
    amount = json['amount']?.toString();
    percent = json['percent']?.toString();
    mustExceed = json['mustExceed']?.toString();
    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    isForAll = json['isForAll'];
    isActive = json['isActive'];
    influencerId = json['influencerId']?.toString();
    influencer = (json['influencer'] != null)
        ? CouponModelInfluencer.fromJson(json['influencer'])
        : null;
    couponStatus = json['couponStatus']?.toString();
    influencerPercentage = json['influencerPercentage']?.toString();
    if (json['couponProducts'] != null) {
      final v = json['couponProducts'];
      final arr0 = <CouponModelCouponProducts>[];
      v.forEach((v) {
        arr0.add(CouponModelCouponProducts.fromJson(v));
      });
      couponProducts = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['descriptionEn'] = descriptionEn;
    data['couponType'] = couponType;
    data['amount'] = amount;
    data['percent'] = percent;
    data['mustExceed'] = mustExceed;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['isForAll'] = isForAll;
    data['isActive'] = isActive;
    data['influencerId'] = influencerId;
    if (influencer != null) {
      data['influencer'] = influencer!.toJson();
    }
    data['couponStatus'] = couponStatus;
    data['influencerPercentage'] = influencerPercentage;
    if (couponProducts != null) {
      final v = couponProducts;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['couponProducts'] = arr0;
    }
    return data;
  }
}
