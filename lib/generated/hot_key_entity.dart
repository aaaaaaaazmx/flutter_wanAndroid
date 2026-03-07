import 'package:fluttet_demo/generated/json/base/json_field.dart';
import 'package:fluttet_demo/generated/json/hot_key_entity.g.dart';
import 'dart:convert';
export 'package:fluttet_demo/generated/json/hot_key_entity.g.dart';

@JsonSerializable()
class HotKeyEntity {
	List<HotKeyData>? data = [];
	int? errorCode = 0;
	String? errorMsg = '';

	HotKeyEntity();

	factory HotKeyEntity.fromJson(Map<String, dynamic> json) => $HotKeyEntityFromJson(json);

	Map<String, dynamic> toJson() => $HotKeyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class HotKeyData {
	int? id = 0;
	String? link = '';
	String? name = '';
	int? order = 0;
	int? visible = 0;

	HotKeyData();

	factory HotKeyData.fromJson(Map<String, dynamic> json) => $HotKeyDataFromJson(json);

	Map<String, dynamic> toJson() => $HotKeyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}