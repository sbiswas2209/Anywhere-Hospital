import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class ChatbotPage extends StatelessWidget {
  static final String tag = 'chatbot-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baymax',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        child: WebviewScaffold(url: 'https://baymaxdoc.netlify.app/',),
      ),
    );
  }
}