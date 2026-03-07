import 'package:flutter/cupertino.dart';


extension IntFix on int {
  double get px {
    return ScreenAdapterHelp.getPx(toDouble());
  }
}

extension DoubleFix on double {
  double get px {
    return ScreenAdapterHelp.getPx(this);
  }
}

/// 屏幕适配工具类
class ScreenAdapterHelp {
  static late MediaQueryData _mediaQuery;
  static late double screenWidth;
  static late double screenHeight;
  static late double rato;

  /// 获取屏幕的缩放率
  static double init(BuildContext context, {double? screenWidth = 375}) {
    _mediaQuery = MediaQuery.of(context);
    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;
    return rato = screenWidth / 375;
  }

  /// 获取设计稿对应的大小
  static double getPx(double size) {
    return rato * size;
  }
}
