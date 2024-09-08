import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final String? Function(String?)? validate;
  final bool hidePass;
  final Widget? suffixIcon;
  final TextEditingController controller;
  const MyTextFormField({super.key, required this.labelText, required this.focusNode, this.validate, this.hidePass = false, this.suffixIcon, required this.controller});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 71, 24, 173), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        style: const TextStyle(color: Color.fromARGB(255, 71, 24, 173),
            fontWeight: FontWeight.bold, fontSize: 20),
        validator: validate,
        obscureText: hidePass,
        controller: controller,
      ),
    );
  }
}
