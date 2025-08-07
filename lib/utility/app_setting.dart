class AppSetting {
  static String messenger = "";

  // static const String serviceURL = 'http://pharmacyapp.eu-4.evennode.com/';
  // static const String serviceURL = 'http://pharmacyappc1.eu-4.evennode.com/';
  // static const String serviceURL = 'http://quickcare.eu-4.evennode.com/';
  static const String serviceURL = 'https://sislimoda.com/';

  static const String androidVersion = '';
  static const String iosVersion = '';
  static const String getLocationUrl =
      'http://www.geoplugin.net/json.gp?jsoncallback=?';

  static const String hubUrl = '${serviceURL}SecuritySupervisorHub';
  static const String chatHubUrl = '${serviceURL}chathub';
}

String globalLang = '';
late bool isArabic;
bool isIosTest = true;
RegExp regExpPhone = RegExp(
  r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})+$',
  caseSensitive: false,
  multiLine: false,
);

RegExp regExpEmail = RegExp(
  r'(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))+$',
  caseSensitive: false,
  multiLine: false,
);

RegExp regExpName = RegExp(
  r"^[\p{L} ,.'-]*$",
  caseSensitive: false,
  unicode: true,
  dotAll: true,
  multiLine: false,
);

RegExp regExpNumber = RegExp(
  r"^(?:[0]9)?[0-9]{10}$",
  caseSensitive: false,
  unicode: true,
  dotAll: true,
  multiLine: false,
);
RegExp regExpNumberAndLettersOnly = RegExp(
  r"^(?!\s*$)(\d|\w|[\u0621-\u064A\u0660-\u0669 ])+$",
  caseSensitive: false,
  unicode: true,
  dotAll: true,
  multiLine: false,
);
RegExp passwordRegex = RegExp(
  r"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$",
  caseSensitive: false,
  unicode: true,
  dotAll: true,
  multiLine: false,
);
