import 'dart:convert';

import 'package:sislimoda_admin_dashboard/models/user/influencer_model.dart';

List<InfluencerModel> InfluencerModelFromJson(String str) =>
    List<InfluencerModel>.from(
        json.decode(str).map((x) => InfluencerModel.fromJson(x)));
// class InfluencerModel {
//   final String? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final bool? isActive;
//   final String? influencerStatusId;
//   final String? userId;
//   final InfluencerModelUser? user;
//   final InfluencerModelInfluencerStatus? influencerStatus;
//   final int? numberOfProduct;
//   final String? idNumber;
//   final String? bankAccountNumber;
//   final String? whatsappNumber1;
//   final String? whatsappNumber2;
//   final String? telegramNumber1;
//   final String? telegramNumber2;
//   final String? facebookLink;
//   final String? twitterLink;
//   final String? instagramLink;
//   final String? linkedInLink;
//   final String? youTubeLink;
//   final String? snapchatLink;
//   final String? tikTokLink;
//  final String? password;

//   InfluencerModel({
//     this.userId,
//     this.user,
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.isActive,
//     this.influencerStatusId,
//     this.influencerStatus,
//     this.numberOfProduct,
//     this.idNumber,
//     this.bankAccountNumber,
//     this.whatsappNumber1,
//     this.whatsappNumber2,
//     this.telegramNumber1,
//     this.telegramNumber2,
//     this.facebookLink,
//     this.twitterLink,
//     this.instagramLink,
//     this.linkedInLink,
//     this.youTubeLink,
//     this.snapchatLink,
//     this.tikTokLink,
//     this.password
//   });

//   factory InfluencerModel.fromJson(Map<String, dynamic> json) {
//     return InfluencerModel(
//       id: json['id']?.toString(),
//       name: json['name']?.toString(),
//       email: json['email']?.toString(),
//       phone: json['phone']?.toString(),
//       isActive: json['isActive'] as bool?,
//       influencerStatusId: json['influencerStatusId']?.toString(),
//       influencerStatus: json['influencerStatus'] != null
//           ? InfluencerModelInfluencerStatus.fromJson(json['influencerStatus'])
//           : null,
//     userId : json['userId']?.toString(),
//     user : (json['user'] != null)
//         ? InfluencerModelUser.fromJson(json['user'])
//         : null,  
//       numberOfProduct: json['numberOfProduct'] is int
//           ? json['numberOfProduct']
//           : int.tryParse(json['numberOfProduct']?.toString() ?? ''),
//       idNumber: json['idNumber']?.toString(),
//       bankAccountNumber: json['bankAccountNumber']?.toString(),
//       whatsappNumber1: json['whatsappNumber1']?.toString(),
//       whatsappNumber2: json['whatsappNumber2']?.toString(),
//       telegramNumber1: json['telegramNumber1']?.toString(),
//       telegramNumber2: json['telegramNumber2']?.toString(),
//       facebookLink: json['facebookLink']?.toString(),
//       twitterLink: json['twitterLink']?.toString(),
//       instagramLink: json['instagramLink']?.toString(),
//       linkedInLink: json['linkedInLink']?.toString(),
//       youTubeLink: json['youTubeLink']?.toString(),
//       snapchatLink: json['snapchatLink']?.toString(),
//       tikTokLink: json['tikTokLink']?.toString(),
//       password: json['password']?.toString()
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'isActive': isActive,
//       'influencerStatusId': influencerStatusId,
//       'influencerStatus': influencerStatus?.toJson(),
//       'numberOfProduct': numberOfProduct,
//       'idNumber': idNumber,
//       'bankAccountNumber': bankAccountNumber,
//       'whatsappNumber1': whatsappNumber1,
//       'whatsappNumber2': whatsappNumber2,
//       'telegramNumber1': telegramNumber1,
//       'telegramNumber2': telegramNumber2,
//       'facebookLink': facebookLink,
//       'twitterLink': twitterLink,
//       'instagramLink': instagramLink,
//       'linkedInLink': linkedInLink,
//       'youTubeLink': youTubeLink,
//       'snapchatLink': snapchatLink,
//       'tikTokLink': tikTokLink,
//       'password':password,
//       'userId':userId,
//       'user': user?.toJson(),
//     };
//   }
// }
class InfluencerModel {
  final String? id;
  final String? name;
  final String? email;
  final String? photoId;
  final InfluencerModelPhoto? photo;
  final String? phone;
  final bool? isActive;
  final String? influencerStatusId;
  final String? userId;
  final InfluencerModelUser? user;
  final InfluencerModelInfluencerStatus? influencerStatus;
  final int? numberOfProduct;
  final String? idNumber;
  final String? bankAccountNumber;
  final String? whatsappNumber1;
  final String? whatsappNumber2;
  final String? telegramNumber1;
  final String? telegramNumber2;
  final String? facebookLink;
  final String? twitterLink;
  final String? instagramLink;
  final String? linkedInLink;
  final String? youTubeLink;
  final String? snapchatLink;
  final String? tikTokLink;
  final String? password;

  InfluencerModel({
        this.photoId,
    this.photo,
    this.userId,
    this.user,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isActive,
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
    this.password,
  });

  /// ✅ نسخة فاضية من InfluencerModel
  factory InfluencerModel.empty() {
    return InfluencerModel(
      id: '',
      name: '',
      email: '',
      phone: '',
      isActive: true,
      influencerStatusId: '',
      userId: '',
      user: null,
      influencerStatus: null,
      numberOfProduct: 0,
      idNumber: '',
      bankAccountNumber: '',
      whatsappNumber1: '',
      whatsappNumber2: '',
      telegramNumber1: '',
      telegramNumber2: '',
      facebookLink: '',
      twitterLink: '',
      instagramLink: '',
      linkedInLink: '',
      youTubeLink: '',
      snapchatLink: '',
      tikTokLink: '',
      password: '',
      photoId: '',

    );
  }

  factory InfluencerModel.fromJson(Map<String, dynamic> json) {
    return InfluencerModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      isActive: json['isActive'] as bool?,
      influencerStatusId: json['influencerStatusId']?.toString(),
      influencerStatus: json['influencerStatus'] != null
          ? InfluencerModelInfluencerStatus.fromJson(json['influencerStatus'])
          : null,
      userId: json['userId']?.toString(),
      user: (json['user'] != null)
          ? InfluencerModelUser.fromJson(json['user'])
          : null,
      numberOfProduct: json['numberOfProduct'] is int
          ? json['numberOfProduct']
          : int.tryParse(json['numberOfProduct']?.toString() ?? ''),
      idNumber: json['idNumber']?.toString(),
      bankAccountNumber: json['bankAccountNumber']?.toString(),
      whatsappNumber1: json['whatsappNumber1']?.toString(),
      whatsappNumber2: json['whatsappNumber2']?.toString(),
      telegramNumber1: json['telegramNumber1']?.toString(),
      telegramNumber2: json['telegramNumber2']?.toString(),
      facebookLink: json['facebookLink']?.toString(),
      twitterLink: json['twitterLink']?.toString(),
      instagramLink: json['instagramLink']?.toString(),
      linkedInLink: json['linkedInLink']?.toString(),
      youTubeLink: json['youTubeLink']?.toString(),
      snapchatLink: json['snapchatLink']?.toString(),
      tikTokLink: json['tikTokLink']?.toString(),
      password: json['password']?.toString(),
      photoId: json['photoId']?.toString(),
      photo: json['photo'] != null
          ? InfluencerModelPhoto.fromJson(json['photo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isActive': isActive,
      'influencerStatusId': influencerStatusId,
      'influencerStatus': influencerStatus?.toJson(),
      'numberOfProduct': numberOfProduct,
      'idNumber': idNumber,
      'bankAccountNumber': bankAccountNumber,
      'whatsappNumber1': whatsappNumber1,
      'whatsappNumber2': whatsappNumber2,
      'telegramNumber1': telegramNumber1,
      'telegramNumber2': telegramNumber2,
      'facebookLink': facebookLink,
      'twitterLink': twitterLink,
      'instagramLink': instagramLink,
      'linkedInLink': linkedInLink,
      'youTubeLink': youTubeLink,
      'snapchatLink': snapchatLink,
      'tikTokLink': tikTokLink,
      'password': password,
      'userId': userId,
      'user': user?.toJson(),
      'photoId': photoId,
      'photo': photo?.toJson(),
    };
  }
}
