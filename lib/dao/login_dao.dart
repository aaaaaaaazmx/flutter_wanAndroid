import 'dart:convert';

import 'package:fluttet_demo/dao/header_util.dart';
import 'package:fluttet_demo/util/navigator_util.dart';
import 'package:http/http.dart' as http;
import 'package:hi_cache/hi_cache.dart';

/// 登录接口
class LoginDao {
  static const urlHost = 'www.wanandroid.com';
  static const boardingPass = "boarding_pass";
  static const userName = "userName";
  static const passWord = "passWord";

  static Future<dynamic> login({
    required String userName,
    required String passWord,
  }) async {
    Map<String, String> paramsMap = {};
    paramsMap["username"] = userName;
    paramsMap["password"] = passWord;
    var uri = Uri.https(urlHost, "/user/login");
    var response = await http.post(
      uri,
      headers: {...hiHeader(), 'Content-Type': 'application/x-www-form-urlencoded'},
      body: paramsMap,
    );
    var utf8decoder = Utf8Decoder();
    var convert = utf8decoder.convert(response.bodyBytes);
    switch (response.statusCode) {
      case 200:
        print(
          "body: ${json.decode(convert)} statusCode: ${response.statusCode}",
        );

        /// 保存登录信息
        _saveBoardingPass(json.decode(convert));
        _saveUserNameAndPassWord(userName, passWord);
        return json.decode(convert);
      default:
        {
          print(
            "body: ${json.decode(convert)} statusCode: ${response.statusCode}",
          );
          return json.decode(convert);
        }
    }
  }

  /// 保存登录信息（HiCache 只支持基本类型，Map 需转为 JSON 字符串）
  static void _saveBoardingPass(value) {
    HiCache.shared().set(boardingPass, json.encode(value));
  }

  /// 获取登录信息
  static dynamic getBoardingPass() {
    var result = HiCache.shared().get(boardingPass);
    if (result != null) {
      return json.decode(result);
    }
    return null;
  }

  static register(String userName, String passWord) async {
    var map = {
      'username': userName,
      'password': passWord,
      'repassword': passWord,
    };
    var uri = Uri.https(urlHost, "/user/register", map);
    var post = await http.post(uri, headers: hiHeader());
    var utf8decoder = Utf8Decoder();
    var convert = utf8decoder.convert(post.bodyBytes);
    var statusCode = post.statusCode;
    switch (statusCode) {
      case 200:
        {
          var decode = json.decode(convert);
          print("body: $decode statusCode: $statusCode");
        }
      default:
        {
          var decode = json.decode(convert);
          print("body: $decode statusCode: $statusCode");
        }
    }
  }

  /// 退出
  static Future<dynamic> loginOut() async {
    var uri = Uri.https(urlHost, "/user/logout/json");
    var post = await http.get(uri, headers: hiHeader());
    var utf8decoder = Utf8Decoder();
    var convert = utf8decoder.convert(post.bodyBytes);
    var statusCode = post.statusCode;
    switch (statusCode) {
      case 200:
        {
          var decode = json.decode(convert);
          await HiCache.shared().remove(boardingPass);
          print("body: $decode statusCode: $statusCode");
          return decode;
        }
      default:
        {
          var decode = json.decode(convert);
          print("body: $decode statusCode: $statusCode");
          return decode;
        }
    }
  }

  static void _saveUserNameAndPassWord(String userName, String passWord) async {
    await HiCache.shared().set(LoginDao.userName, userName);
    await HiCache.shared().set(LoginDao.passWord, passWord);
  }
}

/// {data: {admin: false, chapterTops: [],
/// coinCount: 0, collectIds: [], email: ,
/// icon: , id: 171698, nickname: 000000 9,
/// password: , publicName: 000000 9, token: ,
/// type: 0, username: 000000 9}, errorCode: 0, errorMsg: }
