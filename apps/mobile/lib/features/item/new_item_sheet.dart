import 'package:flutter/material.dart';

void showNewItemSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const NewItemSheet(),
  );
}

class NewItemSheet extends StatelessWidget {
  const NewItemSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('新建条目', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: '名称')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: '用户名')),
          const SizedBox(height: 16),
          FilledButton(
              onPressed: () => Navigator.pop(context), child: const Text('保存')),
        ],
      ),
    );
  }
}
