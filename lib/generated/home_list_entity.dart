import 'package:fluttet_demo/generated/json/base/json_field.dart';
import 'package:fluttet_demo/generated/json/home_list_entity.g.dart';
import 'dart:convert';
export 'package:fluttet_demo/generated/json/home_list_entity.g.dart';

@JsonSerializable()
class HomeListEntity {
	HomeListData? data;
	int? errorCode = 0;
	String? errorMsg = '';

	HomeListEntity();

	factory HomeListEntity.fromJson(Map<String, dynamic> json) => $HomeListEntityFromJson(json);

	Map<String, dynamic> toJson() => $HomeListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HomeListData {
	int? curPage = 0;
	List<HomeListDataDatas>? datas = [];
	int? offset = 0;
	bool? over = false;
	int? pageCount = 0;
	int? size = 0;
	int? total = 0;

	HomeListData();

	factory HomeListData.fromJson(Map<String, dynamic> json) => $HomeListDataFromJson(json);

	Map<String, dynamic> toJson() => $HomeListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HomeListDataDatas {
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

	HomeListDataDatas();

	factory HomeListDataDatas.fromJson(Map<String, dynamic> json) => $HomeListDataDatasFromJson(json);

	Map<String, dynamic> toJson() => $HomeListDataDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}