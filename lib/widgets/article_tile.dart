import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget {
  final String title;
  final String exciteLine;
  const ArticleTile({super.key, required this.title, required this.exciteLine});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.ramen_dining),
      title: Text(title),
      subtitle: Text(exciteLine),
      onTap: () {},
    );
  }
}
