import 'package:flutter/material.dart';

class RecoveryKeyPage extends StatefulWidget {
  const RecoveryKeyPage({super.key});

  @override
  State<RecoveryKeyPage> createState() => _RecoveryKeyPageState();
}

class _RecoveryKeyPageState extends State<RecoveryKeyPage> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('恢复密钥')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('保存你的恢复密钥', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE4E7EC)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const SelectableText('KNSR-7F3A-2D91-8C44'),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _confirmed,
              onChanged: (value) => setState(() => _confirmed = value ?? false),
              title: const Text('我已安全保存'),
              contentPadding: EdgeInsets.zero,
            ),
            const Spacer(),
            FilledButton(
              onPressed: _confirmed ? () {} : null,
              child: const Text('确认已保存'),
            ),
          ],
        ),
      ),
    );
  }
}
