import 'dart:convert';

List<SettingsModel> settingsModelFromJson(String str) =>
    List<SettingsModel>.from(
        json.decode(str).map((x) => SettingsModel.fromJson(x)));

class SettingsModel {
  String? id;
  String? key;
  String? keyAr;
  String? value;
  bool? isLocked;

  SettingsModel({
    this.id,
    this.key,
    this.keyAr,
    this.value,
    this.isLocked,
  });
  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    key = json['key']?.toString();
    keyAr = json['keyAr']?.toString();
    value = json['value']?.toString();
    isLocked = json['isLocked'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['keyAr'] = keyAr;
    data['value'] = value;
    data['isLocked'] = isLocked;
    return data;
  }
    SettingsModel copyWith({
    String? id,
    String? key,
    String? keyAr,
    String? value,
    bool? isLocked,
  }) {
    return SettingsModel(
      id: id ?? this.id,
      key: key ?? this.key,
      keyAr: keyAr ?? this.keyAr,
      value: value ?? this.value,
      isLocked: isLocked ?? this.isLocked,
    );
  }

}
