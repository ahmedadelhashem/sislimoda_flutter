// models/ActiveOfferModel.dart

class ActiveOfferModel {
  final String offerId;
  final String code;
  final String title;
  final String offerType;
  final double amount;
  final double percent;
  final DateTime endDate;
  final DateTime created;

  ActiveOfferModel({
    required this.offerId,
    required this.code,
    required this.title,
    required this.offerType,
    required this.amount,
    required this.percent,
    required this.endDate,
    required this.created,
  });

  factory ActiveOfferModel.fromJson(Map<String, dynamic> json) {
    return ActiveOfferModel(
      offerId: json['offerId'],
      code: json['code'],
      title: json['title'],
      offerType: json['offerType'],
      amount: (json['amount'] as num).toDouble(),
      percent: (json['percent'] as num).toDouble(),
      endDate: DateTime.parse(formatDate(json['endDate'])),
      created: DateTime.parse(formatDate(json['created'])),
    );
  }

  static String formatDate(String input) {
    // input is: "31-03-2026 00:00:00"
    final parts = input.split(" ");
    final date = parts[0].split("-");
    return "${date[2]}-${date[1]}-${date[0]} ${parts[1]}";
  }
}
