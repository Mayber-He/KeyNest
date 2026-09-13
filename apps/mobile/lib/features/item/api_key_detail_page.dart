import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';
import '../../shared/widgets/sensitive_field.dart';

class ApiKeyDetailPage extends StatelessWidget {
  const ApiKeyDetailPage({super.key, required this.item});

  final DemoVaultItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SensitiveField(label: 'API Key', value: item.value),
      ),
    );
  }
}
