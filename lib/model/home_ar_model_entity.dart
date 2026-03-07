import 'package:fluttet_demo/generated/json/base/json_field.dart';
import 'package:fluttet_demo/generated/json/home_ar_model_entity.g.dart';
import 'dart:convert';
export 'package:fluttet_demo/generated/json/home_ar_model_entity.g.dart';

@JsonSerializable()
class HomeArModelEntity {
	int? curPage = 0;
	List<HomeArModelDatas>? datas = [];
	int? offset = 0;
	bool? over = false;
	int? pageCount = 0;
	int? size = 0;
	int? total = 0;

	HomeArModelEntity();

	factory HomeArModelEntity.fromJson(Map<String, dynamic> json) => $HomeArModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $HomeArModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HomeArModelDatas {
	bool? adminAdd = false;
	String? apkLink = '';
	int? audit = 0;
	String? author = '';
	bool? canEdit = false;
	int? chapterId = 0;
	String? chapterName = '';
	bool? collect = false;
	int? courseId = 0;
	String? desc = '';
	String? descMd = '';
	String? envelopePic = '';
	bool? fresh = false;
	String? host = '';
	int? id = 0;
	bool? isAdminAdd = false;
	String? link = '';
	String? niceDate = '';
	String? niceShareDate = '';
	String? origin = '';
	String? prefix = '';
	String? projectLink = '';
	int? publishTime = 0;
	int? realSuperChapterId = 0;
	int? selfVisible = 0;
	int? shareDate = 0;
	String? shareUser = '';
	int? superChapterId = 0;
	String? superChapterName = '';
	List<dynamic>? tags = [];
	String? title = '';
	int? type = 0;
	int? userId = 0;
	int? visible = 0;
	int? zan = 0;

	HomeArModelDatas();

	factory HomeArModelDatas.fromJson(Map<String, dynamic> json) => $HomeArModelDatasFromJson(json);

	Map<String, dynamic> toJson() => $HomeArModelDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}