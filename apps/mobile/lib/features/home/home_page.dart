import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';
import '../../shared/widgets/sync_status.dart';
import '../../shared/widgets/vault_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KeyNest')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('下午好', style: Theme.of(context).textTheme.headlineMedium),
          const Text('你的密钥都在这里'),
          const SizedBox(height: 16),
          const SyncStatus(),
          const SizedBox(height: 20),
          const SearchBar(hintText: '搜索密码库', leading: Icon(Icons.search)),
          const SizedBox(height: 20),
          Text('最近使用', style: Theme.of(context).textTheme.titleMedium),
          ...demoVaultItems.map((item) => VaultListTile(item: item)),
        ],
      ),
    );
  }
}
