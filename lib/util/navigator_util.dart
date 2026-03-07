import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttet_demo/pages/home_page.dart';
import 'package:fluttet_demo/pages/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;
  static updateContext(BuildContext context) {
    _context = context;
    print("updateContext: $context");
  }

  /// 跳转到指定页面
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  /// 跳转到首页
  static void pushHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  /// 跳转到登录页
  static void pushLogin() {
    Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}