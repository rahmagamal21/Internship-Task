import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.trailing,
      required this.isForked,
      required this.ownerLink,
      required this.repoLink});
  final String title;
  final String subTitle;
  final String trailing;
  final bool isForked;
  final String ownerLink;
  final String repoLink;

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

  void alertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (contex) {
        return AlertDialog(
          title: const Text('Want to open repository URL or owner URL?'),
          content: const Text("Choose an option below:"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                launchURL(repoLink);
              },
              child: const Text('Repo URL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                launchURL(ownerLink);
              },
              child: const Text('Owner URL'),
            ),
          ],
        );
      },
    );
  }

  void launchURL(String url) async {
    if (await canLaunchUrl(
      Uri.file(url),
    )) {
      await launchUrl(
        Uri.file(url),
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
