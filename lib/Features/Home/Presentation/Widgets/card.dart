import 'package:flutter/material.dart';
import 'package:task/Features/Home/Presentation/Widgets/dialog.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.trailing,
      required this.isForked});
  final String title;
  final String subTitle;
  final String trailing;
  final bool isForked;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isForked ? Colors.white : Colors.green[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: Text(trailing),
        onLongPress: () {
          alertDialog(context);
        },
      ),
    );
  }
}
