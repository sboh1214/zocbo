import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zocbo/services/auth_service.dart';
import 'package:zocbo/utils/url.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Material(
        child: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    const AUTHORITY = 'otl.kaist.ac.kr';
    Map<String, dynamic> query = {'next': baseUrl};
    if (Platform.isIOS) {
      query['social_login'] = '0';
    }

    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: _isVisible,
      child: WebView(
        initialUrl: Uri.https(AUTHORITY, '/session/login/', query).toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (url) {
          if (Uri.parse(url).authority == AUTHORITY) {
            setState(() {
              _isVisible = false;
            });
          }
        },
        onPageFinished: (url) {
          String authority = Uri.parse(url).authority;
          if (authority == AUTHORITY) {
            context.read<AuthService>().authenticate('https://$AUTHORITY');
          } else if (authority == 'sparcssso.kaist.ac.kr') {
            setState(() {
              _isVisible = true;
            });
          } else {
            setState(() {
              _isVisible = true;
            });
          }
        },
      ),
    );
  }
}
