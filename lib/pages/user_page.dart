import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zocbo/models/setting.dart';
import 'package:zocbo/models/user.dart';
import 'package:zocbo/services/info_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();
    User user = context.watch<InfoService>().user;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 64),
          CircleAvatar(backgroundColor: colorScheme.secondary, radius: 64),
          const SizedBox(height: 16),
          Text(
            "${user.firstName} ${user.lastName}",
            style: textTheme.headlineSmall,
          ),
          Text(
            user.email,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            icon: Icon(
              setting.brightness == Brightness.light
                  ? Icons.brightness_7
                  : Icons.brightness_2,
            ),
            label: Text(
              setting.brightness == Brightness.light
                  ? 'Light Mode'
                  : 'Dark Mode',
            ),
            onPressed: () => setting.changeBrightness(),
          ),
        ],
      ),
    );
  }
}
