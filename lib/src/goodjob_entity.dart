class GoodjobEntity {
	String contentDoc;
	String contentLangs;
	String langCode;
	String updatedAt;
	int lineNum;
	String name;
	String createdAt;
	int mid;
	int type;
	String content;
	int cid;
	String desc;

	GoodjobEntity({this.contentDoc, this.contentLangs, this.langCode, this.updatedAt, this.lineNum, this.name, this.createdAt, this.mid, this.type, this.content, this.cid, this.desc});

	GoodjobEntity.fromJson(Map<String, dynamic> json) {
		contentDoc = json['content_doc'];
		contentLangs = json['content_langs'];
		langCode = json['lang_code'];
		updatedAt = json['updated_at'];
		lineNum = json['line_num'];
		name = json['name'];
		createdAt = json['created_at'];
		mid = json['mid'];
		type = json['type'];
		content = json['content'];
		cid = json['cid'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['content_doc'] = this.contentDoc;
		data['content_langs'] = this.contentLangs;
		data['lang_code'] = this.langCode;
		data['updated_at'] = this.updatedAt;
		data['line_num'] = this.lineNum;
		data['name'] = this.name;
		data['created_at'] = this.createdAt;
		data['mid'] = this.mid;
		data['type'] = this.type;
		data['content'] = this.content;
		data['cid'] = this.cid;
		data['desc'] = this.desc;
		return data;
	}
}
