import 'dart:convert';

List<MobileUserModel> MobileUserModelFromJson(String str) =>
    List<MobileUserModel>.from(
        json.decode(str).map((x) => MobileUserModel.fromJson(x)));
class MobileUserModel {
  final String? id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final bool? isActive;
  final String? address;
  final String? otherPhoneNumber;
  final bool? isVendor;
  final bool? isAdmin;
  final String? email;
  final String? userName;
  final String? phoneNumer;
  final String? password;
  final String? photoId;
  final String? photo; 
  final String? gender;
  final String? birthDate;
  final bool? enableNotification;
  final String? pantsMeasurement;
  final String? coachMeasurement;
  final String? tShirtmeasurement;
  final bool? isInfluencer;
  final String? socialLogin;
  final bool? isSocialLogin;

  MobileUserModel({
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

  factory MobileUserModel.fromJson(Map<String, dynamic> json) {
    return MobileUserModel(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      isActive: json['isActive'],
      address: json['address'],
      otherPhoneNumber: json['otherPhoneNumber'],
      isVendor: json['isVendor'],
      isAdmin: json['isAdmin'],
      email: json['email'],
      userName: json['userName'],
      phoneNumer: json['phoneNumer'],
      password: json['password'],
      photoId: json['photoId'],
      photo: json['photo']?['fullLink'],
      gender: json['gender']?.toString(),
      birthDate: json['birthDate'],
      enableNotification: json['enableNotification'],
      pantsMeasurement: json['pantsMeasurement'],
      coachMeasurement: json['coachMeasurement'],
      tShirtmeasurement: json['tShirtmeasurement'],
      isInfluencer: json['isInfluencer'],
      socialLogin: json['socialLogin']?.toString(),
      isSocialLogin: json['isSocialLogin'],
    );
  }
}
