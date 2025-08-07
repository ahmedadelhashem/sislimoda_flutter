import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));
class CategoryModelCategoryPhoto {
/*
{
  "id": "f679ee58-a4c6-4111-a478-b32b3256d84c",
  "imageId": "b4c34d1a-0223-4e00-baa9-cacaa0c77c7c",
  "name": "b4c34d1a-0223-4e00-baa9-cacaa0c77c7c.jpg",
  "fullLink": "https://sislimoda.com/Files/b4c34d1a-0223-4e00-baa9-cacaa0c77c7c.jpg"
}
*/

  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  CategoryModelCategoryPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  CategoryModelCategoryPhoto.fromJson(Map<String, dynamic> json) {
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

class CategoryModel {
/*
{
  "id": "c72c612e-9f80-4381-8781-08dc1e165a43",
  "mainCategoryId": null,
  "mainCategory": null,
  "name": "الرجال",
  "nameEn": "Mens",
  "description": "الرجال",
  "descriptionEn": "Mens",
  "categoryPhotoId": "f679ee58-a4c6-4111-a478-b32b3256d84c",
  "categoryPhoto": {
    "id": "f679ee58-a4c6-4111-a478-b32b3256d84c",
    "imageId": "b4c34d1a-0223-4e00-baa9-cacaa0c77c7c",
    "name": "b4c34d1a-0223-4e00-baa9-cacaa0c77c7c.jpg",
    "fullLink": "https://sislimoda.com/Files/b4c34d1a-0223-4e00-baa9-cacaa0c77c7c.jpg"
  },
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
  CategoryModelCategoryPhoto? categoryPhoto;
  String? order;

  CategoryModel({
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
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    mainCategoryId = json['mainCategoryId']?.toString();
    mainCategory = json['mainCategory']?.toString();
    name = json['name']?.toString();
    nameEn = json['nameEn']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    categoryPhotoId = json['categoryPhotoId']?.toString();
    categoryPhoto = (json['categoryPhoto'] != null) ? CategoryModelCategoryPhoto.fromJson(json['categoryPhoto']) : null;
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
    if (categoryPhoto != null) {
      data['categoryPhoto'] = categoryPhoto!.toJson();
    }
    data['order'] = order;
    return data;
  }
}
