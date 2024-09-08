import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  const TaskButton({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed,
        child: Text(title, style: const TextStyle(color: Color.fromARGB(255, 71, 24, 173)),));
  }
}