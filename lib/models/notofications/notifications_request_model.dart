import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

class NotificationModelPhoto {
/*
{
  "id": "e9ef153f-fad5-402b-ac4c-267316161df4",
  "imageId": "6744dc80-164f-454a-9221-0f76f12092b7",
  "name": "6744dc80-164f-454a-9221-0f76f12092b7.png",
  "fullLink": "https://sislimoda.com/Files/6744dc80-164f-454a-9221-0f76f12092b7.png"
}
*/

  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  NotificationModelPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  NotificationModelPhoto.fromJson(Map<String, dynamic> json) {
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

class NotificationModel {
/*
{
  "id": "fcaa3769-39b2-4a9c-5b85-08dcb5f6f6eb",
  "isDeleted": false,
  "photoId": "e9ef153f-fad5-402b-ac4c-267316161df4",
  "photo": {
    "id": "e9ef153f-fad5-402b-ac4c-267316161df4",
    "imageId": "6744dc80-164f-454a-9221-0f76f12092b7",
    "name": "6744dc80-164f-454a-9221-0f76f12092b7.png",
    "fullLink": "https://sislimoda.com/Files/6744dc80-164f-454a-9221-0f76f12092b7.png"
  },
  "title": "عرض البشره",
  "titleEn": "skin offer",
  "description": "عرض البشره",
  "descriptionEn": "skin offer",
  "created": "06-08-2024 19:05:48",
  "createdDateTime": "08 Tuesday 2024",
  "createdSinceTime": "27 days ago"
}
*/

  String? id;
  bool? isDeleted;
  String? photoId;
  NotificationModelPhoto? photo;
  String? title;
  String? titleEn;
  String? description;
  String? descriptionEn;
  String? created;
  String? createdDateTime;
  String? createdSinceTime;

  NotificationModel({
    this.id,
    this.isDeleted,
    this.photoId,
    this.photo,
    this.title,
    this.titleEn,
    this.description,
    this.descriptionEn,
    this.created,
    this.createdDateTime,
    this.createdSinceTime,
  });
  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    isDeleted = json['isDeleted'];
    photoId = json['photoId']?.toString();
    photo = (json['photo'] != null)
        ? NotificationModelPhoto.fromJson(json['photo'])
        : null;
    title = json['title']?.toString();
    titleEn = json['titleEn']?.toString();
    description = json['description']?.toString();
    descriptionEn = json['descriptionEn']?.toString();
    created = json['created']?.toString();
    createdDateTime = json['createdDateTime']?.toString();
    createdSinceTime = json['createdSinceTime']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['photoId'] = photoId;
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    data['title'] = title;
    data['titleEn'] = titleEn;
    data['description'] = description;
    data['descriptionEn'] = descriptionEn;
    data['created'] = created;
    data['createdDateTime'] = createdDateTime;
    data['createdSinceTime'] = createdSinceTime;
    return data;
  }
}
