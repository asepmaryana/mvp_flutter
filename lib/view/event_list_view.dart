import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {

  static const String routeName = '/event';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: Center(child: Text('Page Events'))
    );
  }

}