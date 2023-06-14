import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth_screen.dart';
import 'screens/recent_articles_screen.dart';
import 'screens/create_post_screen.dart';
import 'screens/personal_page.dart';

import 'providers/auth_provider.dart';
import 'providers/article_provider.dart';
import 'screens/success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => Articles()),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) {
          return MaterialApp(
              title: 'oopBopShbam',
              //TODO design theme
              home: RecentArticlesScreen(),
              // CreatePostScreen() //auth.isAuth ? RecentArticlesScreen() : AuthScreen(),
              routes: {
                PersonalPage.routeName: (ctx) => PersonalPage(),
              });
        },
      ),
    );
  }
}
