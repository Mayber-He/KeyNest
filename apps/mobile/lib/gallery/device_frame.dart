import 'package:flutter/material.dart';

class DeviceFrame extends StatelessWidget {
  const DeviceFrame({super.key, required this.child, this.width = 390});

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('product-frame'),
      width: width,
      constraints: const BoxConstraints(minHeight: 520, maxHeight: 680),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: const Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 8)),
        ],
      ),
      child: child,
    );
  }
}
