import 'package:flutter/material.dart';
import 'package:fluttet_demo/generated/hot_key_entity.dart';
import 'package:fluttet_demo/util/screen_adapter_help.dart';

class HotKeyList extends StatelessWidget {
  final List<HotKeyData> hotKeyList;

  const HotKeyList({super.key, required this.hotKeyList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.px),
      padding: EdgeInsets.all(10.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: hotKeyList.map((hotKey) => _getItemList(context, hotKey)).toList(),
      ),
    );
  }

  Widget _getItemList(BuildContext context, HotKeyData hotKey) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        hotKey.name ?? "",
        style: TextStyle(color: Colors.black, fontSize: 14.px),
      ),
    );
  }
}
