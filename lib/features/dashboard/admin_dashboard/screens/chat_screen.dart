import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdmChatScreen extends StatelessWidget {
  const AdmChatScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        title: Text(title),
      ),
      body: const WebView(
        gestureNavigationEnabled: true,
        initialUrl: 'https://dashboard.tawk.to/login#/dashboard',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
