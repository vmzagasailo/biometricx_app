import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Image.asset('assets/images/iphone13.jpg'),
          ),
          Text(title)
        ],
      ),
    );
  }
}
