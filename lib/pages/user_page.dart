import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/models/setting.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Setting>(
      builder: (_, setting, __) => Center(
        child: IconButton(
          icon: Icon(
            setting.brightness == Brightness.light
                ? Icons.brightness_7
                : Icons.brightness_2,
          ),
          onPressed: () => setting.changeBrightness(),
        ),
      ),
    );
  }
}
