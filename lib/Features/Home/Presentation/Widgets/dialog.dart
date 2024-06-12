import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              //launchURL(repo.repoUrl);
            },
            child: const Text('Repo URL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              //launchURL(repo.ownerUrl);
            },
            child: const Text('Owner URL'),
          ),
        ],
      );
    },
  );
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
