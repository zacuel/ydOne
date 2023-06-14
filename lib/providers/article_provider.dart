import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Article with ChangeNotifier {
  //TODO add locale
  final String id;
  final String title;
  final String exciteLine;
  final bool isOriginal;
  final String? articleUrl;
  final String? content;
  final DateTime creationDate;

  Article({
    required this.id,
    required this.title,
    this.exciteLine = "Check This Out!",
    required this.isOriginal,
    this.articleUrl,
    this.content,
    required this.creationDate,
  });
}

class Articles with ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles {
    return [..._articles];
  }

  List<Article> get recentArticles {
    List<Article> orderedList = [..._articles];
    orderedList.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    // List<Article> sortedList = orderedList.reversed as List<Article>;
    return orderedList.reversed.toList();
  }

  Future<void> fetchAndSetArticles() async {
    final url = Uri.parse(
        'https://ydtwo-8550b-default-rtdb.firebaseio.com/articles.json');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      if (data == null) {
        return;
      }
      final extractedData = data as Map<String, dynamic>;
      final List<Article> loadedArticles = [];
      extractedData.forEach((articleId, articleData) {
        loadedArticles.add(Article(
          id: articleId,
          title: articleData['title'],
          creationDate: DateTime.parse(articleData['creationDate']),
          isOriginal: articleData['url'] == null,
          articleUrl: articleData['url'] ?? null,
          content: articleData['content'] ?? null,
          exciteLine: articleData['exciteLine'],
        ));
      });
      _articles = loadedArticles;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createArticle(Article article) async {
    final url = Uri.parse(
        'https://ydtwo-8550b-default-rtdb.firebaseio.com/articles.json');
    try {
      var response;
      if (article.isOriginal) {
        response = await http.post(
          url,
          body: json.encode({
            'creationDate': article.creationDate.toIso8601String(),
            'title': article.title,
            'exciteLine': article.exciteLine,
            'content': article.content,
          }),
        );
      } else if (article.content != null) {
        response = await http.post(
          url,
          body: json.encode({
            'creationDate': article.creationDate.toIso8601String(),
            'title': article.title,
            'exciteLine': article.exciteLine,
            'content': article.content,
            'url': article.articleUrl,
          }),
        );
      } else {
        response = await http.post(url,
            body: json.encode({
              'creationDate': article.creationDate.toIso8601String(),
              'title': article.title,
              'exciteLine': article.exciteLine,
              'url': article.articleUrl
            }));
      }
      final newArticle = Article(
        title: article.title,
        exciteLine: article.exciteLine,
        content: article.content ?? null,
        isOriginal: article.articleUrl == null,
        articleUrl: article.articleUrl ?? null,
        creationDate: article.creationDate,
        id: json.decode(response.body)['name'],
      );
      _articles.add(newArticle);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
