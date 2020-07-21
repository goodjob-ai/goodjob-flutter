/// 语言列表
class LanguageListEntity {
  /// 状态码
  int code;

  /// data
  LanguageListData data;

  /// 状态
  String status;

  LanguageListEntity({this.code, this.data, this.status});

  LanguageListEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null
        ? new LanguageListData.fromJson(json['data'])
        : null;
    status = json['status'];
  }
}

/// 国际化结果列表
class LanguageListData {
  List<LanguageListDataLanguageList> languageList;

  LanguageListData({this.languageList});

  LanguageListData.fromJson(Map<String, dynamic> json) {
    if (json['LanguageList'] != null) {
      languageList = new List<LanguageListDataLanguageList>();
      (json['LanguageList'] as List).forEach((v) {
        languageList.add(new LanguageListDataLanguageList.fromJson(v));
      });
    }
  }
}

/// LanguageListDataLanguageList
class LanguageListDataLanguageList {
  String icoUrl;
  String standardMsg;
  String standardCode;

  LanguageListDataLanguageList(
      {this.icoUrl, this.standardMsg, this.standardCode});

  LanguageListDataLanguageList.fromJson(Map<String, dynamic> json) {
    icoUrl = json['IcoUrl'];
    standardMsg = json['StandardMsg'];
    standardCode = json['StandardCode'];
  }
}
