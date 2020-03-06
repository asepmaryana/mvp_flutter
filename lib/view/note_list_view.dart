import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {

  static const String routeName = '/note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Center(child: Text('Page Notes'))
    );
  }

}