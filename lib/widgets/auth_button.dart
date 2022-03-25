import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    @required this.title,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: ElevatedButton(
        style:
            ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(15))),
        onPressed:  onPressed,
        child: Text('Увійти з допомогою $title'),
      ),
    );
  }
}
