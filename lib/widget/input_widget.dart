import 'package:flutter/material.dart';

/// 登录输入框，自定义widget
class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    this.hint,
    this.obscureText,
    this.controller,
    this.onChanged,
    this.keyboardType,
  });

  final String? hint;
  final bool? obscureText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        Divider(color: Colors.white, height: 1, thickness: 1),
      ],
    );
  }

  Widget _input() {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      autocorrect: obscureText ?? false,
      cursorColor: Colors.white,
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }
}
