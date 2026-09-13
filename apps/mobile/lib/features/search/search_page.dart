import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';
import '../../shared/widgets/vault_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text.toLowerCase();
    final items = demoVaultItems.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.subtitle.contains(query);
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('搜索')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: '搜索密码库',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                    ),
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => VaultListTile(item: item)),
        ],
      ),
    );
  }
}
