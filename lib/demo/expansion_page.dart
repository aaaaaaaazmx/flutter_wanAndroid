import 'package:flutter/material.dart';

class ExpansionPage extends StatelessWidget {
  const ExpansionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "!23123",
      home: Scaffold(
        appBar: AppBar(title: Text("1231231")),
        body: ListView(children: _buileListView()),
      ),
    );
  }

  List<Widget> _buileListView() {
    List<Widget> list = [];
    return list;
  }
}
