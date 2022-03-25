import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  const PageButton({Key key, @required this.title, @required this.onTap})
      : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title, style: TextStyle(fontSize: 20)),
    );
  }
}
