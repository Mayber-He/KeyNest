import 'package:flutter/material.dart';

class CreateVaultPage extends StatefulWidget {
  const CreateVaultPage({super.key});

  @override
  State<CreateVaultPage> createState() => _CreateVaultPageState();
}

class _CreateVaultPageState extends State<CreateVaultPage> {
  String _password = '';
  String _confirmation = '';

  @override
  Widget build(BuildContext context) {
    final mismatch = _confirmation.isNotEmpty && _password != _confirmation;
    final strength = _password.length < 8 ? '弱' : '强';
    return Scaffold(
      appBar: AppBar(title: const Text('创建保险库')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('设置主密码', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 24),
                TextField(
                  obscureText: true,
                  onChanged: (value) => setState(() => _password = value),
                  decoration: const InputDecoration(labelText: '主密码'),
                ),
                const SizedBox(height: 12),
                Text('密码强度：$strength'),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  onChanged: (value) => setState(() => _confirmation = value),
                  decoration: InputDecoration(
                    labelText: '确认主密码',
                    errorText: mismatch ? '两次输入的主密码不一致' : null,
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                    onPressed: mismatch ? null : () {},
                    child: const Text('继续')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
