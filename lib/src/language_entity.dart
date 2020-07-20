class LanguageEntity{
  String icoUrl;
  String standardMsg;
  String standardCode;

  LanguageEntity({this.icoUrl, this.standardMsg, this.standardCode});

  LanguageEntity.fromJson(Map<String, dynamic> json) {
    icoUrl = json['IcoUrl'];
    standardMsg = json['StandardMsg'];
    standardCode = json['StandardCode'].toString().replaceFirst("-", "");;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IcoUrl'] = this.icoUrl;
    data['StandardMsg'] = this.standardMsg;
    data['StandardCode'] = this.standardCode;
    return data;
  }
}