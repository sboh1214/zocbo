import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../utils/api.dart';

class AuthService extends ChangeNotifier {
  bool _isLogined = false;
  bool get isLogined => _isLogined;

  Future<void> authenticate(String url) async {
    try {
      final cookieManager = WebviewCookieManager();
      final cookies = await cookieManager.getCookies(url);
      API().authenticate(cookies);
      _isLogined = true;
      notifyListeners();
    } catch (exception) {
      print(exception);
    }
  }
}
