import 'dart:convert';

List<TicketModel> ticketModelFromJson(String str) => List<TicketModel>.from(
    json.decode(str).map((x) => TicketModel.fromJson(x)));

class TicketModelTicketReplyAppUser {
/*
{
  "id": "3b79445d-9ad3-421b-8af7-9a1c84a26bc7",
  "firstName": "ahmed",
  "middleName": "abdelazeez",
  "lastName": "almaz",
  "isActive": true,
  "address": "",
  "otherPhoneNumber": "",
  "isVendor": false,
  "isAdmin": false,
  "email": "a.almaz1001@gmail.com",
  "userName": "a.almaz1001@gmail.com",
  "phoneNumer": "",
  "photoId": null,
  "photo": null,
  "gender": 0,
  "birthDate": "1/1/0001 12:00:00 AM",
  "photoUrl": null,
  "enableNotification": true,
  "pantsMeasurement": "",
  "coachMeasurement": "",
  "tShirtmeasurement": "",
  "isInfluencer": true,
  "socialLogin": 7,
  "isSocialLogin": true
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
  String? photoId;
  String? photo;
  String? gender;
  String? birthDate;
  String? photoUrl;
  bool? enableNotification;
  String? pantsMeasurement;
  String? coachMeasurement;
  String? tShirtmeasurement;
  bool? isInfluencer;
  String? socialLogin;
  bool? isSocialLogin;

  TicketModelTicketReplyAppUser({
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
    this.photoId,
    this.photo,
    this.gender,
    this.birthDate,
    this.photoUrl,
    this.enableNotification,
    this.pantsMeasurement,
    this.coachMeasurement,
    this.tShirtmeasurement,
    this.isInfluencer,
    this.socialLogin,
    this.isSocialLogin,
  });
  TicketModelTicketReplyAppUser.fromJson(Map<String, dynamic> json) {
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
    photoId = json['photoId']?.toString();
    photo = json['photo']?.toString();
    gender = json['gender']?.toString();
    birthDate = json['birthDate']?.toString();
    photoUrl = json['photoUrl']?.toString();
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
    data['photoId'] = photoId;
    data['photo'] = photo;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['photoUrl'] = photoUrl;
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

class TicketModelTicketReply {
/*
{
  "id": "40a098b7-55b8-4c4c-2b56-08dd739718cb",
  "message": "test",
  "isDeleted": false,
  "ticketId": "65f8f7d3-9a56-4567-20fc-08dd695f6c76",
  "appUserId": "3b79445d-9ad3-421b-8af7-9a1c84a26bc7",
  "appUser": {
    "id": "3b79445d-9ad3-421b-8af7-9a1c84a26bc7",
    "firstName": "ahmed",
    "middleName": "abdelazeez",
    "lastName": "almaz",
    "isActive": true,
    "address": "",
    "otherPhoneNumber": "",
    "isVendor": false,
    "isAdmin": false,
    "email": "a.almaz1001@gmail.com",
    "userName": "a.almaz1001@gmail.com",
    "phoneNumer": "",
    "photoId": null,
    "photo": null,
    "gender": 0,
    "birthDate": "1/1/0001 12:00:00 AM",
    "photoUrl": null,
    "enableNotification": true,
    "pantsMeasurement": "",
    "coachMeasurement": "",
    "tShirtmeasurement": "",
    "isInfluencer": true,
    "socialLogin": 7,
    "isSocialLogin": true
  },
  "isInternal": false,
  "created": "04-04-2025 18:38:15"
}
*/

  String? id;
  String? message;
  bool? isDeleted;
  String? ticketId;
  String? appUserId;
  TicketModelTicketReplyAppUser? appUser;
  bool? isInternal;
  String? created;

  TicketModelTicketReply({
    this.id,
    this.message,
    this.isDeleted,
    this.ticketId,
    this.appUserId,
    this.appUser,
    this.isInternal,
    this.created,
  });
  TicketModelTicketReply.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    message = json['message']?.toString();
    isDeleted = json['isDeleted'];
    ticketId = json['ticketId']?.toString();
    appUserId = json['appUserId']?.toString();
    appUser = (json['appUser'] != null)
        ? TicketModelTicketReplyAppUser.fromJson(json['appUser'])
        : null;
    isInternal = json['isInternal'];
    created = json['created']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['isDeleted'] = isDeleted;
    data['ticketId'] = ticketId;
    data['appUserId'] = appUserId;
    if (appUser != null) {
      data['appUser'] = appUser!.toJson();
    }
    data['isInternal'] = isInternal;
    data['created'] = created;
    return data;
  }
}

class TicketModelAppUser {
/*
{
  "id": "4a5d6326-f275-400b-afab-94251517b19d",
  "firstName": "Abdelmonem",
  "middleName": "Helmy",
  "lastName": "Lashin",
  "isActive": true,
  "address": "",
  "otherPhoneNumber": "",
  "isVendor": false,
  "isAdmin": false,
  "email": "abdo_lashin333@yahoo.com",
  "userName": "abdo_lashin333@yahoo.com",
  "phoneNumer": "",
  "photoId": null,
  "photo": null,
  "gender": 1,
  "birthDate": "1/1/0001 12:00:00 AM",
  "photoUrl": null,
  "enableNotification": true,
  "pantsMeasurement": "",
  "coachMeasurement": "",
  "tShirtmeasurement": "",
  "isInfluencer": true,
  "socialLogin": 7,
  "isSocialLogin": true
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
  String? photoId;
  String? photo;
  String? gender;
  String? birthDate;
  String? photoUrl;
  bool? enableNotification;
  String? pantsMeasurement;
  String? coachMeasurement;
  String? tShirtmeasurement;
  bool? isInfluencer;
  String? socialLogin;
  bool? isSocialLogin;

  TicketModelAppUser({
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
    this.photoId,
    this.photo,
    this.gender,
    this.birthDate,
    this.photoUrl,
    this.enableNotification,
    this.pantsMeasurement,
    this.coachMeasurement,
    this.tShirtmeasurement,
    this.isInfluencer,
    this.socialLogin,
    this.isSocialLogin,
  });
  TicketModelAppUser.fromJson(Map<String, dynamic> json) {
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
    photoId = json['photoId']?.toString();
    photo = json['photo']?.toString();
    gender = json['gender']?.toString();
    birthDate = json['birthDate']?.toString();
    photoUrl = json['photoUrl']?.toString();
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
    data['photoId'] = photoId;
    data['photo'] = photo;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['photoUrl'] = photoUrl;
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

class TicketModelTicketStatus {
/*
{
  "id": "5d8eff6a-6e7c-4556-7b62-08dc44a7a60a",
  "value": 1,
  "nameAr": "openend",
  "nameEn": "Accepted",
  "optionSetId": "d2f639b0-75c2-4073-ffa0-08dc44a77869",
  "optionSet": null,
  "color": "#64f191",
  "isDefault": false
}
*/

  String? id;
  String? value;
  String? nameAr;
  String? nameEn;
  String? optionSetId;
  String? optionSet;
  String? color;
  bool? isDefault;

  TicketModelTicketStatus({
    this.id,
    this.value,
    this.nameAr,
    this.nameEn,
    this.optionSetId,
    this.optionSet,
    this.color,
    this.isDefault,
  });
  TicketModelTicketStatus.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    value = json['value']?.toString();
    nameAr = json['nameAr']?.toString();
    nameEn = json['nameEn']?.toString();
    optionSetId = json['optionSetId']?.toString();
    optionSet = json['optionSet']?.toString();
    color = json['color']?.toString();
    isDefault = json['isDefault'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['optionSetId'] = optionSetId;
    data['optionSet'] = optionSet;
    data['color'] = color;
    data['isDefault'] = isDefault;
    return data;
  }
}

class TicketModel {
/*
{
  "id": "65f8f7d3-9a56-4567-20fc-08dd695f6c76",
  "name": " ",
  "description": "test Abdelmonem ",
  "phone": "",
  "email": "abdo_lashin333@yahoo.com",
  "message": "test Abdelmonem ",
  "ticketStatusId": "5d8eff6a-6e7c-4556-7b62-08dc44a7a60a",
  "ticketStatus": {
    "id": "5d8eff6a-6e7c-4556-7b62-08dc44a7a60a",
    "value": 1,
    "nameAr": "openend",
    "nameEn": "Accepted",
    "optionSetId": "d2f639b0-75c2-4073-ffa0-08dc44a77869",
    "optionSet": null,
    "color": "#64f191",
    "isDefault": false
  },
  "vendorId": null,
  "vendor": null,
  "appUserId": "4a5d6326-f275-400b-afab-94251517b19d",
  "appUser": {
    "id": "4a5d6326-f275-400b-afab-94251517b19d",
    "firstName": "Abdelmonem",
    "middleName": "Helmy",
    "lastName": "Lashin",
    "isActive": true,
    "address": "",
    "otherPhoneNumber": "",
    "isVendor": false,
    "isAdmin": false,
    "email": "abdo_lashin333@yahoo.com",
    "userName": "abdo_lashin333@yahoo.com",
    "phoneNumer": "",
    "photoId": null,
    "photo": null,
    "gender": 1,
    "birthDate": "1/1/0001 12:00:00 AM",
    "photoUrl": null,
    "enableNotification": true,
    "pantsMeasurement": "",
    "coachMeasurement": "",
    "tShirtmeasurement": "",
    "isInfluencer": true,
    "socialLogin": 7,
    "isSocialLogin": true
  },
  "ticketReply": [
    {
      "id": "40a098b7-55b8-4c4c-2b56-08dd739718cb",
      "message": "test",
      "isDeleted": false,
      "ticketId": "65f8f7d3-9a56-4567-20fc-08dd695f6c76",
      "appUserId": "3b79445d-9ad3-421b-8af7-9a1c84a26bc7",
      "appUser": {
        "id": "3b79445d-9ad3-421b-8af7-9a1c84a26bc7",
        "firstName": "ahmed",
        "middleName": "abdelazeez",
        "lastName": "almaz",
        "isActive": true,
        "address": "",
        "otherPhoneNumber": "",
        "isVendor": false,
        "isAdmin": false,
        "email": "a.almaz1001@gmail.com",
        "userName": "a.almaz1001@gmail.com",
        "phoneNumer": "",
        "photoId": null,
        "photo": null,
        "gender": 0,
        "birthDate": "1/1/0001 12:00:00 AM",
        "photoUrl": null,
        "enableNotification": true,
        "pantsMeasurement": "",
        "coachMeasurement": "",
        "tShirtmeasurement": "",
        "isInfluencer": true,
        "socialLogin": 7,
        "isSocialLogin": true
      },
      "isInternal": false,
      "created": "04-04-2025 18:38:15"
    }
  ],
  "created": "22-03-2025 17:34:31"
}
*/

  String? id;
  String? name;
  String? description;
  String? phone;
  String? email;
  String? message;
  String? ticketStatusId;
  TicketModelTicketStatus? ticketStatus;
  String? vendorId;
  String? vendor;
  String? appUserId;
  TicketModelAppUser? appUser;
  List<TicketModelTicketReply?>? ticketReply;
  String? created;

  TicketModel({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.email,
    this.message,
    this.ticketStatusId,
    this.ticketStatus,
    this.vendorId,
    this.vendor,
    this.appUserId,
    this.appUser,
    this.ticketReply,
    this.created,
  });
  TicketModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    description = json['description']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    message = json['message']?.toString();
    ticketStatusId = json['ticketStatusId']?.toString();
    ticketStatus = (json['ticketStatus'] != null)
        ? TicketModelTicketStatus.fromJson(json['ticketStatus'])
        : null;
    vendorId = json['vendorId']?.toString();
    vendor = json['vendor']?.toString();
    appUserId = json['appUserId']?.toString();
    appUser = (json['appUser'] != null)
        ? TicketModelAppUser.fromJson(json['appUser'])
        : null;
    if (json['ticketReply'] != null) {
      final v = json['ticketReply'];
      final arr0 = <TicketModelTicketReply>[];
      v.forEach((v) {
        arr0.add(TicketModelTicketReply.fromJson(v));
      });
      ticketReply = arr0;
    }
    created = json['created']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['phone'] = phone;
    data['email'] = email;
    data['message'] = message;
    data['ticketStatusId'] = ticketStatusId;
    if (ticketStatus != null) {
      data['ticketStatus'] = ticketStatus!.toJson();
    }
    data['vendorId'] = vendorId;
    data['vendor'] = vendor;
    data['appUserId'] = appUserId;
    if (appUser != null) {
      data['appUser'] = appUser!.toJson();
    }
    if (ticketReply != null) {
      final v = ticketReply;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['ticketReply'] = arr0;
    }
    data['created'] = created;
    return data;
  }
}
