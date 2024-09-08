import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TailingText extends StatelessWidget {
  final String title;
  final String converterTitle;
  final VoidCallback onTapCall;
  const TailingText({super.key, required this.title, required this.converterTitle, required this.onTapCall});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text:  TextSpan(style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(text: title, style: const TextStyle(color: Colors.grey)),
              TextSpan(text: converterTitle,
                  style:
                  const TextStyle(color: Color.fromARGB(255, 71, 24, 173)),
                  recognizer: TapGestureRecognizer()..onTap = (){
                    onTapCall();
                  }
              )
            ])
    );
  }
}
