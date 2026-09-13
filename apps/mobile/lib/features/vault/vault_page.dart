import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';
import '../../shared/widgets/vault_list_tile.dart';
import '../item/new_item_sheet.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  String _filter = '全部';

  @override
  Widget build(BuildContext context) {
    final items = _filter == '全部'
        ? demoVaultItems
        : demoVaultItems.where((item) => item.type == _filter).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('密码库')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            children: ['全部', '登录', 'API Key'].map((filter) {
              return ChoiceChip(
                label: Text(filter),
                selected: _filter == filter,
                onSelected: (_) => setState(() => _filter = filter),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => VaultListTile(item: item)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewItemSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
