import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';

class VaultListTile extends StatelessWidget {
  const VaultListTile({super.key, required this.item});

  final DemoVaultItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 64,
      leading: CircleAvatar(child: Text(item.name.substring(0, 1))),
      title: Text(item.name),
      subtitle: Text('${item.type} · ${item.subtitle}'),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
