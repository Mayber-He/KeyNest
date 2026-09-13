import 'package:flutter/material.dart';

class UnlockPage extends StatelessWidget {
  const UnlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('解锁 KeyNest',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              const TextField(
                  decoration: InputDecoration(labelText: '主密码'),
                  obscureText: true),
              const SizedBox(height: 20),
              FilledButton(onPressed: () {}, child: const Text('解锁')),
              TextButton(onPressed: () {}, child: const Text('使用生物识别')),
            ],
          ),
        ),
      ),
    );
  }
}
