import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

List<ProductModelProductOptionsOption> productOptionsFromJson(String str) =>
    List<ProductModelProductOptionsOption>.from(json
        .decode(str)
        .map((x) => ProductModelProductOptionsOption.fromJson(x)));

class ProductModelProductDetails {
/*
{
  "id": "ff6afe3c-ebb1-4e58-69ef-08dc1ee594d1",
  "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
  "key": "معلومات الغسيل",
  "keyEn": "Laundry information",
  "value": "تغسل بالماء البارد",
  "valueEn": "Wash with cold water",
  "icon": ""
}
*/

  String? id;
  String? productId;
  String? key;
  String? keyEn;
  String? value;
  String? valueEn;
  String? icon;

  ProductModelProductDetails({
    this.id,
    this.productId,
    this.key,
    this.keyEn,
    this.value,
    this.valueEn,
    this.icon,
  });
  ProductModelProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    productId = json['productId']?.toString();
    key = json['key']?.toString();
    keyEn = json['keyEn']?.toString();
    value = json['value']?.toString();
    valueEn = json['valueEn']?.toString();
    icon = json['icon']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['key'] = key;
    data['keyEn'] = keyEn;
    data['value'] = value;
    data['valueEn'] = valueEn;
    data['icon'] = icon;
    return data;
  }
}

class ProductModelProductOptionsOption {
/*
{
  "id": "3ceaae1e-5c45-4730-7aff-08dc1e1b5cbd",
  "name": "ازرق",
  "nameEn": "Blue",
  "optionType": 1,
  "other": "#0002a1"
}
*/

  String? id;
  String? name;
  String? nameEn;
  String? optionType;
  String? other;
  String? categoryId;
  String? category;
  String? groupName;
  String? groupKey;

  ProductModelProductOptionsOption({
    this.id,
    this.name,
    this.nameEn,
    this.optionType,
    this.other,
  });
  ProductModelProductOptionsOption.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    nameEn = json['nameEn']?.toString();
    optionType = json['optionType']?.toString();
    other = json['other']?.toString();
    categoryId = json['categoryId']?.toString();
    category = json['category']?.toString();
    groupName = json['groupName']?.toString();
    groupKey = json['groupKey']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameEn'] = nameEn;
    data['optionType'] = optionType;
    data['other'] = other;
    return data;
  }
}

class ProductModelProductOptions {
/*
{
  "id": "284938be-bfd5-4bfe-c20c-08dc1ee594d6",
  "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
  "optionId": "3ceaae1e-5c45-4730-7aff-08dc1e1b5cbd",
  "option": {
    "id": "3ceaae1e-5c45-4730-7aff-08dc1e1b5cbd",
    "name": "ازرق",
    "nameEn": "Blue",
    "optionType": 1,
    "other": "#0002a1"
  },
  "price": 0
}
*/

  String? id;
  String? productId;
  String? optionId;
  ProductModelProductOptionsOption? option;
  String? price;

  ProductModelProductOptions({
    this.id,
    this.productId,
    this.optionId,
    this.option,
    this.price,
  });
  ProductModelProductOptions.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    productId = json['productId']?.toString();
    optionId = json['optionId']?.toString();
    option = (json['option'] != null)
        ? ProductModelProductOptionsOption.fromJson(json['option'])
        : null;
    price = json['price']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['optionId'] = optionId;
    if (option != null) {
      data['option'] = option!.toJson();
    }
    data['price'] = price;
    return data;
  }
}

class ProductModelProductImagesPhoto {
/*
{
  "id": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
  "imageId": "abb388d9-ad22-4700-9455-8309455d29d4",
  "name": "abb388d9-ad22-4700-9455-8309455d29d4.jpg",
  "fullLink": "https://sislimoda.com/Files/abb388d9-ad22-4700-9455-8309455d29d4.jpg"
}
*/

  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  ProductModelProductImagesPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  ProductModelProductImagesPhoto.fromJson(Map<String, dynamic> json) {
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

class ProductModelProductImages {
/*
{
  "id": "72164c85-db89-4bf6-dd7c-08dc83893163",
  "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
  "photoId": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
  "photo": {
    "id": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
    "imageId": "abb388d9-ad22-4700-9455-8309455d29d4",
    "name": "abb388d9-ad22-4700-9455-8309455d29d4.jpg",
    "fullLink": "https://sislimoda.com/Files/abb388d9-ad22-4700-9455-8309455d29d4.jpg"
  }
}
*/

  String? id;
  String? productId;
  String? photoId;
  ProductModelProductImagesPhoto? photo;

  ProductModelProductImages({
    this.id,
    this.productId,
    this.photoId,
    this.photo,
  });
  ProductModelProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    productId = json['productId']?.toString();
    photoId = json['photoId']?.toString();
    photo = (json['photo'] != null)
        ? ProductModelProductImagesPhoto.fromJson(json['photo'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['photoId'] = photoId;
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    return data;
  }
}

class ProductModelCategory {
/*
{
  "id": "88b44ae7-86af-4c2a-8788-08dc1e165a43",
  "mainCategoryId": "2a640e30-3d84-44af-8782-08dc1e165a43",
  "mainCategory": null,
  "name": "وصل حديثا",
  "nameEn": "New Arrived",
  "description": "وصل حديثا",
  "descriptionEn": "Arrived",
  "categoryPhotoId": "23564a42-9d22-4e95-bcc9-95f27e11ee0b",
  "categoryPhoto": null,
  "order": 0
}
*/

  String? id;
  String? mainCategoryId;
  String? mainCategory;
  String? name;
  String? nameEn;
  String? description;
  String? descriptionEn;
  String? categoryPhotoId;
  String? categoryPhoto;
  String? order;

  ProductModelCategory({
    this.id,
    this.mainCategoryId,
    this.mainCategory,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.categoryPhotoId,
    this.categoryPhoto,
    this.order,
  });
  ProductModelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    mainCategoryId = json['mainCategoryId']?.toString();
    mainCategory = json['mainCategory']?.toString();
    name = json['name']?.toString();
    nameEn = json['nameEn']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    categoryPhotoId = json['categoryPhotoId']?.toString();
    categoryPhoto = json['categoryPhoto']?.toString();
    order = json['order']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['mainCategoryId'] = mainCategoryId;
    data['mainCategory'] = mainCategory;
    data['name'] = name;
    data['nameEn'] = nameEn;
    data['description'] = description;
    data['descriptionEn'] = descriptionEn;
    data['categoryPhotoId'] = categoryPhotoId;
    data['categoryPhoto'] = categoryPhoto;
    data['order'] = order;
    return data;
  }
}

class ProductModelBrand {
/*
{
  "id": "ff6982b0-f2e8-47c6-0ed6-08dc1e1a7720",
  "name": "اديداس",
  "nameEn": "Adidas",
  "description": "اديداس",
  "descriptionEn": "Adidas",
  "brandPhotoId": "548b654e-14ed-45b8-bd89-492e14f356a6",
  "brandPhoto": null,
  "order": 0
}
*/

  String? id;
  String? name;
  String? nameEn;
  String? description;
  String? descriptionEn;
  String? brandPhotoId;
  String? brandPhoto;
  String? order;

  ProductModelBrand({
    this.id,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.brandPhotoId,
    this.brandPhoto,
    this.order,
  });
  ProductModelBrand.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    nameEn = json['nameEn']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    brandPhotoId = json['brandPhotoId']?.toString();
    brandPhoto = json['brandPhoto']?.toString();
    order = json['order']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameEn'] = nameEn;
    data['description'] = description;
    data['descriptionEn'] = descriptionEn;
    data['brandPhotoId'] = brandPhotoId;
    data['brandPhoto'] = brandPhoto;
    data['order'] = order;
    return data;
  }
}

class ProductModelDefaultPhoto {
/*
{
  "id": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
  "imageId": "abb388d9-ad22-4700-9455-8309455d29d4",
  "name": "abb388d9-ad22-4700-9455-8309455d29d4.jpg",
  "fullLink": "https://sislimoda.com/Files/abb388d9-ad22-4700-9455-8309455d29d4.jpg"
}
*/

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
  ProductModelDefaultPhoto.fromJson(Map<String, dynamic> json) {
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

class ProductModel {
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
  "defaultPhotoId": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
  "defaultPhoto": {
    "id": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
    "imageId": "abb388d9-ad22-4700-9455-8309455d29d4",
    "name": "abb388d9-ad22-4700-9455-8309455d29d4.jpg",
    "fullLink": "https://sislimoda.com/Files/abb388d9-ad22-4700-9455-8309455d29d4.jpg"
  },
  "categoryId": "88b44ae7-86af-4c2a-8788-08dc1e165a43",
  "vendorId": "0fd4806d-e6e6-48df-7b91-08dc1ed95a1b",
  "amount": 39,
  "brandId": "ff6982b0-f2e8-47c6-0ed6-08dc1e1a7720",
  "brand": {
    "id": "ff6982b0-f2e8-47c6-0ed6-08dc1e1a7720",
    "name": "اديداس",
    "nameEn": "Adidas",
    "description": "اديداس",
    "descriptionEn": "Adidas",
    "brandPhotoId": "548b654e-14ed-45b8-bd89-492e14f356a6",
    "brandPhoto": null,
    "order": 0
  },
  "paymentType": "string",
  "noteForReturn": "Return in 14 days",
  "created": "27-01-2024 13:10:57",
  "category": {
    "id": "88b44ae7-86af-4c2a-8788-08dc1e165a43",
    "mainCategoryId": "2a640e30-3d84-44af-8782-08dc1e165a43",
    "mainCategory": null,
    "name": "وصل حديثا",
    "nameEn": "New Arrived",
    "description": "وصل حديثا",
    "descriptionEn": "Arrived",
    "categoryPhotoId": "23564a42-9d22-4e95-bcc9-95f27e11ee0b",
    "categoryPhoto": null,
    "order": 0
  },
  "productImages": [
    {
      "id": "72164c85-db89-4bf6-dd7c-08dc83893163",
      "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
      "photoId": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
      "photo": {
        "id": "ccf6937b-b440-42aa-a2c4-965d67e21f43",
        "imageId": "abb388d9-ad22-4700-9455-8309455d29d4",
        "name": "abb388d9-ad22-4700-9455-8309455d29d4.jpg",
        "fullLink": "https://sislimoda.com/Files/abb388d9-ad22-4700-9455-8309455d29d4.jpg"
      }
    }
  ],
  "productOptions": [
    {
      "id": "284938be-bfd5-4bfe-c20c-08dc1ee594d6",
      "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
      "optionId": "3ceaae1e-5c45-4730-7aff-08dc1e1b5cbd",
      "option": {
        "id": "3ceaae1e-5c45-4730-7aff-08dc1e1b5cbd",
        "name": "ازرق",
        "nameEn": "Blue",
        "optionType": 1,
        "other": "#0002a1"
      },
      "price": 0
    }
  ],
  "productDetails": [
    {
      "id": "ff6afe3c-ebb1-4e58-69ef-08dc1ee594d1",
      "productId": "16e4e77b-95d7-4a28-e293-08dc1ee594c7",
      "key": "معلومات الغسيل",
      "keyEn": "Laundry information",
      "value": "تغسل بالماء البارد",
      "valueEn": "Wash with cold water",
      "icon": ""
    }
  ],
  "isFavourite": false,
  "productPrice": 0,
  "programDiscountPercentage": 0,
  "programDiscountValue": 0,
  "priceAfterProgramInfluencer": 0,
  "influencerPercentage": 0,
  "influencerValue": 0,
  "priceWithInfluencer": 0,
  "maxDiscountWithFamous": 0,
  "productDiscountPercentage": 0,
  "productDiscountValue": 0,
  "priceBeforeDiscount": 0,
  "maxProgramDiscountPercentage": 0,
  "finalDisplayPrice": 0,
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
  ProductModelDefaultPhoto? defaultPhoto;
  String? categoryId;
  String? vendorId;
  String? amount;
  String? brandId;
  ProductModelBrand? brand;
  String? paymentType;
  String? noteForReturn;
  String? created;
  ProductModelCategory? category;
  List<ProductModelProductImages?>? productImages;
  List<ProductModelProductOptions?>? productOptions;
  List<ProductModelProductDetails?>? productDetails;
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
  String? couponDeduction;
  String? evaluationRate;
  String? mainCategoryId;
  String? subCategoryId;
  String? suggestedSalePriceFromVendor;
  String? valueToDisplayBeforeDiscount;
  String? valueToDisplayAfterDiscount;
  String? totalProductStock;
  String? totalProductSold;
  ProductModel({
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
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    couponDeduction = json['couponDeduction']?.toString();
    totalProductSold = json['totalProductSold']?.toString();
    totalProductStock = json['totalProductStock']?.toString();
    evaluationRate = json['evaluationRate']?.toString();
    mainCategoryId = json['mainCategoryId']?.toString();
    subCategoryId = json['subCategoryId']?.toString();
    suggestedSalePriceFromVendor =
        json['suggestedSalePriceFromVendor']?.toString();
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
        ? ProductModelDefaultPhoto.fromJson(json['defaultPhoto'])
        : null;
    categoryId = json['categoryId']?.toString();
    vendorId = json['vendorId']?.toString();
    amount = json['amount']?.toString();
    brandId = json['brandId']?.toString();
    brand = (json['brand'] != null)
        ? ProductModelBrand.fromJson(json['brand'])
        : null;
    paymentType = json['paymentType']?.toString();
    noteForReturn = json['noteForReturn']?.toString();
    created = json['created']?.toString();
    category = (json['category'] != null)
        ? ProductModelCategory.fromJson(json['category'])
        : null;
    if (json['productImages'] != null) {
      final v = json['productImages'];
      final arr0 = <ProductModelProductImages>[];
      v.forEach((v) {
        arr0.add(ProductModelProductImages.fromJson(v));
      });
      productImages = arr0;
    }
    if (json['productOptions'] != null) {
      final v = json['productOptions'];
      final arr0 = <ProductModelProductOptions>[];
      v.forEach((v) {
        arr0.add(ProductModelProductOptions.fromJson(v));
      });
      productOptions = arr0;
    }
    if (json['productDetails'] != null) {
      final v = json['productDetails'];
      final arr0 = <ProductModelProductDetails>[];
      v.forEach((v) {
        arr0.add(ProductModelProductDetails.fromJson(v));
      });
      productDetails = arr0;
    }
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

    valueToDisplayBeforeDiscount =
        (double.parse(priceAfterProgramInfluencer ?? '0') +
                (double.parse(priceAfterProgramInfluencer ?? '0') / 100) *
                    double.parse(couponDeduction ?? '0'))
            .toStringAsFixed(2);

    valueToDisplayBeforeDiscount =
        (double.parse(valueToDisplayBeforeDiscount ?? '0') +
                (double.parse(valueToDisplayBeforeDiscount ?? '0') / 100) *
                    double.parse(discountPercentage ?? '0'))
            .toStringAsFixed(2);

    valueToDisplayAfterDiscount =
        (double.parse(priceAfterProgramInfluencer ?? '0') +
                (double.parse(priceAfterProgramInfluencer ?? '0') / 100) *
                    double.parse(couponDeduction ?? '0'))
            .toStringAsFixed(2);
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
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['paymentType'] = paymentType;
    data['noteForReturn'] = noteForReturn;
    data['created'] = created;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (productImages != null) {
      final v = productImages;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['productImages'] = arr0;
    }
    if (productOptions != null) {
      final v = productOptions;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['productOptions'] = arr0;
    }
    if (productDetails != null) {
      final v = productDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['productDetails'] = arr0;
    }
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

class ProductDetails {
  String? key;
  String? keyEn;
  String? value;
  String? valueEn;
  String? icon;

  ProductDetails({
    this.key,
    this.keyEn,
    this.value,
    this.valueEn,
    this.icon,
  });
  ProductDetails.fromJson(Map<String, dynamic> json) {
    key = json['key']?.toString();
    keyEn = json['keyEn']?.toString();
    value = json['value']?.toString();
    valueEn = json['valueEn']?.toString();
    icon = json['icon']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['keyEn'] = keyEn;
    data['value'] = value;
    data['valueEn'] = valueEn;
    data['icon'] = icon;
    return data;
  }
  
}
