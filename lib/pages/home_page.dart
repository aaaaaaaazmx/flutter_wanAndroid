import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttet_demo/dao/home_dao.dart';
import 'package:fluttet_demo/generated/hot_key_entity.dart';
import 'package:fluttet_demo/model/home_ar_model_entity.dart';
import 'package:fluttet_demo/pages/search_page.dart';
import 'package:fluttet_demo/util/navigator_util.dart';
import 'package:fluttet_demo/util/screen_adapter_help.dart';
import 'package:fluttet_demo/util/view_util.dart';
import 'package:fluttet_demo/widget/banner_widget.dart';
import 'package:fluttet_demo/widget/hot_key_list.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:fluttet_demo/widget/search_bar_widget.dart';
import '../dao/login_dao.dart';
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
      LoginDao.loginOut();
      NavigatorUtil.pushLogin();
    },
    child: Text("搜索"),
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
  bool get wantKeepAlive => true;

  double _appBarAlpha = 0;
  // 用 ValueNotifier 隔离 AppBar 重建，滚动时不触发整页 setState
  final ValueNotifier<double> _alphaNotifier = ValueNotifier(0);
  int index = 1;

  get _appBar {
    double top = MediaQuery.of(context).padding.top;
    return ValueListenableBuilder<double>(
      valueListenable: _alphaNotifier,
      builder: (_, alpha, __) => Column(
        children: [
          addShadow(
            child: Container(
              padding: EdgeInsets.only(top: top),
              height: 60.px + top,
              decoration: BoxDecoration(
                color: Color.fromARGB(
                  (alpha * 255).toInt(),
                  255, 255, 255,
                ),
              ),
              child: SearchBarWidget(
                hint: "请输入搜索内容",
                onChanged: (value) {},
                searchBarType: alpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                onTap: () => _jumpToSearch(),
                onLeftButtonClick: () {},
                onRightButtonClick: () {},
                onSearch: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Opacity opacity() {
    return Opacity(
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
  }

  get _listView => EasyRefresh(
    onRefresh: () async {
      _getHotKeyList();
      _handleRefresh();
    },
    onLoad: () async {
      _handleRefresh(position: index);
    },
    child: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: BannerWidget(bannerListUrl: bannerList)),
        SliverToBoxAdapter(child: HotKeyList(hotKeyList: hotKeyEntity)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => ArticleItemWidget(data: homeArModelEntity!.datas![i]),
            childCount: homeArModelEntity?.datas?.length ?? 0,
          ),
        ),
        SliverToBoxAdapter(child: _loginButton),
      ],
    ),
  );

  void _onScroll(double pixels) {
    double alpha = (pixels / appScrollPix).clamp(0.0, 1.0);
    _updateStatusBar(alpha > 0.5);
    // 只更新 notifier，不触发整页 setState
    _alphaNotifier.value = alpha;
  }

  @override
  void dispose() {
    _alphaNotifier.dispose();
    SystemChrome.setSystemUIOverlayStyle(_defaultStyle);
    super.dispose();
  }

  // 请求的文章列表
  HomeArModelEntity? homeArModelEntity;

  Future<void> _handleRefresh({int? position = 0}) async {
    try {
      debugPrint("请求开始");
      var fetch = await HomeDao.fetch(position: position);
      setState(() {
        if (position == 0) {
          homeArModelEntity = fetch;
          index = 1;
        } else {
          homeArModelEntity?.datas?.addAll(fetch?.datas ?? []);
          index++;
        }
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

  void _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage());
  }
}
