import 'package:fluttet_demo/generated/json/base/json_convert_content.dart';
import 'package:fluttet_demo/generated/hot_key_entity.dart';

HotKeyEntity $HotKeyEntityFromJson(Map<String, dynamic> json) {
  final HotKeyEntity hotKeyEntity = HotKeyEntity();
  final List<HotKeyData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<HotKeyData>(e) as HotKeyData).toList();
  if (data != null) {
    hotKeyEntity.data = data;
  }
  final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
  if (errorCode != null) {
    hotKeyEntity.errorCode = errorCode;
  }
  final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
  if (errorMsg != null) {
    hotKeyEntity.errorMsg = errorMsg;
  }
  return hotKeyEntity;
}

Map<String, dynamic> $HotKeyEntityToJson(HotKeyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['errorCode'] = entity.errorCode;
  data['errorMsg'] = entity.errorMsg;
  return data;
}

extension HotKeyEntityExtension on HotKeyEntity {
  HotKeyEntity copyWith({
    List<HotKeyData>? data,
    int? errorCode,
    String? errorMsg,
  }) {
    return HotKeyEntity()
      ..data = data ?? this.data
      ..errorCode = errorCode ?? this.errorCode
      ..errorMsg = errorMsg ?? this.errorMsg;
  }
}

HotKeyData $HotKeyDataFromJson(Map<String, dynamic> json) {
  final HotKeyData hotKeyData = HotKeyData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    hotKeyData.id = id;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    hotKeyData.link = link;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    hotKeyData.name = name;
  }
  final int? order = jsonConvert.convert<int>(json['order']);
  if (order != null) {
    hotKeyData.order = order;
  }
  final int? visible = jsonConvert.convert<int>(json['visible']);
  if (visible != null) {
    hotKeyData.visible = visible;
  }
  return hotKeyData;
}

Map<String, dynamic> $HotKeyDataToJson(HotKeyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['link'] = entity.link;
  data['name'] = entity.name;
  data['order'] = entity.order;
  data['visible'] = entity.visible;
  return data;
}

extension HotKeyDataExtension on HotKeyData {
  HotKeyData copyWith({
    int? id,
    String? link,
    String? name,
    int? order,
    int? visible,
  }) {
    return HotKeyData()
      ..id = id ?? this.id
      ..link = link ?? this.link
      ..name = name ?? this.name
      ..order = order ?? this.order
      ..visible = visible ?? this.visible;
  }
}