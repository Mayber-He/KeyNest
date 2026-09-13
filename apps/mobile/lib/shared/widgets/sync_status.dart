import 'package:flutter/material.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({super.key, this.label = '同步完成'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cloud_done_outlined, size: 18, color: Colors.green.shade700),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
