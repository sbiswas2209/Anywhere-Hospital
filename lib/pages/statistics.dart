import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class StatisticsPage extends StatelessWidget {
  static final String tag = 'statistics-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('India Statistics',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        child: WebviewScaffold(url: 'https://covid19angularharshit27.netlify.app'),
      ),
    );
  }
}