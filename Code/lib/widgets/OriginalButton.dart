import 'package:flutter/material.dart';

class OriginalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double Height;
  final double Width;
  final double font;


  const OriginalButton({Key? key, required this.text, required this.onPressed, required this.Height, required this.Width, required this.font}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Height,
      width: Width,
      child: RaisedButton(
        color: Color(0xffff66624),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text,
          style: TextStyle(color: Colors.white, fontSize: font),
        ),
      ),
    );
  }
}
