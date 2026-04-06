import 'package:flutter/material.dart';
import 'package:fluttet_demo/util/screen_adapter_help.dart';

/// 搜索

enum SearchBarType { home, normal, homeLight }

class SearchBarWidget extends StatefulWidget {
  /// 是否隐藏左键返回键
  final bool? hideLeft;

  /// 搜索框类型
  final SearchBarType? searchBarType;

  /// 搜索框提示文字
  final String hint;

  /// 默认内容
  final String? defaultText;

  /// 左侧按钮点击的回调
  final void Function()? onLeftButtonClick;

  /// 右侧按钮点击的回调
  final void Function()? onRightButtonClick;

  /// 输入的回调
  final ValueChanged<String> onChanged;

  /// 点击输入框的回调
  final void Function()? onTap;

  /// 搜索按钮的回调
  final void Function()? onSearch;

  const SearchBarWidget({
    super.key,
    this.hideLeft = false,
    this.searchBarType = SearchBarType.normal,
    required this.hint,
    this.defaultText,
    this.onLeftButtonClick,
    this.onRightButtonClick,
    required this.onChanged,
    this.onSearch, this.onTap,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  Widget get _normalSearchBar => Row(
    children: [
      _wrapTap(
        Padding(padding: EdgeInsets.fromLTRB(6, 5, 10, 5), child: _backButton),
        widget.onLeftButtonClick,
      ),
      Expanded(child: _inputBox),
      _wrapTap(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            "搜索",
            style: TextStyle(color: Colors.blue, fontSize: 17.px),
          ),
        ),
        widget.onSearch,
      ),
    ],
  );

  Widget? get _backButton => widget.hideLeft ?? false
      ? null
      : Icon(Icons.arrow_back, color: Colors.grey, size: 26.px);

  /// 输入框
  Widget get _inputBox {
    Color inputColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputColor = Colors.white;
    } else {
      inputColor = Color(0xffededed);
    }
    return Container(
      height: 35.px,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: inputColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal ? 5.px : 15.px,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20.px,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(0xffA9A9A9)
                : Colors.blue,
          ),

          /// 输入框
          Expanded(child: Container(child: _textField)),
          if (showClear)
            _wrapTap(Icon(Icons.clear, size: 22, color: Colors.grey), () {
              setState(() {
                _controller.clear();
              });
              _onChanged('');
            }),
        ],
      ),
    );
  }

  /// 主页搜索样式
  get _homeSearchBar => Row(
    children: [
      _wrapTap(
        Padding(
          padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
          child: Row(
            children: [
              Text("北京", style: TextStyle(color: _homeFontColor)),
              Icon(Icons.expand_more, color: _homeFontColor, size: 22.px),
            ],
          ),
        ),
        widget.onLeftButtonClick,
      ),

      /// 输入框
      Expanded(child: _inputBox),

      /// 登出
      _wrapTap(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            "搜索",
            style: TextStyle(color: _homeFontColor, fontSize: 12.px),
          ),
        ),
        widget.onRightButtonClick,
      ),
    ],
  );

  Color? get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;

  /// 输入框样式
  Widget? get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          controller: _controller,
          onChanged: _onChanged,
          autofocus: true,
          style: TextStyle(
            fontSize: 18.px,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 5, bottom: 15, right: 5),
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 15.px),
          ),
        )
      : _wrapTap(
          Text(
            widget.defaultText?.isNotEmpty == true
                ? widget.defaultText!
                : widget.hint,
            style: TextStyle(fontSize: 13.px, color: Colors.grey),
          ),
          widget.onTap,
        );

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _normalSearchBar
        : _homeSearchBar;
  }

  Widget _wrapTap(Widget? child, void Function()? callback) {
    return GestureDetector(onTap: callback, child: child);
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    widget.onChanged(value);
  }
}
