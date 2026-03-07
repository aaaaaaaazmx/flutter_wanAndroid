import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 应用文本样式集中管理
class AppTextStyles {
  AppTextStyles._();

  // ==================== 标题 ====================
  /// 登录页标题 (26sp, 白色)
  static const TextStyle loginTitle = TextStyle(
    color: AppColors.textOnDark,
    fontSize: 26,
  );

  /// 登录页副标题 (20sp, 白色)
  static const TextStyle loginSubtitle = TextStyle(
    color: AppColors.textOnDark,
    fontSize: 20,
  );

  // ==================== 按钮 ====================
  /// 登录按钮文字 (20sp, 白色, 细体)
  static const TextStyle loginButton = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w200,
  );

  // ==================== 输入框 ====================
  /// 输入框文字 (17sp, 白色, 常规)
  static const TextStyle inputText = TextStyle(
    fontSize: 17,
    color: AppColors.inputOnDark,
    fontWeight: FontWeight.w400,
  );

  /// 输入框提示文字 (17sp, 白色)
  static const TextStyle inputHint = TextStyle(
    color: AppColors.inputOnDark,
    fontSize: 17,
  );

  // ==================== 正文 / 标签 ====================
  /// 标签文字 (14sp, 黑色) — 需动态 .px 时请在调用处 copyWith
  static const TextStyle tagLabel = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );

  /// AppBar 标题文字 (黑色)
  static const TextStyle appBarTitle = TextStyle(
    color: AppColors.textPrimary,
  );

  // ==================== 导航栏 ====================
  /// 底部导航选中文字
  static TextStyle navActive = TextStyle(color: AppColors.navActive);

  /// 底部导航默认文字
  static TextStyle navDefault = TextStyle(color: AppColors.navDefault);
}
