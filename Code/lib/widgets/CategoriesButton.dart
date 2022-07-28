import 'package:flutter/material.dart';

class CategoriesButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final double Height;
  final double Width;
  final VoidCallback onPressed;


  const CategoriesButton({Key? key, required this.text, required this.icon, required this.Height, required this.Width, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Height,
        width: Width,
        child: RaisedButton.icon(
            color: const Color(0xffebebeb),
            onPressed: onPressed,
            icon: icon,
            label: Text(text),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
        )
        ),
    );
  }
}
