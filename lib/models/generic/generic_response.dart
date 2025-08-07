import 'package:equatable/equatable.dart';

class ResponseModel<T extends Model> extends Equatable {
  List<T>? data = [];
  String? message;
  int? currentPage;
  int? nextPage;
  int? totalCount;
  int? count;
  ResponseModel(
      {this.data,
      this.currentPage,
      this.nextPage,
      this.totalCount,
      this.count});

  ResponseModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJson, String responseName) {
    if (json[responseName] != null) {
      data = <T>[];
      for (var v in (json[responseName] as List)) {
        data!.add(fromJson(v));
      }
    }
    message = json['message'];
    currentPage = json['currentPage'];
    nextPage = json['nextPage'];
    totalCount = json['totalCount'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => (v).toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['nextPage'] = nextPage;
    data['totalCount'] = totalCount;
    data['count'] = count;
    return data;
  }

  @override
  List<Object?> get props => [
        data,
        currentPage,
        nextPage,
        totalCount,
        count,
      ];
}

abstract class Model {
  Map<String, dynamic> toJson();
  Model.fromJson(Map<String, dynamic> json);
}
