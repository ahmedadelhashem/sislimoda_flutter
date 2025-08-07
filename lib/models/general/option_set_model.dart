import 'dart:convert';

List<OptionSetModel> optionSetModelFromJson(String str) =>
    List<OptionSetModel>.from(
        json.decode(str).map((x) => OptionSetModel.fromJson(x)));

class OptionSetModelOptionSetItems {
/*
{
  "id": "cfbdd725-0e3c-47bc-063f-08dc1ed751be",
  "value": 1,
  "nameAr": "new",
  "nameEn": "new",
  "optionSetId": "30579b4c-1b54-4464-47d6-08dc1ed73cc8",
  "color": "#26c756",
  "isDefault": true
}
*/

  String? id;
  String? value;
  String? nameAr;
  String? nameEn;
  String? optionSetId;
  String? color;
  bool? isDefault;

  OptionSetModelOptionSetItems({
    this.id,
    this.value,
    this.nameAr,
    this.nameEn,
    this.optionSetId,
    this.color,
    this.isDefault,
  });
  OptionSetModelOptionSetItems.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    value = json['value']?.toString();
    nameAr = json['nameAr']?.toString();
    nameEn = json['nameEn']?.toString();
    optionSetId = json['optionSetId']?.toString();
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
    data['color'] = color;
    data['isDefault'] = isDefault;
    return data;
  }
}

class OptionSetModel {
  String? id;
  String? name;
  String? displayNameAr;
  String? displayNameEN;
  List<OptionSetModelOptionSetItems?>? optionSetItems;

  OptionSetModel({
    this.id,
    this.name,
    this.displayNameAr,
    this.displayNameEN,
    this.optionSetItems,
  });
  OptionSetModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    displayNameAr = json['displayNameAr']?.toString();
    displayNameEN = json['displayNameEN']?.toString();
    if (json['optionSetItems'] != null) {
      final v = json['optionSetItems'];
      final arr0 = <OptionSetModelOptionSetItems>[];
      v.forEach((v) {
        arr0.add(OptionSetModelOptionSetItems.fromJson(v));
      });
      optionSetItems = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayNameAr'] = displayNameAr;
    data['displayNameEN'] = displayNameEN;
    if (optionSetItems != null) {
      final v = optionSetItems;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['optionSetItems'] = arr0;
    }
    return data;
  }
}
