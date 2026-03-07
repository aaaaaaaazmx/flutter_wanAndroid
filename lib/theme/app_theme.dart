import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 应用主题配置
class AppTheme {
  AppTheme._();

  /// 亮色主题 — 替代 main.dart 中的内联 ThemeData
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarySeed),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
  );
}
