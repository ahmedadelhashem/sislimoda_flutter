class AdModel {
  final int id;
  final String country;
  final String imagePath;

  AdModel({required this.id, required this.country, required this.imagePath});

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      country: json['country'],
      imagePath: json['imagePath'],
    );
  }

String get fullImageUrl => 'http://sislimoda.runasp.net$imagePath';
}
