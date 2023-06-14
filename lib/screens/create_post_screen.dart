import 'package:flutter/material.dart';
import './create_content_screen.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/create-post';
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  bool _isOriginal = true;
  String? _contentUrl;
  String _exciteLine = 'Check this Out!';

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateContentScreen(
            title: _title, isOriginal: _isOriginal, exciteLine: _exciteLine)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s Create Content'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'What is the title of your posting?'),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'please provide a title';
                } else {
                  return null;
                }
              },
              onSaved: (theTitle) => _title = theTitle!,
            ),
            RadioListTile<bool>(
                title: Text(
                    "this is original material not necessarily associated with a pre-existing internet article."),
                value: true,
                groupValue: _isOriginal,
                onChanged: (value) {
                  setState(() {
                    _isOriginal = value!;
                  });
                }),
            RadioListTile<bool>(
                title: Text(
                    "this is primarily a pre-existing internet article that I want to highlight for the community."),
                value: false,
                groupValue: _isOriginal,
                onChanged: (value) {
                  setState(() {
                    _isOriginal = value!;
                  });
                }),
            TextFormField(
              initialValue: _exciteLine,
              decoration: InputDecoration(
                  labelText: 'please enter an exciting subtitle'),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'this is required';
                } else {
                  return null;
                }
              },
              onSaved: (value) => _exciteLine = value!,
            ),
            ElevatedButton(onPressed: _submit, child: Text("Next Section"))
          ],
        ),
      ),
    );
  }
}
