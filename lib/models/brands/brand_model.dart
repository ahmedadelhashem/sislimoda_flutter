

import 'dart:convert';

List<BrandModel> brandModelFromJson(String str) => List<BrandModel>.from(
    json.decode(str).map((x) => BrandModel.fromJson(x)));

class BrandModelBrandPhoto {


  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  BrandModelBrandPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  BrandModelBrandPhoto.fromJson(Map<String, dynamic> json) {
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

class BrandModel {
/*
{
  "id": "ff6982b0-f2e8-47c6-0ed6-08dc1e1a7720",
  "name": "اديداس",
  "nameEn": "Adidas",
  "description": "اديداس",
  "descriptionEn": "Adidas",
  "brandPhotoId": "548b654e-14ed-45b8-bd89-492e14f356a6",
  "brandPhoto": {
    "id": "548b654e-14ed-45b8-bd89-492e14f356a6",
    "imageId": "e55d9447-f25c-41c4-91fb-e62e136defa0",
    "name": "e55d9447-f25c-41c4-91fb-e62e136defa0.png",
    "fullLink": "https://sislimoda.com/Files/e55d9447-f25c-41c4-91fb-e62e136defa0.png"
  },
  "order": 0
}
*/

  String? id;
  String? name;
  String? nameEn;
  String? description;
  String? descriptionEn;
  String? brandPhotoId;
  BrandModelBrandPhoto? brandPhoto;
  String? order;

  BrandModel({
    this.id,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.brandPhotoId,
    this.brandPhoto,
    this.order,
  });
  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    nameEn = json['nameEn']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    brandPhotoId = json['brandPhotoId']?.toString();
    brandPhoto = (json['brandPhoto'] != null) ? BrandModelBrandPhoto.fromJson(json['brandPhoto']) : null;
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
    if (brandPhoto != null) {
      data['brandPhoto'] = brandPhoto!.toJson();
    }
    data['order'] = order;
    return data;
  }
}
