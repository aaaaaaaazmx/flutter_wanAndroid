import 'package:fluttet_demo/generated/json/base/json_field.dart';
import 'package:fluttet_demo/generated/json/banner_entity.g.dart';
import 'dart:convert';
export 'package:fluttet_demo/generated/json/banner_entity.g.dart';

@JsonSerializable()
class BannerEntity {
	List<BannerData>? data = [];
	int? errorCode = 0;
	String? errorMsg = '';

	BannerEntity();

	factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

	Map<String, dynamic> toJson() => $BannerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BannerData {
	String? desc = '';
	int? id = 0;
	String? imagePath = '';
	int? isVisible = 0;
	int? order = 0;
	String? title = '';
	int? type = 0;
	String? url = '';

	BannerData();

	factory BannerData.fromJson(Map<String, dynamic> json) => $BannerDataFromJson(json);

	Map<String, dynamic> toJson() => $BannerDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}