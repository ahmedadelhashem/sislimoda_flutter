import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> changeOrderStatus({
  required String orderId,
  required String orderStatusId,
}) async {
  final url = Uri.parse("http://sislimoda.runasp.net/api/Orders/ChangeOrderStatus");

  final body = jsonEncode({
    "orderID": orderId,
    "orderStatusId": orderStatusId,
  });

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print("Order status updated successfully.");
    } else {
      print("Failed to update order status: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("Error while changing order status: $e");
  }
}
