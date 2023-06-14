import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_tile.dart';
import './personal_page.dart';

class RecentArticlesScreen extends StatefulWidget {
  static const routeName = '/recent-articles';
  const RecentArticlesScreen({super.key});

  @override
  State<RecentArticlesScreen> createState() => _RecentArticlesScreenState();
}

class _RecentArticlesScreenState extends State<RecentArticlesScreen> {
  //TODO shouldn't I only load articles list once?
  @override
  void initState() {
    super.initState();
    Provider.of<Articles>(context, listen: false).fetchAndSetArticles();
  }

  @override
  Widget build(BuildContext context) {
    final pageArticles = Provider.of<Articles>(context).recentArticles;
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Articles"),
        leading: GestureDetector(
          onTap: () =>
              Navigator.of(context).popAndPushNamed(PersonalPage.routeName),
          child: Row(
            //TODO back button is confusing
            children: [Icon(Icons.arrow_back), Icon(Icons.tag_faces_sharp)],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ...pageArticles.map((article) {
            return ArticleTile(
              title: article.title,
              exciteLine: article.exciteLine,
            );
          }),
        ],
      )),
    );
  }
}
