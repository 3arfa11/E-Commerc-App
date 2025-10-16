import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        children: const [
          ListTile(title: Text('Account')),
          Divider(height: 0),
          ListTile(title: Text('Notifications')),
          Divider(height: 0),
          ListTile(title: Text('Privacy')),
        ],
      ),
    );
  }
}
