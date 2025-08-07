

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(
        json.decode(str).map((x) => UserModel.fromJson(x)));


class UserModelAppUser {
/*
{
  "id": "ce556b34-0b2c-4d33-8f1f-820e04ee1ed7",
  "firstName": "Ahmed",
  "middleName": "Abdelazeez",
  "lastName": "Almaz",
  "isActive": false,
  "address": "Gesr Elsuez",
  "otherPhoneNumber": null,
  "isVendor": false,
  "isAdmin": false,
  "email": "a.almaz1@gmail.com",
  "userName": "a.almaz1@gmail.com",
  "phoneNumer": null,
  "password": null,
  "photoId": "ff9c797a-64d3-4e8c-ac97-7f958e7a97fd",
  "photo": null,
  "gender": 0,
  "birthDate": null,
  "enableNotification": false,
  "pantsMeasurement": null,
  "coachMeasurement": null,
  "tShirtmeasurement": null,
  "isInfluencer": false,
  "socialLogin": 0,
  "isSocialLogin": false
}
*/

  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  bool? isActive;
  String? address;
  String? otherPhoneNumber;
  bool? isVendor;
  bool? isAdmin;
  String? email;
  String? userName;
  String? phoneNumer;
  String? password;
  String? photoId;
  String? photo;
  String? gender;
  String? birthDate;
  bool? enableNotification;
  String? pantsMeasurement;
  String? coachMeasurement;
  String? tShirtmeasurement;
  bool? isInfluencer;
  String? socialLogin;
  bool? isSocialLogin;

  UserModelAppUser({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.isActive,
    this.address,
    this.otherPhoneNumber,
    this.isVendor,
    this.isAdmin,
    this.email,
    this.userName,
    this.phoneNumer,
    this.password,
    this.photoId,
    this.photo,
    this.gender,
    this.birthDate,
    this.enableNotification,
    this.pantsMeasurement,
    this.coachMeasurement,
    this.tShirtmeasurement,
    this.isInfluencer,
    this.socialLogin,
    this.isSocialLogin,
  });
  UserModelAppUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    firstName = json['firstName']?.toString();
    middleName = json['middleName']?.toString();
    lastName = json['lastName']?.toString();
    isActive = json['isActive'];
    address = json['address']?.toString();
    otherPhoneNumber = json['otherPhoneNumber']?.toString();
    isVendor = json['isVendor'];
    isAdmin = json['isAdmin'];
    email = json['email']?.toString();
    userName = json['userName']?.toString();
    phoneNumer = json['phoneNumer']?.toString();
    password = json['password']?.toString();
    photoId = json['photoId']?.toString();
    photo = json['photo']?.toString();
    gender = json['gender']?.toString();
    birthDate = json['birthDate']?.toString();
    enableNotification = json['enableNotification'];
    pantsMeasurement = json['pantsMeasurement']?.toString();
    coachMeasurement = json['coachMeasurement']?.toString();
    tShirtmeasurement = json['tShirtmeasurement']?.toString();
    isInfluencer = json['isInfluencer'];
    socialLogin = json['socialLogin']?.toString();
    isSocialLogin = json['isSocialLogin'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['isActive'] = isActive;
    data['address'] = address;
    data['otherPhoneNumber'] = otherPhoneNumber;
    data['isVendor'] = isVendor;
    data['isAdmin'] = isAdmin;
    data['email'] = email;
    data['userName'] = userName;
    data['phoneNumer'] = phoneNumer;
    data['password'] = password;
    data['photoId'] = photoId;
    data['photo'] = photo;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['enableNotification'] = enableNotification;
    data['pantsMeasurement'] = pantsMeasurement;
    data['coachMeasurement'] = coachMeasurement;
    data['tShirtmeasurement'] = tShirtmeasurement;
    data['isInfluencer'] = isInfluencer;
    data['socialLogin'] = socialLogin;
    data['isSocialLogin'] = isSocialLogin;
    return data;
  }
}

class UserModelPhoto {
/*
{
  "id": "ff9c797a-64d3-4e8c-ac97-7f958e7a97fd",
  "imageId": "b37ba468-89cc-4e68-8393-0a6c71874094",
  "name": "b37ba468-89cc-4e68-8393-0a6c71874094.png",
  "fullLink": "https://sislimoda.com/Files/b37ba468-89cc-4e68-8393-0a6c71874094.png"
}
*/

  String? id;
  String? imageId;
  String? name;
  String? fullLink;

  UserModelPhoto({
    this.id,
    this.imageId,
    this.name,
    this.fullLink,
  });
  UserModelPhoto.fromJson(Map<String, dynamic> json) {
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

class UserModel {
/*
{
  "id": "5413d5c5-7e5f-4567-d064-08dcc28dc07c",
  "name": "a.almaz1@gmail.com",
  "phoneNumber": "01014927191",
  "email": "a.almaz1@gmail.com",
  "userTypes": 1,
  "photoId": "ff9c797a-64d3-4e8c-ac97-7f958e7a97fd",
  "photo": {
    "id": "ff9c797a-64d3-4e8c-ac97-7f958e7a97fd",
    "imageId": "b37ba468-89cc-4e68-8393-0a6c71874094",
    "name": "b37ba468-89cc-4e68-8393-0a6c71874094.png",
    "fullLink": "https://sislimoda.com/Files/b37ba468-89cc-4e68-8393-0a6c71874094.png"
  },
  "appUserId": "ce556b34-0b2c-4d33-8f1f-820e04ee1ed7",
  "appUser": {
    "id": "ce556b34-0b2c-4d33-8f1f-820e04ee1ed7",
    "firstName": "Ahmed",
    "middleName": "Abdelazeez",
    "lastName": "Almaz",
    "isActive": false,
    "address": "Gesr Elsuez",
    "otherPhoneNumber": null,
    "isVendor": false,
    "isAdmin": false,
    "email": "a.almaz1@gmail.com",
    "userName": "a.almaz1@gmail.com",
    "phoneNumer": null,
    "password": null,
    "photoId": "ff9c797a-64d3-4e8c-ac97-7f958e7a97fd",
    "photo": null,
    "gender": 0,
    "birthDate": null,
    "enableNotification": false,
    "pantsMeasurement": null,
    "coachMeasurement": null,
    "tShirtmeasurement": null,
    "isInfluencer": false,
    "socialLogin": 0,
    "isSocialLogin": false
  },
  "vendorId": null,
  "vendor": null,
  "isSupperAdmin": true
}
*/

  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? userTypes;
  String? photoId;
  UserModelPhoto? photo;
  String? appUserId;
  UserModelAppUser? appUser;
  String? vendorId;
  String? vendor;
  bool? isSupperAdmin;

  UserModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.userTypes,
    this.photoId,
    this.photo,
    this.appUserId,
    this.appUser,
    this.vendorId,
    this.vendor,
    this.isSupperAdmin,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    email = json['email']?.toString();
    userTypes = json['userTypes']?.toString();
    photoId = json['photoId']?.toString();
    photo = (json['photo'] != null) ? UserModelPhoto.fromJson(json['photo']) : null;
    appUserId = json['appUserId']?.toString();
    appUser = (json['appUser'] != null) ? UserModelAppUser.fromJson(json['appUser']) : null;
    vendorId = json['vendorId']?.toString();
    vendor = json['vendor']?.toString();
    isSupperAdmin = json['isSupperAdmin'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['userTypes'] = userTypes;
    data['photoId'] = photoId;
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    data['appUserId'] = appUserId;
    if (appUser != null) {
      data['appUser'] = appUser!.toJson();
    }
    data['vendorId'] = vendorId;
    data['vendor'] = vendor;
    data['isSupperAdmin'] = isSupperAdmin;
    return data;
  }
}
