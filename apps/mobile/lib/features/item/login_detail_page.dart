import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';
import '../../shared/widgets/sensitive_field.dart';

class LoginDetailPage extends StatelessWidget {
  const LoginDetailPage({super.key, required this.item});

  final DemoVaultItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(item.subtitle),
          const SizedBox(height: 20),
          const SensitiveField(label: '密码', value: 'demo-login-password'),
        ],
      ),
    );
  }
}
