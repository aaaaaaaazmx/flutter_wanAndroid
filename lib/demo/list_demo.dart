import 'package:flutter/material.dart';
import 'package:fluttet_demo/util/screen_adapter_help.dart';

class ListDemo extends StatelessWidget {
  const ListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenAdapterHelp.init(context);
    return MaterialApp(
      title: 'ListView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ListViewDemo(),
    );
  }
}

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({super.key});

  @override
  State<ListViewDemo> createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _items = List.generate(15, (i) => '第 ${i + 1} 条数据');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 监听滚动，距底部 200px 时触发加载
  void _onScroll() {
    if (_isLoading) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      _loadMore();
    }
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _items.clear();
      _items.addAll(List.generate(15, (i) => '刷新后 第 ${i + 1} 条'));
    });
  }

  /// 上拉加载更多
  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      final start = _items.length;
      _items.addAll(List.generate(10, (i) => '第 ${start + i + 1} 条数据'));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ListView Demo")),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          controller: _scrollController,
          // 额外 +1 用于底部加载指示器
          itemCount: _items.length + 1,
          itemBuilder: (context, index) {
            // 最后一项：加载指示器
            if (index == _items.length) {
              return _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(3),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 3, constraints: BoxConstraints(minWidth: 20, minHeight: 20, maxWidth: 20, maxHeight: 20),)),
                    )
                  : const SizedBox.shrink();
            }
            return Container(
              height: 60.px,
              margin: EdgeInsets.only(bottom: 8.px),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              child: Text(_items[index]),
            );
          },
        ),
      ),
    );
  }
}

class LiseDemoOr extends StatefulWidget {
  const LiseDemoOr({super.key});

  @override
  State<LiseDemoOr> createState() => _LiseDemoOrState();
}

class _LiseDemoOrState extends State<LiseDemoOr> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.px,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(width: 200.px, child: Text("12312312")),
          Container(width: 100.px, child: Text("12312312")),
          Container(width: 100.px, child: Text("12312312")),
          Container(width: 100.px, child: Text("12312312")),
          Container(width: 100.px, child: Text("12312312")),
        ],
      ),
    );
  }
}
