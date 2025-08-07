import 'package:intl/intl.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class GlobalCubits {}

class GlobalData {}

class GlobalMethode {
  static getDateFormated({required String dateToParse}) {
    // DateTime date=DateTime('').parse('formattedString')
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateToParse);
    return DateFormat('yMMMMd', isArabic ? 'ar' : 'en').format(date);
  }
}
