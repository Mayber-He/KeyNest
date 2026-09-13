import 'package:flutter/material.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  double _length = 20;
  bool _uppercase = true;
  bool _lowercase = true;
  bool _numbers = true;
  bool _symbols = true;
  bool _avoidAmbiguous = false;

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('密码生成器')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('N8#kQ2!vT7@pL4xM', textAlign: TextAlign.center),
          ),
          ListTile(
              title: const Text('长度'), trailing: Text('${_length.round()}')),
          Slider(
              value: _length,
              min: 8,
              max: 32,
              divisions: 24,
              onChanged: (value) => setState(() => _length = value)),
          _option('大写字母', _uppercase,
              (value) => setState(() => _uppercase = value)),
          _option('小写字母', _lowercase,
              (value) => setState(() => _lowercase = value)),
          _option('数字', _numbers, (value) => setState(() => _numbers = value)),
          _option(
              '特殊符号', _symbols, (value) => setState(() => _symbols = value)),
          _option('避免易混淆字符', _avoidAmbiguous,
              (value) => setState(() => _avoidAmbiguous = value)),
          const SizedBox(height: 12),
          const Text('密码强度：强'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: FilledButton(
                      onPressed: () => _showFeedback('已复制'),
                      child: const Text('复制'))),
              const SizedBox(width: 12),
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {}, child: const Text('刷新'))),
            ],
          ),
          TextButton(
              onPressed: () => _showFeedback('已保存'),
              child: const Text('使用此密码')),
        ],
      ),
    );
  }

  Widget _option(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
        title: Text(label),
        value: value,
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero);
  }
}
