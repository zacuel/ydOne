import 'package:flutter/material.dart';
import './create_post_screen.dart';

class PersonalPage extends StatelessWidget {
  static const routeName = '/personal-page';
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.tag_faces_sharp),
        title: Text("your page"),
        actions: [Icon(Icons.videogame_asset_outlined)],
      ),
      body: Column(children: [
        Text("articles user has upvoted goes here"),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CreatePostScreen();
                },
              ));
            },
            child: Text("Create New Article")),
        ListTile(
          leading: Icon(Icons.newspaper),
          title: Text("go to news"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {},
        ),
      ]),
    );
  }
}
