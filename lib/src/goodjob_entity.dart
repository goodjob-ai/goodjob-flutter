///翻译
class GoodjobEntity {
  /// 文档翻译内容
	String contentDoc;
	/// 语言list
	String contentLangs;
	/// 语言标准码
	String langCode;
	/// 更新时间
	String updatedAt;
	int lineNum;
	/// 项目名称
	String name;
	/// 创建时间
	String createdAt;
	int mid;
	/// 分类
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

}
