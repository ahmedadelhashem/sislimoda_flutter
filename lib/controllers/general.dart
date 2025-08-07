import 'package:dartz/dartz.dart';
import 'package:sislimoda_admin_dashboard/models/general/error_model.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

class GeneralController {
  static Future<Either<dynamic, ErrorModel>> getStatusByName(
      {required String name}) async {
    var result = await AppService.callService(
        actionType: ActionType.post,
        apiName: 'api/OptionSet/GetAllByNames',
        body: [name]);

    return result;
  }
}
