import 'package:flutter/material.dart';

/// 应用颜色常量集中管理
class AppColors {
  AppColors._();

  // ==================== 主色 ====================
  /// 主题种子色
  static const Color primarySeed = Color(0xB73A6EFF);

  // ==================== 背景色 ====================
  /// 页面背景色
  static const Color scaffoldBackground = Colors.white;

  /// 标签/分类容器背景色
  static const Color tagBackground = Color(0xFFF5F5F5);

  /// 文章列表卡片背景色
  static const Color articleCardBackground = Colors.green;

  /// 热键列表容器背景色
  static const Color hotKeyListBackground = Colors.white;

  /// AppBar 背景色
  static const Color appBarBackground = Colors.white;

  /// 状态栏背景色
  static const Color statusBarBackground = Colors.transparent;

  // ==================== 文字色 ====================
  /// 主要文字色
  static const Color textPrimary = Colors.black;

  /// 暗色背景上的文字色
  static const Color textOnDark = Colors.white;

  // ==================== 导航栏 ====================
  /// 底部导航默认色
  static const Color navDefault = Colors.grey;

  /// 底部导航选中色
  static const Color navActive = Colors.blue;

  // ==================== 按钮 ====================
  /// 登录按钮禁用态
  static const Color buttonDisabled = Colors.white60;

  /// 登录按钮启用态
  static const Color buttonEnabled = Colors.orange;

  // ==================== 登录页 ====================
  /// 登录页背景遮罩
  static const Color loginOverlay = Colors.black54;

  // ==================== 输入框 ====================
  /// 输入框分隔线 / 光标 / 文字颜色（暗色背景）
  static const Color inputOnDark = Colors.white;

  // ==================== 边框 ====================
  /// 标签边框色
  static const Color tagBorder = Colors.red;

  // ==================== 轮播图 ====================
  /// 指示器圆点色
  static const Color bannerIndicator = Colors.white;
}
