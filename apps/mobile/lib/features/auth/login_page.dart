import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('登录 KeyNest',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 24),
                const TextField(decoration: InputDecoration(labelText: '邮箱')),
                const SizedBox(height: 16),
                const TextField(
                    decoration: InputDecoration(labelText: '密码'),
                    obscureText: true),
                const SizedBox(height: 24),
                FilledButton(onPressed: () {}, child: const Text('登录')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
