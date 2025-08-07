import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/models/general/error_model.dart';
import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';

import '../utility/app_setting.dart';

class AppService {
  static Future<Either<dynamic, ErrorModel>> callService<T>(
      {required ActionType actionType,
      required String apiName,
      required body,
      Map<String, String>? requestHeader,
      List<MultipartFile>? files,
      bool sendLang = true}) async {
    var apiurl = Uri.parse(AppSetting.serviceURL + apiName);
    SharedPreferences ref = await SharedPreferences.getInstance();
    // ref.clear();
    String? token = ref.getString(LocalStoreNames.userToken);
    Map<String, String> header = {
      "content-type": 'application/json',
      "Lang": isArabic ? 'AR' : 'EN',
      "Accept": "*/*",
      if (apiName.contains('login')) "agent": "web"
    };
    if (token != null && token.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token ?? '');
      DateTime expireDate =
          DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      // if (DateTime.now().isAfter(expireDate)) {
      //   var customBody = {
      //     'token': '${ref.getString(LocalStoreNames.userRefreshToken)}'
      //   };
      //   var result = await post(
      //       Uri.parse('${AppSetting.serviceURL}auth/newToken'),
      //       headers: header,
      //       body: jsonEncode(customBody));
      //   print('result.statusCode{}${result.body}');
      //   if (result.statusCode == 200) {
      //     LoginResponseModel responseModel =
      //         LoginResponseModel.fromJson(json.decode(result.body));
      //     ref.setString(
      //         LocalStoreNames.userToken, responseModel.accessToken ?? '');
      //     ref.setString(LocalStoreNames.userRefreshToken,
      //         responseModel.refreshToken ?? '');
      //     token = responseModel.accessToken;
      //   }
      // }
      header.update('Authorization', (value) => "Bearer $token",
          ifAbsent: () => "Bearer $token");
    }
    // debugPrint("api ${AppSetting.serviceURL + apiName}");
    // debugPrint("header $header");
    // debugPrint("body => $body");
    var response;
    if (actionType == ActionType.get) {

      response = await get(apiurl, headers: requestHeader ?? header);
    } else if (actionType == ActionType.post) {
      response = await post(apiurl,
          headers: requestHeader ?? header,
          body: body != null ? jsonEncode(body) : null);
    } else if (actionType == ActionType.patch) {
      response = await patch(apiurl,
          headers: requestHeader ?? header,
          body: body != null ? jsonEncode(body) : null);
    } else if (actionType == ActionType.put) {
      response = await put(apiurl,
          headers: requestHeader ?? header,
          body: body != null ? jsonEncode(body) : null);
    } else if (actionType == ActionType.delete) {
      response = await delete(apiurl,
          headers: requestHeader ?? header,
          body: body != null ? jsonEncode(body) : null);
    } else if (actionType == ActionType.postFormData) {
      var request = MultipartRequest("POST", apiurl);
      request.headers.addAll(header);
      if (body != null) {
        body.forEach((key, value) {
          print('$key : $value');
          request.fields[key] = value.toString();
        });
      }
      for (var element in files ?? []) {
        request.files.add(element);
      }
      print('request.body${request.fields}');
      final streamedResponse = await request.send();
      response = await Response.fromStream(streamedResponse);
    } else if (actionType == ActionType.putFormData) {
      var request = MultipartRequest("PUT", apiurl);
      request.headers.addAll(header);
      body.forEach((key, value) {
        print('$key : $value');
        request.fields[key] = value.toString();
      });
      for (var element in files!) {
        request.files.add(element);
      }
      print('request.body${request.fields}');
      final streamedResponse = await request.send();
      response = await Response.fromStream(streamedResponse);
    }

    debugPrint("api ${AppSetting.serviceURL + apiName}");
    debugPrint("header $header");
    debugPrint("body => $body");
    debugPrint("statusCode =>  ${response.statusCode}");
    debugPrint("response =>  ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = const Utf8Decoder().convert(response.bodyBytes);
      return Left(result);
    } else {
      ErrorModel error = ErrorModel(
          message: json.decode(response.body)['message'].toString(),
          reason: '');
      return Right(error);
    }
  }
}

enum ActionType { get, post, patch, delete, postFormData, putFormData, put }
