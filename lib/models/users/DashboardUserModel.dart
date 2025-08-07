import 'dart:convert';

import 'package:sislimoda_admin_dashboard/models/user/get_users_model.dart';
List<DashboardUserModel> DashboardUserModelFromJson(String str) =>
    List<DashboardUserModel>.from(
        json.decode(str).map((x) => DashboardUserModel.fromJson(x)));
class DashboardUserModel {
  
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

  DashboardUserModel({
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
  DashboardUserModel.fromJson(Map<String, dynamic> json) {
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
