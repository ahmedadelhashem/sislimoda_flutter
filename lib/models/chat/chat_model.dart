import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) =>
    List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

List<ChatModelUserMessages> chatModelUserMessagesMessages(String str) =>
    List<ChatModelUserMessages>.from(
        json.decode(str).map((x) => ChatModelUserMessages.fromJson(x)));

class ChatModelUserMessagesReplayUser {
/*
{
  "id": "8da86f9c-4d12-4512-9d7b-8936d2cd3ef6",
  "firstName": "Sislimoda",
  "middleName": "",
  "lastName": "Admin",
  "isActive": true,
  "address": "mubark elkaber city keuwait",
  "otherPhoneNumber": "01014927191",
  "isVendor": false,
  "isAdmin": true,
  "email": "sislimoda2@gmail.com",
  "userName": "sislimoda2@gmail.com",
  "phoneNumer": "01555438049",
  "password": null,
  "photoId": null,
  "photo": null,
  "gender": 0,
  "birthDate": null,
  "enableNotification": true,
  "pantsMeasurement": "string",
  "coachMeasurement": "string",
  "tShirtmeasurement": "string",
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

  ChatModelUserMessagesReplayUser({
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
  ChatModelUserMessagesReplayUser.fromJson(Map<String, dynamic> json) {
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

class ChatModelUserMessages {
/*
{
  "id": "2a1e36c2-9289-4a07-d50d-08dc4c708c1b",
  "message": "ll",
  "isRead": false,
  "replayUserId": "8da86f9c-4d12-4512-9d7b-8936d2cd3ef6",
  "fromAdmin": true,
  "replayUser": {
    "id": "8da86f9c-4d12-4512-9d7b-8936d2cd3ef6",
    "firstName": "Sislimoda",
    "middleName": "",
    "lastName": "Admin",
    "isActive": true,
    "address": "mubark elkaber city keuwait",
    "otherPhoneNumber": "01014927191",
    "isVendor": false,
    "isAdmin": true,
    "email": "sislimoda2@gmail.com",
    "userName": "sislimoda2@gmail.com",
    "phoneNumer": "01555438049",
    "password": null,
    "photoId": null,
    "photo": null,
    "gender": 0,
    "birthDate": null,
    "enableNotification": true,
    "pantsMeasurement": "string",
    "coachMeasurement": "string",
    "tShirtmeasurement": "string",
    "isInfluencer": false,
    "socialLogin": 0,
    "isSocialLogin": false
  },
  "userChatId": "4a519178-5ef9-4402-dc99-08dc4b2c6dc5",
  "created": "25-03-2024 13:27:16",
  "createdDateTime": "03 Monday 2024",
  "createdSinceTime": "162 months ago"
}
*/

  String? id;
  String? message;
  bool? isRead;
  String? replayUserId;
  bool? fromAdmin;
  ChatModelUserMessagesReplayUser? replayUser;
  String? userChatId;
  String? created;
  String? createdDateTime;
  String? createdSinceTime;

  ChatModelUserMessages({
    this.id,
    this.message,
    this.isRead,
    this.replayUserId,
    this.fromAdmin,
    this.replayUser,
    this.userChatId,
    this.created,
    this.createdDateTime,
    this.createdSinceTime,
  });
  ChatModelUserMessages.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    message = json['message']?.toString();
    isRead = json['isRead'];
    replayUserId = json['replayUserId']?.toString();
    fromAdmin = json['fromAdmin'];
    replayUser = (json['replayUser'] != null)
        ? ChatModelUserMessagesReplayUser.fromJson(json['replayUser'])
        : null;
    userChatId = json['userChatId']?.toString();
    created = json['created']?.toString();
    createdDateTime = json['createdDateTime']?.toString();
    createdSinceTime = json['createdSinceTime']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['isRead'] = isRead;
    data['replayUserId'] = replayUserId;
    data['fromAdmin'] = fromAdmin;
    if (replayUser != null) {
      data['replayUser'] = replayUser!.toJson();
    }
    data['userChatId'] = userChatId;
    data['created'] = created;
    data['createdDateTime'] = createdDateTime;
    data['createdSinceTime'] = createdSinceTime;
    return data;
  }
}

class ChatModelMyAppUser {
/*
{
  "id": "1da8eac9-006a-4841-9fcd-bba67b258067",
  "firstName": "ahmed",
  "middleName": "",
  "lastName": "almaz",
  "isActive": true,
  "address": "",
  "otherPhoneNumber": "",
  "isVendor": false,
  "isAdmin": false,
  "email": "a.almaz826@gmail.com",
  "userName": "a.almaz826@gmail.com",
  "phoneNumer": "99585048",
  "password": null,
  "photoId": null,
  "photo": null,
  "gender": 0,
  "birthDate": "1/1/0001 12:00:00 AM",
  "enableNotification": true,
  "pantsMeasurement": "",
  "coachMeasurement": "",
  "tShirtmeasurement": "XS",
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

  ChatModelMyAppUser({
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
  ChatModelMyAppUser.fromJson(Map<String, dynamic> json) {
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

class ChatModel {
/*
{
  "id": "4a519178-5ef9-4402-dc99-08dc4b2c6dc5",
  "myAppUserId": "1da8eac9-006a-4841-9fcd-bba67b258067",
  "myAppUser": {
    "id": "1da8eac9-006a-4841-9fcd-bba67b258067",
    "firstName": "ahmed",
    "middleName": "",
    "lastName": "almaz",
    "isActive": true,
    "address": "",
    "otherPhoneNumber": "",
    "isVendor": false,
    "isAdmin": false,
    "email": "a.almaz826@gmail.com",
    "userName": "a.almaz826@gmail.com",
    "phoneNumer": "99585048",
    "password": null,
    "photoId": null,
    "photo": null,
    "gender": 0,
    "birthDate": "1/1/0001 12:00:00 AM",
    "enableNotification": true,
    "pantsMeasurement": "",
    "coachMeasurement": "",
    "tShirtmeasurement": "XS",
    "isInfluencer": false,
    "socialLogin": 0,
    "isSocialLogin": false
  },
  "userMessages": [
    {
      "id": "2a1e36c2-9289-4a07-d50d-08dc4c708c1b",
      "message": "ll",
      "isRead": false,
      "replayUserId": "8da86f9c-4d12-4512-9d7b-8936d2cd3ef6",
      "fromAdmin": true,
      "replayUser": {
        "id": "8da86f9c-4d12-4512-9d7b-8936d2cd3ef6",
        "firstName": "Sislimoda",
        "middleName": "",
        "lastName": "Admin",
        "isActive": true,
        "address": "mubark elkaber city keuwait",
        "otherPhoneNumber": "01014927191",
        "isVendor": false,
        "isAdmin": true,
        "email": "sislimoda2@gmail.com",
        "userName": "sislimoda2@gmail.com",
        "phoneNumer": "01555438049",
        "password": null,
        "photoId": null,
        "photo": null,
        "gender": 0,
        "birthDate": null,
        "enableNotification": true,
        "pantsMeasurement": "string",
        "coachMeasurement": "string",
        "tShirtmeasurement": "string",
        "isInfluencer": false,
        "socialLogin": 0,
        "isSocialLogin": false
      },
      "userChatId": "4a519178-5ef9-4402-dc99-08dc4b2c6dc5",
      "created": "25-03-2024 13:27:16",
      "createdDateTime": "03 Monday 2024",
      "createdSinceTime": "162 months ago"
    }
  ]
}
*/

  String? id;
  String? myAppUserId;
  ChatModelMyAppUser? myAppUser;
  List<ChatModelUserMessages?>? userMessages;

  ChatModel({
    this.id,
    this.myAppUserId,
    this.myAppUser,
    this.userMessages,
  });
  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    myAppUserId = json['myAppUserId']?.toString();
    myAppUser = (json['myAppUser'] != null)
        ? ChatModelMyAppUser.fromJson(json['myAppUser'])
        : null;
    if (json['userMessages'] != null) {
      final v = json['userMessages'];
      final arr0 = <ChatModelUserMessages>[];
      v.forEach((v) {
        arr0.add(ChatModelUserMessages.fromJson(v));
      });
      userMessages = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['myAppUserId'] = myAppUserId;
    if (myAppUser != null) {
      data['myAppUser'] = myAppUser!.toJson();
    }
    if (userMessages != null) {
      final v = userMessages;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['userMessages'] = arr0;
    }
    return data;
  }
}
