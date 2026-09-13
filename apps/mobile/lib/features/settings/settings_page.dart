import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _saved(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('已保存')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          const _SettingsGroup(title: '账户', children: [
            ListTile(title: Text('账户信息'), trailing: Icon(Icons.chevron_right)),
            ListTile(title: Text('同步状态'), subtitle: Text('同步完成')),
          ]),
          const _SettingsGroup(title: '安全', children: [
            ListTile(title: Text('更改主密码'), trailing: Icon(Icons.chevron_right)),
            ListTile(
                title: Text('生物识别解锁'),
                trailing: Switch(value: true, onChanged: null)),
          ]),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
                onPressed: () => _saved(context), child: const Text('保存设置')),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(title)),
        ...children,
      ],
    );
  }
}
