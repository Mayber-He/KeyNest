import 'package:flutter/material.dart';

import '../features/generator/generator_page.dart';
import '../features/home/home_page.dart';
import '../features/settings/settings_page.dart';
import '../features/vault/vault_page.dart';
import '../shared/widgets/app_bottom_navigation.dart';
import 'device_frame.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyNest 界面概览'),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: DeviceFrame(
                child: Column(
                  children: [
                    Expanded(child: _ProductPage(index: _selectedIndex)),
                    AppBottomNavigation(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() => _selectedIndex = index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProductPage extends StatelessWidget {
  const _ProductPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const HomePage(),
      1 => const VaultPage(),
      2 => const GeneratorPage(),
      3 => const SettingsPage(),
      _ => const HomePage(),
    };
  }
}
