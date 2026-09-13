import 'package:flutter/material.dart';

import '../../demo/demo_data.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final Set<String> _revoked = {};

  Future<void> _revoke(DemoDevice device) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认撤销设备访问？'),
        content: Text('撤销 ${device.name} 后，该设备将无法继续访问保险库。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('确认撤销')),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      setState(() => _revoked.add(device.name));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('访问已撤销')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设备管理')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: demoDevices.map((device) {
          final revoked = _revoked.contains(device.name);
          return Card(
            child: ListTile(
              leading: Icon(
                  device.isCurrent ? Icons.phone_iphone : Icons.laptop_mac),
              title: Text(device.name),
              subtitle: Text(revoked ? '已撤销' : device.lastSeen),
              trailing: device.isCurrent || revoked
                  ? null
                  : TextButton(
                      onPressed: () => _revoke(device),
                      child: const Text('撤销访问')),
            ),
          );
        }).toList(),
      ),
    );
  }
}
