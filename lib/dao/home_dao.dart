import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttet_demo/banner_entity.dart';
import 'package:fluttet_demo/dao/header_util.dart';
import 'package:fluttet_demo/generated/hot_key_entity.dart';
import 'package:fluttet_demo/model/home_ar_model_entity.dart';
import 'package:fluttet_demo/util/navigator_util.dart';
import 'package:http/http.dart' as http;

/// 首页Dao数据接口
class HomeDao {
  static const urlHost = 'https://www.wanandroid.com';
  static Future<HomeArModelEntity?> fetch({int? position = 0}) async {
    var url = Uri.parse("${urlHost}/article/list/$position/json");
    var response = await http.get(url);
    var utf8decoder = Utf8Decoder();
    var convert = utf8decoder.convert(response.bodyBytes);
    debugPrint(convert);
    switch (response.statusCode) {
      case 200:
        {
          debugPrint(
            "body: ${json.decode(convert)} statusCode: ${response.statusCode}",
          );
          var homeArModelEntity = HomeArModelEntity.fromJson(
            json.decode(convert)['data'],
          );
          return homeArModelEntity;
        }
      case 401:
        {
          NavigatorUtil.pushLogin();
          return null;
        }
      default:
        {
          return throw Exception(convert);
        }
    }
  }

  static Future<BannerEntity?> getBanner() async {
    var parse = Uri.parse("${urlHost}/banner/json");
    var response = await http.get(parse, headers: hiHeader());
    var utf8decoder = Utf8Decoder();
    var convert = utf8decoder.convert(response.bodyBytes);
    switch (response.statusCode) {
      case 200:
        {
          debugPrint(
            "body: ${json.decode(convert)} statusCode: ${response.statusCode}",
          );
          var bannerEntity = BannerEntity.fromJson(json.decode(convert));
          debugPrint(
            "banner/json/body: ${bannerEntity.data?.length} statusCode: ${response.statusCode}",
          );
          return bannerEntity;
        }

      case 401:
        {
          NavigatorUtil.pushLogin();
        }

      default:
        {
          return throw Exception(convert);
        }
    }
    return null;
  }

  /// 搜索热词
  static Future<HotKeyEntity?> getHotKeyList() async {
    var parse = Uri.parse("${urlHost}/hotkey/json");
    var response = await http.get(parse);
    var utf8decoder = Utf8Decoder();
    debugPrint("gethotKeyList: ${utf8decoder.convert(response.bodyBytes)}");
    switch (response.statusCode) {
      case 200:
        {
          var hotKeyEntity = HotKeyEntity.fromJson(json.decode(utf8decoder.convert(response.bodyBytes)));
          return hotKeyEntity;
        }

      case 401:
        {
          NavigatorUtil.pushLogin();
        }

      default:
        {
          return throw Exception(response.body);
        }
    }
    return null;
  }

  /// 点赞加收藏
  static Future<dynamic> getLikeList({int? position = 0}) async {
    var parse = Uri.parse("${urlHost}/lg/collect/$position/json");
    var post = await http.post(parse, headers: hiHeader());
    var convert = Utf8Decoder().convert(post.bodyBytes);
    switch (post.statusCode) {
      case 200:
        {
          var result = json.decode(convert);
          debugPrint("getLikeList: $result");
          return result;
        }
      case 401:
        {
          NavigatorUtil.pushLogin();
          return null;
        }
      default:
        return throw Exception(convert);
    }
  }

  /// 取消点赞
  static Future<dynamic> getUnLikeList({int? position = 0}) async {
    var parse = Uri.parse("${urlHost}/lg/uncollect_originId/$position/json");
    var post = await http.post(parse, headers: hiHeader());
    var convert = Utf8Decoder().convert(post.bodyBytes);
    switch (post.statusCode) {
      case 200:
        {
          var result = json.decode(convert);
          debugPrint("getUnLikeList: $result");
          return result;
        }
      case 401:
        {
          NavigatorUtil.pushLogin();
          return null;
        }
      default:
        return throw Exception(convert);
    }
  }
}
