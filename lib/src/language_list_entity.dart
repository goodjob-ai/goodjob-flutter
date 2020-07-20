class LanguageListEntity {
	int code;
	LanguageListData data;
	String status;

	LanguageListEntity({this.code, this.data, this.status});

	LanguageListEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		data = json['data'] != null ? new LanguageListData.fromJson(json['data']) : null;
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['status'] = this.status;
		return data;
	}
}

class LanguageListData {
	List<LanguageListDataLanguagelist> languageList;

	LanguageListData({this.languageList});

	LanguageListData.fromJson(Map<String, dynamic> json) {
		if (json['LanguageList'] != null) {
			languageList = new List<LanguageListDataLanguagelist>();(json['LanguageList'] as List).forEach((v) { languageList.add(new LanguageListDataLanguagelist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.languageList != null) {
      data['LanguageList'] =  this.languageList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class LanguageListDataLanguagelist {
	String icoUrl;
	String standardMsg;
	String standardCode;

	LanguageListDataLanguagelist({this.icoUrl, this.standardMsg, this.standardCode});

	LanguageListDataLanguagelist.fromJson(Map<String, dynamic> json) {
		icoUrl = json['IcoUrl'];
		standardMsg = json['StandardMsg'];
		standardCode = json['StandardCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['IcoUrl'] = this.icoUrl;
		data['StandardMsg'] = this.standardMsg;
		data['StandardCode'] = this.standardCode;
		return data;
	}
}
