import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  final String text;
  final bool flag;

  const appbar({Key? key, required this.text, required this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: flag,
      title: Text(text,
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          )),
      backgroundColor: Color(0xfff7fffb),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Color(0xff408c5d),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person,
            color: Color(0xff408c5d),
          ),
        ),
      ],
    );
  }
}
