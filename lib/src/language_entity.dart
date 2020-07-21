///语言
class LanguageEntity{
  /// icon url
  String icoUrl;
  /// standardMsg
  String standardMsg;
  /// standardCode
  String standardCode;

  LanguageEntity({this.icoUrl, this.standardMsg, this.standardCode});

  LanguageEntity.fromJson(Map<String, dynamic> json) {
    icoUrl = json['IcoUrl'];
    standardMsg = json['StandardMsg'];
    standardCode = json['StandardCode'].toString().replaceFirst("-", "");
  }

}