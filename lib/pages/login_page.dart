import 'package:flutter/material.dart';
import 'package:fluttet_demo/dao/login_dao.dart';
import 'package:fluttet_demo/util/navigator_util.dart';
import 'package:fluttet_demo/util/view_util.dart';
import 'package:fluttet_demo/widget/input_widget.dart';
import 'package:fluttet_demo/widget/login_button.dart';
import 'package:hi_cache/hi_cache.dart';

/// 登录界面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? userName;
  String? passWord;
  bool? loginEnable;

  late TextEditingController _userNameController;
  late TextEditingController _passWordController;

  @override
  void initState() {
    super.initState();
    userName = HiCache.shared().get(LoginDao.userName);
    passWord = HiCache.shared().get(LoginDao.passWord);
    _userNameController = TextEditingController(text: userName);
    _passWordController = TextEditingController(text: passWord);
    // 有缓存时初始化按钮可用状态
    _checkInput();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [..._backGround(), _content()]));
  }

  List<Widget> _backGround() {
    return [
      Positioned.fill(child: Image.asset("images/asd.jpg", fit: BoxFit.cover)),
      Positioned.fill(
        child: Container(decoration: BoxDecoration(color: Colors.black54)),
      ),
    ];
  }

  Widget _content() {
    return Positioned.fill(
      left: 25,
      right: 25,
      child: ListView(
        children: [
          hiSpace(height: 100),
          Text("账号密码登录", style: TextStyle(color: Colors.white, fontSize: 26)),
          hiSpace(height: 40),
          InputWidget(
            controller: _userNameController,
            hint: "请输入账号",
            onChanged: (text) {
              userName = text;
              print("userName: $userName");
              _checkInput();
            },
          ),
          hiSpace(height: 40),
          InputWidget(
            controller: _passWordController,
            hint: "请输入密码",
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            onChanged: (text) {
              passWord = text;
              print("passWord: $passWord");
              _checkInput();
            },
          ),
          hiSpace(height: 40),
          LoginButton("登录", enable: loginEnable, onPressed: () => _login()),
          hiSpace(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onLongPress: () => {print("注册账号,onLongPress")},
              onTap: () => {print("注册账号,onTap"), _jumpToRegister()},
              child: Text(
                "注册账号",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 输入检查
  void _checkInput() {
    bool enable;
    if (userName?.isNotEmpty == true && passWord?.isNotEmpty == true) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
      print("loginEnable： $loginEnable");
    });
  }

  /// 登录方法
  void _login() async {
    try {
      var result = await LoginDao.login(
        userName: userName ?? "",
        passWord: passWord ?? "",
      );
      if (result['data'] != null) {
        NavigatorUtil.pushHome(context);
      } else {
        debugPrint("登录失败：${result['errorMsg']}");
      }
    } catch (e) {
      debugPrint("登录异常：$e");
    }
  }

  /// 跳转到注册界面
  Future<void> _jumpToRegister() async {
    /*print("跳转到注册界面");
    Uri url = Uri.parse("https://www.baidu.com");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }*/
    LoginDao.register(userName ?? "", passWord ?? "");
  }
}
