import 'package:fluttet_demo/generated/json/base/json_convert_content.dart';
import 'package:fluttet_demo/banner_entity.dart';

BannerEntity $BannerEntityFromJson(Map<String, dynamic> json) {
  final BannerEntity bannerEntity = BannerEntity();
  final List<BannerData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BannerData>(e) as BannerData).toList();
  if (data != null) {
    bannerEntity.data = data;
  }
  final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
  if (errorCode != null) {
    bannerEntity.errorCode = errorCode;
  }
  final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
  if (errorMsg != null) {
    bannerEntity.errorMsg = errorMsg;
  }
  return bannerEntity;
}

Map<String, dynamic> $BannerEntityToJson(BannerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['errorCode'] = entity.errorCode;
  data['errorMsg'] = entity.errorMsg;
  return data;
}

extension BannerEntityExtension on BannerEntity {
  BannerEntity copyWith({
    List<BannerData>? data,
    int? errorCode,
    String? errorMsg,
  }) {
    return BannerEntity()
      ..data = data ?? this.data
      ..errorCode = errorCode ?? this.errorCode
      ..errorMsg = errorMsg ?? this.errorMsg;
  }
}

BannerData $BannerDataFromJson(Map<String, dynamic> json) {
  final BannerData bannerData = BannerData();
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    bannerData.desc = desc;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    bannerData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['imagePath']);
  if (imagePath != null) {
    bannerData.imagePath = imagePath;
  }
  final int? isVisible = jsonConvert.convert<int>(json['isVisible']);
  if (isVisible != null) {
    bannerData.isVisible = isVisible;
  }
  final int? order = jsonConvert.convert<int>(json['order']);
  if (order != null) {
    bannerData.order = order;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    bannerData.title = title;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    bannerData.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    bannerData.url = url;
  }
  return bannerData;
}

Map<String, dynamic> $BannerDataToJson(BannerData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['desc'] = entity.desc;
  data['id'] = entity.id;
  data['imagePath'] = entity.imagePath;
  data['isVisible'] = entity.isVisible;
  data['order'] = entity.order;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['url'] = entity.url;
  return data;
}

extension BannerDataExtension on BannerData {
  BannerData copyWith({
    String? desc,
    int? id,
    String? imagePath,
    int? isVisible,
    int? order,
    String? title,
    int? type,
    String? url,
  }) {
    return BannerData()
      ..desc = desc ?? this.desc
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..isVisible = isVisible ?? this.isVisible
      ..order = order ?? this.order
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..url = url ?? this.url;
  }
}