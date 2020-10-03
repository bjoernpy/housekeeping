import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 20),
            child: Divider(height: 60, thickness: 2),
          ),
        ),
        Text(
          "OR",
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 20),
            child: Divider(height: 60, thickness: 2),
          ),
        ),
      ],
    );
  }
}
