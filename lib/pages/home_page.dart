import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttet_demo/dao/home_dao.dart';
import 'package:fluttet_demo/dao/login_dao.dart';
import 'package:fluttet_demo/data_type.dart';
import 'package:fluttet_demo/generated/hot_key_entity.dart';
import 'package:fluttet_demo/model/home_ar_model_entity.dart';
import 'package:fluttet_demo/util/navigator_util.dart';
import 'package:fluttet_demo/util/screen_adapter_help.dart';
import 'package:fluttet_demo/widget/banner_widget.dart';
import 'package:fluttet_demo/widget/hot_key_list.dart';

import '../widget/article_lsit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static const appScrollPix = 100;
  late List<String> bannerList = [];
  List<HotKeyData> hotKeyEntity = [];

  get _loginButton => ElevatedButton(
    onPressed: () {
      var loginOut = LoginDao.loginOut();
      NavigatorUtil.pushLogin();
    },
    child: Text("登出"),
  );

  /// 当前状态栏是否为深色图标（用于浅色背景）
  bool _isDarkIcon = false;

  // 其他页面使用的默认样式，离开时恢复用
  static const _defaultStyle = SystemUiOverlayStyle.dark;

  /// 深色图标样式（用于白色 AppBar 背景）
  static const _darkIconStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // Android: 深色图标
    statusBarBrightness: Brightness.light, // iOS: 浅色背景
  );

  /// 浅色图标样式（用于深色 Banner 背景）
  static const _lightIconStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // Android: 浅色图标
    statusBarBrightness: Brightness.dark, // iOS: 深色背景
  );

  @override
  void initState() {
    super.initState();
    // 初始状态：Banner 可见，使用浅色图标
    _updateStatusBar(false);
    _getBannerList();
    _getHotKeyList();
    _handleRefresh();
  }

  /// 更新状态栏样式
  /// [dark] 为 true 时使用深色图标（适配白色背景），false 时使用浅色图标（适配深色背景）
  void _updateStatusBar(bool dark) {
    if (dark == _isDarkIcon) return;
    _isDarkIcon = dark;
    SystemChrome.setSystemUIOverlayStyle(
      dark ? _darkIconStyle : _lightIconStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 要求调用
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              child: _listView,
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  _onScroll(notification.metrics.pixels);
                }
                return false;
              },
            ),
          ),
          _appBar,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;

  double _appBarAlpha = 0;

  get _appBar => Opacity(
    opacity: _appBarAlpha,
    child: Container(
      height: 80.px,
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.px),
          child: Text("首页", style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );

  get _listView => ListView(
    children: [
      BannerWidget(bannerListUrl: bannerList),
      HotKeyList(hotKeyList: hotKeyEntity),
      ArticleLsit(articleList: homeArModelEntity?.datas),
      _loginButton,
    ],
  );

  void _onScroll(double pixels) {
    double alpha = pixels / appScrollPix;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    // alpha > 0.5 时白色 AppBar 明显可见，使用深色图标；否则使用浅色图标适配 Banner
    _updateStatusBar(alpha > 0.5);
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(_defaultStyle);
    super.dispose();
  }

  // 请求的文章列表
  HomeArModelEntity? homeArModelEntity;

  Future<void> _handleRefresh() async {
    try {
      debugPrint("请求开始");
      var fetch = await HomeDao.fetch(position: 1);
      setState(() {
        homeArModelEntity = fetch;
        homeArModelEntity?.datas?.forEach((e) {
          debugPrint("forEach: ${e.title}");
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _getBannerList() async {
    try {
      var bannerEntity = await HomeDao.getBanner();
      var bannerList =
          bannerEntity?.data
              ?.map((e) => e.imagePath!)
              .whereType<String>()
              .toList() ??
          [];

      debugPrint("bannerList: $bannerList");
      setState(() {
        this.bannerList = bannerList;
      });
    } catch (e) {
      debugPrint("$bannerList:${e.toString()}");
    }
  }

  void _getHotKeyList() async {
    try {
      var hotKeyEntitys = await HomeDao.getHotKeyList();
      var hotKeyLists = hotKeyEntitys?.data ?? [];
      setState(() {
        hotKeyEntity = hotKeyLists;
      });
      debugPrint("hotKeyList: $hotKeyLists");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
