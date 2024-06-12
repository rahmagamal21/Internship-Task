import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.blueGrey,
      thickness: 2,
      indent: 50,
      endIndent: 50,
    );
  }
}
