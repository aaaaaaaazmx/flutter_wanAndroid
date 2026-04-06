import 'package:flutter/material.dart';
import 'package:fluttet_demo/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("搜索")),
      body: Column(
        children: [
          SearchBarWidget(
            searchBarType: SearchBarType.homeLight,
            hint: "请输入搜索内容",
            onChanged: (s) {
              debugPrint("搜索内容: $s");
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
