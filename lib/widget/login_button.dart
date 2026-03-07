import 'package:flutter/material.dart';

/// 登录按钮
class LoginButton extends StatelessWidget {
  const LoginButton(
    this.title, {
    super.key,
    this.enable = true,
    this.onPressed,
  });

  final String? title;
  final bool? enable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enable ?? false ? onPressed : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6),
      ),
      height: 45,
      disabledColor: Colors.white60,
      color: Colors.orange,
      child: Text(title ?? "", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w200),),
    );
  }
}
